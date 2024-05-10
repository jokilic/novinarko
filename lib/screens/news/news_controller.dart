import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/feed_search_model.dart';
import '../../models/novinarko_rss_feed.dart';
import '../../models/novinarko_rss_item.dart';
import '../../rss_parser/models/rss_feed.dart';
import '../../services/active_feed_service.dart';
import '../../services/api_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/parsing.dart';
import 'news_state.dart';

class NewsController extends ValueNotifier<NewsState> {
  final LoggerService logger;
  final APIService api;
  final HiveService hive;
  final ActiveFeedService activeFeedService;

  NewsController({
    required this.logger,
    required this.api,
    required this.hive,
    required this.activeFeedService,
  }) : super(NewsStateInitial()) {
    loadFeed(activeFeedService.value);
  }

  ///
  /// INIT
  ///

  Future<void> init() async {
    /// [Timeago] formatting
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('hr', timeago.HrMessages());
  }

  ///
  /// METHODS
  ///

  /// Loads a new `feed` or all feeds if `null` is passed
  Future<void> loadFeed(FeedSearchModel? newFeed) async {
    /// `feed` is passed
    if (newFeed != null) {
      await loadSingleFeed(feed: newFeed);
    }

    /// `null` is passed
    if (newFeed == null) {
      await loadAllFeeds();
    }
  }

  Future<void> pullToRefresh(FeedSearchModel? activeFeed) async {
    /// `activeFeed` exists, fetch and parse it
    if (activeFeed != null) {
      await loadSingleFeed(
        feed: activeFeed,
        useLoadingState: false,
      );
    }

    /// No `activeFeed`, fetch and parse all `feeds`
    else {
      await loadAllFeeds(useLoadingState: false);
    }
  }

  /// This will fetch and parse single `feed`
  Future<void> loadSingleFeed({
    required FeedSearchModel feed,
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

  /// This will fetche and parse all `feeds`
  Future<void> loadAllFeeds({bool useLoadingState = true}) async {
    /// No values in [Hive], set state to [NewsStateEmpty]
    if (hive.value.isEmpty) {
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
    final futures = hive.value.map(fetchAndParseFeedItems).toList();

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
  Future<({List<NovinarkoRssItem>? items, String? error})> fetchAndParseFeedItems(FeedSearchModel feed) async {
    /// Feed `url` is `null`
    if (feed.url == null) {
      final error = 'News -> fetchAndParseFeedItems -> ${feed.url} -> feed url is null';
      logger.e(error);
      return (items: null, error: error);
    }

    try {
      /// Fetch `feedURL`
      final response = await api.getRSSFeed(url: feed.url!);

      /// Fetching successful
      if (response.data != null && response.error == null) {
        /// Parse `feedURL`
        final parsedFeed = RssFeed.parse(response.data);

        final items = parsedFeed.items
            .map(
              (item) => NovinarkoRssItem(
                favicon: feed.favicon,
                title: item.title,
                imageUrl: item.enclosure?.url ?? item.content?.images.first,
                feedTitle: feed.siteName ?? feed.title,
                description: item.description,
                link: item.link,
                guid: item.guid,
                pubDate: parsePubDate(item.pubDate),
              ),
            )
            .toList()
          ..sort((a, b) {
            final firstDate = b.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);
            final secondDate = a.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);

            return firstDate.compareTo(secondDate);
          });

        return (items: items, error: null);
      }

      /// Fetching is not successful
      else if (response.data == null && response.error != null) {
        final error = 'News -> fetchAndParseFeedItems -> ${feed.url} -> error from response -> ${response.error}';
        logger.e(error);
        return (items: null, error: error);
      }

      /// Some weird error
      else {
        final error = 'News -> fetchAndParseFeedItems -> ${feed.url} -> some weird error';
        logger.e(error);
        return (items: null, error: error);
      }
    } catch (e) {
      final error = 'News -> fetchAndParseFeedItems -> ${feed.url} -> catch -> $e';
      logger.e(error);
      return (items: null, error: error);
    }
  }

  /// Fetches and parses single `feed`, retunrs `NovinarkoRssFeed`
  /// Used when fetching one `item` and then using it in `NewsStateSingleSuccess`
  Future<({NovinarkoRssFeed? rssFeed, String? error})> fetchAndParseFeed(FeedSearchModel feed) async {
    /// Feed `url` is `null`
    if (feed.url == null) {
      final error = 'News -> fetchAndParseFeed -> ${feed.url} -> feed url is null';
      logger.e(error);
      return (rssFeed: null, error: error);
    }

    try {
      /// Fetch `feedURL`
      final response = await api.getRSSFeed(url: feed.url!);

      /// Fetching successful
      if (response.data != null && response.error == null) {
        /// Parse `feedURL`
        final parsedFeed = RssFeed.parse(response.data);

        final rssFeed = NovinarkoRssFeed(
          siteName: feed.siteName,
          title: parsedFeed.title,
          description: parsedFeed.description,
          items: parsedFeed.items
              .map(
                (item) => NovinarkoRssItem(
                  favicon: feed.favicon,
                  title: item.title,
                  imageUrl: item.enclosure?.url ?? item.content?.images.first,
                  feedTitle: feed.siteName ?? feed.title,
                  description: item.description,
                  link: item.link,
                  guid: item.guid,
                  pubDate: parsePubDate(item.pubDate),
                ),
              )
              .toList()
            ..sort((a, b) {
              final firstDate = b.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);
              final secondDate = a.pubDate ?? DateTime.fromMillisecondsSinceEpoch(0);

              return firstDate.compareTo(secondDate);
            }),
        );

        return (rssFeed: rssFeed, error: null);
      }

      /// Fetching is not successful
      else if (response.data == null && response.error != null) {
        final error = 'News -> fetchAndParseFeed -> ${feed.url} -> error from response -> ${response.error}';
        logger.e(error);
        return (rssFeed: null, error: error);
      }

      /// Some weird error
      else {
        final error = 'News -> fetchAndParseFeed -> ${feed.url} -> some weird error';
        logger.e(error);
        return (rssFeed: null, error: error);
      }
    } catch (e) {
      final error = 'News -> fetchAndParseFeed -> ${feed.url} -> catch -> $e';
      logger.e(error);
      return (rssFeed: null, error: error);
    }
  }
}
