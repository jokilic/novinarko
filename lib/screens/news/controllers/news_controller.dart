import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rss_dart/dart_rss.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/feed_model.dart';
import '../../../models/novinarko_rss_feed.dart';
import '../../../models/novinarko_rss_item.dart';
import '../../../services/active_feed_folder_service.dart';
import '../../../services/api_service.dart';
import '../../../services/hive_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/parsing.dart';
import '../news_state.dart';

class NewsController extends ValueNotifier<NewsState> {
  final LoggerService logger;
  final APIService api;
  final HiveService hive;
  final ActiveFeedFolderService activeFeedFolder;

  NewsController({
    required this.logger,
    required this.api,
    required this.hive,
    required this.activeFeedFolder,
  }) : super(NewsStateInitial()) {
    refreshActiveFeeds(
      useLoadingState: true,
    );
  }

  ///
  /// INIT
  ///

  void init() {
    /// [Timeago] formatting
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('hr', timeago.HrMessages());
  }

  ///
  /// METHODS
  ///

  /// Loads a new `feed` or all feeds if `null` is passed
  Future<void> loadFeed(FeedModel? newFeed) async {
    /// `feed` is passed
    if (newFeed != null) {
      await loadSingleFeed(feed: newFeed);
    }

    /// `null` is passed
    if (newFeed == null) {
      await loadAllFeeds();
    }
  }

  Future<void> refreshActiveFeeds({bool useLoadingState = false}) async {
    final activeFeed = activeFeedFolder.value?.feed;
    final activeFolder = activeFeedFolder.value?.folder;

    final activeFolderFeeds = activeFolder?.feeds ?? const <FeedModel>[];

    /// `activeFeed` exists, fetch and parse it
    if (activeFeed != null) {
      await loadSingleFeed(
        feed: activeFeed,
        useLoadingState: useLoadingState,
      );
    }
    /// `activeFolder` exists, fetch and parse all feeds from it
    else if (activeFolder != null) {
      await loadAllFeeds(
        passedFeeds: activeFolderFeeds,
        useLoadingState: useLoadingState,
      );
    }
    /// No `activeFeed`, fetch and parse all `feeds`
    else {
      await loadAllFeeds(
        useLoadingState: useLoadingState,
      );
    }
  }

  /// This will fetch and parse single `feed`
  Future<void> loadSingleFeed({
    required FeedModel feed,
    bool useLoadingState = true,
  }) async {
    /// Loading state
    if (useLoadingState) {
      value = NewsStateLoading(
        loadingStatus: 'newsStateLoadingSingle'.tr(
          args: [
            getFeedTitle(feed) ?? 'newsAllFeedsTitle'.tr(),
          ],
        ),
      );
    }

    /// Fetches and parses feed, returns `NovinarkoRssFeed` or `error`
    final parsedFeed = await fetchAndParseFeed(feed);

    /// Success state
    value = NewsStateSingleSuccess(
      result: parsedFeed,
    );
  }

  /// This will fetch and parse all `feeds`
  Future<void> loadAllFeeds({
    List<FeedModel>? passedFeeds,
    bool useLoadingState = true,
  }) async {
    final feedsToLoad = passedFeeds ?? hive.value.feeds;

    /// No values in [Hive], set state to [NewsStateEmpty]
    if (feedsToLoad.isEmpty) {
      value = NewsStateEmpty();
      return;
    }

    /// Loading state
    if (useLoadingState) {
      value = NewsStateLoading(
        loadingStatus: 'newsStateLoadingAll'.tr(),
      );
    }

    /// Fetches and parses all feeds, returns `List<NovinarkoRssItem>` or `error`
    final futures = feedsToLoad.map(fetchAndParseFeedItems).toList();

    /// Run tasks concurrently
    final results = await Future.wait(futures);

    /// Declare an empty `List<NovinarkoRssItem>`
    final allItems = <NovinarkoRssItem>[];

    /// Go through all results and get all successfully parsed `List<NovinarkoRssItem>`
    results.map((result) {
      /// Result is successfully parsed, add `items` to `allItems` list
      if (result.items != null && result.error == null) {
        allItems.addAll(result.items!);
      }
      /// Result returned an `error`
      else if (result.items == null && result.error != null) {
        final error = 'News -> loadAllFeeds -> result returned an error -> ${result.error}';
        logger.e(error);
      }
      /// Some weird error
      else {
        const error = 'News -> loadAllFeeds -> some weird error';
        logger.e(error);
      }
    }).toList();

    /// Sort `allItems`
    allItems.sort((a, b) {
      final firstDate = b.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      final secondDate = a.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);

      return firstDate.compareTo(secondDate);
    });

    /// Success state
    value = NewsStateAllSuccess(
      result: (
        rssFeed: NovinarkoRssFeed(
          title: 'newsAllFeedsTitle'.tr(),
          items: allItems,
        ),
        error: null,
      ),
    );
  }

  /// Fetches and parses single `feed`, retunrs `List<NovinarkoRssItem>`
  /// Used when fetching all `items` and then using them in `NewsStateAllSuccess`
  Future<({List<NovinarkoRssItem>? items, String? error})> fetchAndParseFeedItems(FeedModel feed) async {
    final result = await fetchAndParseFeed(feed);

    if (result.rssFeed != null) {
      return (items: result.rssFeed!.items, error: null);
    } else {
      return (items: null, error: result.error);
    }
  }

  /// Fetches and parses single `feed`, retunrs `NovinarkoRssFeed`
  Future<({NovinarkoRssFeed? rssFeed, String? error})> fetchAndParseFeed(FeedModel feed) async {
    /// Feed `url` is `null`
    if (feed.url == null) {
      final error = 'News -> fetchAndParseLogic -> ${feed.url} -> feed url is null';
      logger.e(error);
      return (rssFeed: null, error: error);
    }

    try {
      /// Fetch `feedURL`
      final response = await api.getRSSFeed(url: feed.url!);

      /// Fetching successful
      if (response.data != null && response.error == null) {
        /// RSS parsing
        try {
          /// Parse `feedURL`
          final parsedFeed = RssFeed.parse(response.data!);

          /// Generate `rawContents`, needed to parse `imageUrl` in some feeds
          final rawContents = parseContentsFromXml(response.data!);

          final rssFeed = NovinarkoRssFeed(
            siteName: feed.siteName,
            title: parsedFeed.title,
            description: parsedFeed.description,
            items:
                parsedFeed.items.indexed.map(
                  (pair) {
                    final index = pair.$1;
                    final item = pair.$2;

                    /// Use `rawContent` if available and `index` matches
                    final rawContent = index < rawContents.length ? rawContents[index] : item.content?.value;

                    return NovinarkoRssItem(
                      favicon: feed.favicon,
                      title: item.title ?? item.media?.title?.value,
                      imageUrl: getRSSImageUrl(
                        item: item,
                        rawContent: rawContent,
                      ),
                      feedTitle: feed.siteName ?? feed.title,
                      description: item.description ?? item.content?.value ?? item.media?.description?.value,
                      link: item.link,
                      guid: item.guid,
                      pubDate: parsePubDate(item.pubDate),
                    );
                  },
                ).toList()..sort(
                  (a, b) {
                    final firstDate = b.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);
                    final secondDate = a.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);

                    return firstDate.compareTo(secondDate);
                  },
                ),
          );

          return (rssFeed: rssFeed, error: null);
        }
        /// RSS parsing failed, try Atom parsing
        catch (_) {
          try {
            final parsedFeed = AtomFeed.parse(response.data!);

            final rssFeed = NovinarkoRssFeed(
              siteName: feed.siteName,
              title: parsedFeed.title,
              description: parsedFeed.subtitle,
              items:
                  parsedFeed.items
                      .map(
                        (item) => NovinarkoRssItem(
                          favicon: feed.favicon,
                          title: item.title ?? item.media?.title?.value,
                          imageUrl: getAtomImageUrl(item: item),
                          feedTitle: feed.siteName ?? feed.title,
                          description: item.content ?? item.summary ?? item.media?.description?.value,
                          link: getAtomLink(item),
                          guid: item.id,
                          pubDate: parsePubDate(
                            item.updated ?? item.published,
                          ),
                        ),
                      )
                      .toList()
                    ..sort(
                      (a, b) {
                        final firstDate = b.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);
                        final secondDate = a.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);

                        return firstDate.compareTo(secondDate);
                      },
                    ),
            );

            return (rssFeed: rssFeed, error: null);
          } catch (atomError) {
            rethrow;
          }
        }
      }
      /// Fetching is not successful
      else if (response.data == null && response.error != null) {
        final error = 'News -> fetchAndParseLogic -> ${feed.url} -> error from response -> ${response.error}';
        logger.e(error);
        return (rssFeed: null, error: error);
      }
      /// Some weird error
      else {
        final error = 'News -> fetchAndParseLogic -> ${feed.url} -> some weird error';
        logger.e(error);
        return (rssFeed: null, error: error);
      }
    } catch (e) {
      final error = 'News -> fetchAndParseLogic -> ${feed.url} -> catch -> $e';
      logger.e(error);
      return (rssFeed: null, error: error);
    }
  }
}
