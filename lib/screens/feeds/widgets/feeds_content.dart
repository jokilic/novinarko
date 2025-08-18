import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/feed_search_model.dart';
import '../../../services/active_feed_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../util/sentry.dart';
import '../../news/controllers/news_controller.dart';
import 'feeds_list_tile.dart';

class FeedsContent extends StatelessWidget {
  final FeedSearchModel? activeFeed;
  final List<FeedSearchModel> feeds;
  final Function(int oldIndex, int newIndex) onReorder;
  final String fontFamily;

  const FeedsContent({
    required this.activeFeed,
    required this.feeds,
    required this.onReorder,
    required this.fontFamily,
  });

  /// Loads passed `feed` and dismisses screen
  void loadFeedAndPop(BuildContext context, FeedSearchModel? feed) {
    getIt.get<ActiveFeedService>().updateActiveFeed(feed);

    if (getIt.isRegistered<NewsController>()) {
      getIt.get<NewsController>().loadFeed(feed);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.fromLTRB(8, MediaQuery.paddingOf(context).top, 8, 8),
    physics: const BouncingScrollPhysics(),
    children: [
      ///
      /// ALL FEEDS
      ///
      Padding(
        key: const ValueKey('all_feeds'),
        padding: const EdgeInsets.only(bottom: 8),
        child: FeedsListTile(
          isDraggable: false,
          key: const ValueKey('all_feeds'),
          onPressedDelete: () {},
          onPressed: () {
            triggerSentryBreadcrumb(
              message: 'Feeds -> All feeds pressed',
            );

            loadFeedAndPop(context, null);
          },
          title: 'feedsAllFeedsTitle'.tr(),
          subtitle: 'feedsAllFeedsSubtitle'.tr(),
          showActiveIndicator: activeFeed == null,
          fontFamily: fontFamily,
        ),
      ),

      ///
      /// FEEDS
      ///
      ReorderableListView.builder(
        shrinkWrap: true,
        proxyDecorator: (child, _, __) => Material(
          borderRadius: BorderRadius.circular(16),
          color: context.colors.primary.withValues(alpha: 0.6),
          child: child,
        ),
        onReorder: onReorder,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: feeds.length,
        itemBuilder: (_, index) {
          final feed = feeds[index];

          return Padding(
            key: ValueKey(feed),
            padding: const EdgeInsets.only(bottom: 8),
            child: FeedsListTile(
              key: ValueKey(feed),
              onPressedDelete: () {
                triggerSentryBreadcrumb(
                  message: 'Feeds -> Feed deleted -> ${feed.siteName ?? feed.title}',
                );

                return getIt.get<ActiveFeedService>().storeOrDeleteFeed(feed);
              },
              onPressed: () {
                triggerSentryBreadcrumb(
                  message: 'Feeds -> Feed pressed -> ${feed.siteName ?? feed.title}',
                );

                loadFeedAndPop(context, feed);
              },
              title: feed.siteName ?? feed.title ?? '',
              subtitle: feed.title,
              url: feed.url,
              showActiveIndicator: activeFeed == feed,
              fontFamily: fontFamily,
            ),
          );
        },
      ),

      ///
      /// SPACING
      ///
      const SizedBox(height: 40),
    ],
  );
}
