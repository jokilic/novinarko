import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/feed_model.dart';
import '../../../models/folder_model.dart';
import '../../../services/active_feed_folder_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_divider.dart';
import '../../news/controllers/news_controller.dart';

class FolderContent extends StatelessWidget {
  final FolderModel folder;
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
        onPressed: () => loadFeedAndPop(context, null),
        title: 'feedsAllFeedsTitle'.tr(),
        subtitle: 'feedsAllFeedsSubtitle'.tr(),
        showActiveIndicator: activeFeed == null,
        fontFamily: fontFamily,
      ),

      ///
      /// DIVIDER
      ///
      NovinarkoDivider(
        color: context.colors.background,
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

          return FeedsListTile(
            key: ValueKey(feed),
            onPressedDelete: () => getIt.get<ActiveFeedFolderService>().storeOrDeleteFeed(feed),
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
