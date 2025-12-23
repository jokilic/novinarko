import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/feed_folder.dart';
import '../../../models/feed_item.dart';
import '../../../models/feed_search_model.dart';
import '../../../services/active_feed_service.dart';
import '../../../services/hive_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../news/controllers/news_controller.dart';
import 'feeds_list_tile.dart';

class FeedsContent extends StatelessWidget {
  final FeedSearchModel? activeFeed;
  final List<FeedItem> feeds;
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

  /// Creates feed item, based on type
  Widget buildFeedItem({required BuildContext context, required FeedItem feed}) {
    if (feed is FeedFolder) {
      return Padding(
        key: ValueKey(feed),
        padding: const EdgeInsets.only(bottom: 8),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.red,
          ),
          child: ExpansionTile(
            key: ValueKey(feed),
            collapsedBackgroundColor: Colors.green,
            backgroundColor: Colors.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textColor: context.colors.text,
            collapsedTextColor: context.colors.text,
            iconColor: context.colors.text,
            collapsedIconColor: context.colors.text,
            // TODO: Add icon
            leading: const Icon(Icons.folder),
            title: Text(
              feed.name,
              style: context.textStyles.feedsTitle.copyWith(
                fontFamily: fontFamily,
              ),
            ),
            childrenPadding: const EdgeInsets.only(left: 16),
            children: feed.children
                .map(
                  (child) => buildFeedItem(
                    context: context,
                    feed: child,
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    if (feed is FeedSearchModel) {
      return Padding(
        key: ValueKey(feed),
        padding: const EdgeInsets.only(bottom: 8),
        child: FeedsListTile(
          key: ValueKey(feed),
          onPressedDelete: () => getIt.get<ActiveFeedService>().storeOrDeleteFeed(feed),
          onPressed: () => loadFeedAndPop(context, feed),
          onLongPress: () => _showMoveToFolderDialog(context, feed),
          title: feed.siteName ?? feed.title ?? '',
          subtitle: feed.title,
          url: feed.url,
          showActiveIndicator: activeFeed == feed,
          fontFamily: fontFamily,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Future<void> _showMoveToFolderDialog(BuildContext context, FeedSearchModel feed) async {
    final hiveService = getIt<HiveService>();
    final folders = hiveService.getFeeds().whereType<FeedFolder>().toList();

    if (folders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No folders available')),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Move to Folder'),
        children: folders
            .map(
              (folder) => SimpleDialogOption(
                onPressed: () {
                  hiveService.moveFeedToFolder(feed, folder);
                  Navigator.of(context).pop();
                },
                child: Text(folder.name),
              ),
            )
            .toList(),
      ),
    );
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
          onPressed: () => loadFeedAndPop(context, null),
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
        itemBuilder: (_, index) => buildFeedItem(
          context: context,
          feed: feeds[index],
        ),
      ),

      ///
      /// SPACING
      ///
      const SizedBox(height: 40),
    ],
  );
}
