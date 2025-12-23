import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/feed_search_model.dart';
import '../../../models/feeds_folder_model.dart';
import '../../../services/active_feed_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../news/controllers/news_controller.dart';
import 'feeds_list_tile.dart';
import 'folders_list_tile.dart';

class FeedsContent extends StatelessWidget {
  final FeedSearchModel? activeFeed;
  final FeedsFolderModel? activeFolder;
  final List<FeedSearchModel> feeds;
  final List<FeedsFolderModel> folders;
  final Function(int oldIndex, int newIndex) onReorderFeeds;
  final Function(int oldIndex, int newIndex) onReorderFolders;
  final String fontFamily;

  const FeedsContent({
    required this.activeFeed,
    required this.activeFolder,
    required this.feeds,
    required this.folders,
    required this.onReorderFeeds,
    required this.onReorderFolders,
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
          onPressed: () => loadFeedAndPop(context, null),
          title: 'feedsAllFeedsTitle'.tr(),
          subtitle: 'feedsAllFeedsSubtitle'.tr(),
          showActiveIndicator: activeFeed == null,
          fontFamily: fontFamily,
        ),
      ),

      ///
      /// FOLDERS
      ///
      if (folders.isNotEmpty)
        ReorderableListView.builder(
          shrinkWrap: true,
          proxyDecorator: (child, _, __) => Material(
            borderRadius: BorderRadius.circular(16),
            color: context.colors.primary.withValues(alpha: 0.6),
            child: child,
          ),
          onReorder: onReorderFolders,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: folders.length,
          itemBuilder: (_, index) {
            final folder = folders[index];

            return FoldersListTile(
              key: ValueKey(folder),
              // TODO: Implement this method
              onPressedDelete: () {},
              // TODO: Implement this method
              // onPressed: () => loadFolderAndPop(context, folder),
              onPressed: () {},
              title: folder.name,
              subtitle: folder.feeds.map((feed) => feed.title).toList().toString(),
              showActiveIndicator: activeFolder == folder,
              fontFamily: fontFamily,
            );
          },
        ),

      ///
      /// FEEDS
      ///
      if (feeds.isNotEmpty)
        ReorderableListView.builder(
          shrinkWrap: true,
          proxyDecorator: (child, _, __) => Material(
            borderRadius: BorderRadius.circular(16),
            color: context.colors.primary.withValues(alpha: 0.6),
            child: child,
          ),
          onReorder: onReorderFeeds,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: feeds.length,
          itemBuilder: (_, index) {
            final feed = feeds[index];

            return FeedsListTile(
              key: ValueKey(feed),
              onPressedDelete: () => getIt.get<ActiveFeedService>().storeOrDeleteFeed(feed),
              onPressed: () => loadFeedAndPop(context, feed),
              title: feed.siteName ?? feed.title ?? '',
              subtitle: feed.title,
              url: feed.url,
              showActiveIndicator: activeFeed == feed,
              fontFamily: fontFamily,
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
