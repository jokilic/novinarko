import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/feed_model.dart';
import '../../../models/folder_model.dart';
import '../../../routing.dart';
import '../../../services/active_feed_folder_service.dart';
import '../../../services/hive_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_divider.dart';
import '../../news/controllers/news_controller.dart';
import 'feeds_list_tile.dart';

class FeedsContent extends StatelessWidget {
  final List<FeedModel> feeds;
  final List<FolderModel> folders;
  final FeedModel? activeFeed;
  final FolderModel? activeFolder;
  final Function(int oldIndex, int newIndex) onReorder;
  final String fontFamily;

  const FeedsContent({
    required this.feeds,
    required this.folders,
    required this.activeFeed,
    required this.activeFolder,
    required this.onReorder,
    required this.fontFamily,
  });

  /// Loads passed `feed` and dismisses screen
  void loadFeedAndPop({
    required BuildContext context,
    required FeedModel? feed,
  }) {
    getIt.get<ActiveFeedFolderService>().updateActiveFeed(feed);

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
      FeedsListTile(
        isDraggable: false,
        key: const ValueKey('all_feeds'),
        onPressedDelete: () {},
        onPressed: () => loadFeedAndPop(
          context: context,
          feed: null,
        ),
        title: 'feedsAllFeedsTitle'.tr(),
        subtitle: 'feedsAllFeedsSubtitle'.tr(),
        showActiveIndicator: activeFeed == null,
        fontFamily: fontFamily,
        isFolder: false,
      ),

      ///
      /// DIVIDER
      ///
      NovinarkoDivider(
        color: context.colors.background,
      ),

      ///
      /// FOLDERS + FEEDS
      ///
      Builder(
        builder: (context) {
          final orderedItems = getIt.get<HiveService>().getOrderedFeedsAndFolders(
            feeds: feeds,
            folders: folders,
          );

          return ReorderableListView.builder(
            shrinkWrap: true,
            proxyDecorator: (child, _, __) => Material(
              borderRadius: BorderRadius.circular(16),
              color: context.colors.primary.withValues(alpha: 0.6),
              child: child,
            ),
            onReorder: onReorder,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderedItems.length,
            itemBuilder: (_, index) {
              final item = orderedItems[index];

              ///
              /// FOLDER
              ///
              if (item is FolderModel) {
                return FeedsListTile(
                  key: ValueKey(item),
                  onPressedDelete: () => getIt.get<ActiveFeedFolderService>().storeOrDeleteFolder(item),
                  onPressed: () => openFolder(
                    context,
                    passedFolderName: item.title,
                  ),
                  title: item.title,
                  subtitle: item.description,
                  showActiveIndicator: activeFolder == item,
                  fontFamily: fontFamily,
                  isFolder: true,
                );
              }

              ///
              /// FEED
              ///
              final feed = item as FeedModel;

              return FeedsListTile(
                key: ValueKey(feed),
                onPressedDelete: () => getIt.get<ActiveFeedFolderService>().storeOrDeleteFeed(feed),
                onPressed: () => loadFeedAndPop(
                  context: context,
                  feed: feed,
                ),
                title: feed.siteName ?? feed.title ?? '',
                subtitle: feed.title,
                url: feed.url,
                showActiveIndicator: activeFeed == feed,
                fontFamily: fontFamily,
                isFolder: false,
              );
            },
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
