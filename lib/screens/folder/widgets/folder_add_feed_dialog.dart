import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../constants.dart';
import '../../../models/feed_model.dart';
import '../../../services/hive_service.dart';
import '../../../theme/theme.dart';
import '../../../util/snackbars.dart';
import 'folder_list_tile.dart';

class FolderAddFeedDialog extends WatchingWidget {
  final String instanceName;
  final Function() outsideDialogPressed;
  final Future<void> Function(FeedModel feed) onFeedAdded;
  final String fontFamily;

  const FolderAddFeedDialog({
    required this.instanceName,
    required this.outsideDialogPressed,
    required this.onFeedAdded,
    required this.fontFamily,
  });

  Future<void> addFeed(
    FeedModel feed, {
    required BuildContext dialogContext,
    required bool isLastFeed,
  }) async {
    /// Trigger outside function
    await onFeedAdded(feed);

    /// Dismiss dialog if no more feeds to add
    if (isLastFeed) {
      outsideDialogPressed();
    }

    /// Show snackbar
    showSnackbar(
      dialogContext,
      // TODO Localize
      text: '${feed.siteName ?? feed.title} added to folder',
      icon: NovinarkoIcons.check,
      isDark: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hiveState = watchIt<HiveService>().value;

    final folderToWatch = hiveState.folders
        .where(
          (f) => f.title == instanceName,
        )
        .firstOrNull;

    final nonAddedFeeds = hiveState.feeds.where((feed) {
      if (folderToWatch?.feeds == null) {
        return true;
      }
      return !folderToWatch!.feeds!.contains(feed);
    }).toList();

    return GestureDetector(
      onTap: outsideDialogPressed,
      child: ScaffoldMessenger(
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {},
              child: Dialog(
                backgroundColor: context.colors.text,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: context.colors.background,
                    width: 2,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.colors.background,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          NovinarkoIcons.addFolder,
                          fit: BoxFit.cover,
                          color: context.colors.background,
                          height: 36,
                          width: 36,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          // TODO Localize
                          'Add feeds to folder',
                          style: context.textStyles.newsFeedInfoTitle.copyWith(
                            color: context.colors.background,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: nonAddedFeeds.length,
                        itemBuilder: (_, index) {
                          final feed = nonAddedFeeds[index];

                          return FolderListTile(
                            isDraggable: false,
                            horizontalPadding: 24,
                            key: ValueKey(feed),
                            onPressedDelete: () {},
                            onPressed: () => addFeed(
                              feed,
                              dialogContext: context,
                              isLastFeed: nonAddedFeeds.length <= 1,
                            ),
                            title: feed.siteName ?? feed.title ?? '',
                            subtitle: feed.title,
                            url: feed.url,
                            showActiveIndicator: false,
                            fontFamily: fontFamily,
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      TextButton(
                        onPressed: outsideDialogPressed,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          elevation: 0,
                          side: BorderSide(
                            color: context.colors.background,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          // TODO Localize
                          'Finish'.toUpperCase(),
                          style: context.textStyles.searchCustomDialogButton.copyWith(
                            color: context.colors.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
