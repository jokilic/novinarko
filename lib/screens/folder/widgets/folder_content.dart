import 'package:easy_localization/easy_localization.dart';
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

  /// Loads passed `feed` from `folder` and dismisses screen
  void loadAndPop(
    BuildContext context, {
    required FeedModel? feed,
  }) {
    /// Update active values
    getIt.get<ActiveFeedFolderService>()
      ..updateActiveFolder(folder)
      ..updateActiveFeed(feed);

    /// Load proper feeds if [NewsController] is registered
    if (getIt.isRegistered<NewsController>()) {
      final newsController = getIt.get<NewsController>();

      /// `Feed` is passed, load it
      if (feed != null) {
        newsController.loadFeed(feed);
      }
      /// No `feed` passed, load all feeds from `folder`
      else {
        newsController.loadAllFeeds(
          passedFeeds: folder?.feeds,
        );
      }
    }

    /// Go back to [NewsScreen]
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
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
          onPressed: () => loadAndPop(
            context,
            feed: null,
          ),
          title: 'folderAllFeedsTitle'.tr(),
          subtitle: 'folderAllFeedsSubtitle'.tr(),
          showActiveIndicator: activeFolder == folder && activeFeed == null,
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
              onPressed: () => loadAndPop(
                context,
                feed: feed,
              ),
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
