import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/feed_model.dart';
import '../../../models/folder_model.dart';
import '../../../services/active_feed_folder_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_divider.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../news/controllers/news_controller.dart';
import '../folder_controller.dart';
import 'folder_list_tile.dart';

class FolderContent extends StatelessWidget {
  final FolderModel? folder;
  final FeedModel? activeFeed;
  final FolderModel? activeFolder;
  final Function(int oldIndex, int newIndex) onReorder;
  final String fontFamily;

  const FolderContent({
    required this.folder,
    required this.activeFeed,
    required this.activeFolder,
    required this.onReorder,
    required this.fontFamily,
  });

  /// Loads passed `feed` and dismisses screen
  void loadFeedAndPop(BuildContext context, FeedModel? feed) {
    getIt.get<ActiveFeedFolderService>().updateActiveFeed(feed);

    if (getIt.isRegistered<NewsController>()) {
      getIt.get<NewsController>().loadFeed(feed);
    }

    // TODO: Pop all screens until [NewsScreen]
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.fromLTRB(8, MediaQuery.paddingOf(context).top, 8, 8),
    physics: const BouncingScrollPhysics(),
    children: [
      ///
      /// ALL FEEDS FROM FOLDER
      ///
      if (folder?.feeds?.isNotEmpty ?? false) ...[
        FolderListTile(
          isDraggable: false,
          key: const ValueKey('all_folder_feeds'),
          onPressedDelete: () {},
          onPressed: () {
            // TODO: Pop all screens until [NewsScreen], use all feeds from folder
          },
          // TODO
          title: 'All feeds',
          // TODO
          subtitle: 'Show all feeds from this folder',
          showActiveIndicator: activeFolder == null,
          fontFamily: fontFamily,
        ),

        ///
        /// DIVIDER
        ///
        NovinarkoDivider(
          color: context.colors.background,
        ),
      ] else
        ///
        /// ADD FEEDS
        ///
        NovinarkoIconTextWidget(
          icon: NovinarkoIcons.add,
          title: 'No feeds',
          subtitle: 'Add some by pressing the plus icon',
          fontFamily: fontFamily,
          isDark: true,
          verticalPadding: 0,
          customTopSpacing: 40,
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
        itemCount: folder?.feeds?.length ?? 0,
        itemBuilder: (_, index) {
          final feed = folder?.feeds![index];

          if (feed != null && folder != null) {
            return FolderListTile(
              key: ValueKey(feed),
              onPressedDelete: () => getIt
                  .get<FolderController>(
                    instanceName: folder?.title,
                  )
                  .deleteFeed(
                    feed: feed,
                    folder: folder!,
                  ),
              onPressed: () {
                // TODO: Pop all screens until [NewsScreen], use this feed
              },
              title: feed.siteName ?? feed.title ?? '',
              subtitle: feed.title,
              url: feed.url,
              showActiveIndicator: activeFeed == feed,
              fontFamily: fontFamily,
            );
          }

          return const SizedBox.shrink();
        },
      ),

      ///
      /// SPACING
      ///
      const SizedBox(height: 40),
    ],
  );
}
