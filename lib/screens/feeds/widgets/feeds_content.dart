import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../models/feed_search_model.dart';
import '../../../services/active_feed_service.dart';
import '../../../util/dependencies.dart';
import '../../news/news_controller.dart';
import 'feeds_list_tile.dart';

class FeedsContent extends StatelessWidget {
  final FeedSearchModel? activeFeed;
  final List<FeedSearchModel> feeds;

  const FeedsContent({
    required this.activeFeed,
    required this.feeds,
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
  Widget build(BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: feeds.length + 1,
        itemBuilder: (_, index) {
          /// First value, show `All feeds`
          if (index == 0) {
            return Animate(
              key: ValueKey(index),
              delay: (const Duration(milliseconds: 150).inMilliseconds * index).milliseconds,
              effects: const [
                FadeEffect(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 450),
                ),
              ],
              child: FeedsListTile(
                isDraggable: false,
                key: ValueKey(index),
                onPressedDelete: () {},
                onPressed: () => loadFeedAndPop(context, null),
                title: 'feedsAllFeedsTitle'.tr(),
                subtitle: 'feedsAllFeedsSubtitle'.tr(),
                showActiveIndicator: activeFeed == null,
              ),
            );
          }

          /// Show feeds
          final feed = feeds[index - 1];

          return Animate(
            key: ValueKey(feed),
            delay: (const Duration(milliseconds: 150).inMilliseconds * index).milliseconds,
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 450),
              ),
            ],
            child: FeedsListTile(
              key: ValueKey(feed),
              onPressedDelete: () => getIt.get<ActiveFeedService>().storeOrDeleteFeed(
                    feed,
                    deleteFeed: true,
                  ),
              onPressed: () => loadFeedAndPop(context, feed),
              title: feed.siteName ?? feed.title ?? '',
              subtitle: feed.title,
              url: feed.url,
              showActiveIndicator: activeFeed == feed,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      );
}
