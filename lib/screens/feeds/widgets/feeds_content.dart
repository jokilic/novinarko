import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/feed_search_model.dart';
import '../../../services/active_feed_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../news/controllers/news_controller.dart';
import 'feeds_list_tile.dart';

class FeedsContent extends StatelessWidget {
  final FeedSearchModel? activeFeed;
  final List<FeedSearchModel> feeds;
  final Function(int oldIndex, int newIndex) onReorder;

  const FeedsContent({
    required this.activeFeed,
    required this.feeds,
    required this.onReorder,
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
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(8, MediaQuery.paddingOf(context).top, 8, 8),
        child: Column(
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
                onPressed: () => loadFeedAndPop(context, null),
                title: 'feedsAllFeedsTitle'.tr(),
                subtitle: 'feedsAllFeedsSubtitle'.tr(),
                showActiveIndicator: activeFeed == null,
              ),
            ),

            ///
            /// FEEDS
            ///
            Flexible(
              child: ReorderableListView.builder(
                proxyDecorator: (child, _, __) => Material(
                  borderRadius: BorderRadius.circular(16),
                  color: context.colors.primary.withOpacity(0.6),
                  child: child,
                ),
                onReorder: onReorder,
                physics: const BouncingScrollPhysics(),
                itemCount: feeds.length,
                itemBuilder: (_, index) {
                  final feed = feeds[index];

                  return Padding(
                    key: ValueKey(feed),
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FeedsListTile(
                      key: ValueKey(feed),
                      onPressedDelete: () => getIt.get<ActiveFeedService>().storeOrDeleteFeed(feed),
                      onPressed: () => loadFeedAndPop(context, feed),
                      title: feed.siteName ?? feed.title ?? '',
                      subtitle: feed.title,
                      url: feed.url,
                      showActiveIndicator: activeFeed == feed,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
