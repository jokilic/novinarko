import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/feed_model.dart';
import '../../../theme/theme.dart';
import '../../../util/snackbars.dart';
import 'folder_list_tile.dart';

class FolderAddFeedDialog extends StatefulWidget {
  final List<FeedModel> nonAddedFeeds;
  final Function() outsideDialogPressed;
  final Function(FeedModel feed) onFeedAdded;
  final String fontFamily;

  const FolderAddFeedDialog({
    required this.nonAddedFeeds,
    required this.outsideDialogPressed,
    required this.onFeedAdded,
    required this.fontFamily,
  });

  @override
  State<FolderAddFeedDialog> createState() => _FolderAddFeedDialogState();
}

class _FolderAddFeedDialogState extends State<FolderAddFeedDialog> {
  late var feeds = List.from(widget.nonAddedFeeds);

  void addFeed(FeedModel feed) {
    /// Remove feed from list
    setState(
      () => feeds.remove(feed),
    );

    /// Show snackbar
    showSnackbar(
      context,
      // TODO
      text: 'Feed added',
      icon: NovinarkoIcons.check,
      isDark: true,
    );

    /// Trigger outside function
    widget.onFeedAdded(feed);

    /// Dismiss dialog if no more feeds to add
    if (feeds.isEmpty) {
      widget.outsideDialogPressed();
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: widget.outsideDialogPressed,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                      Text(
                        // TODO
                        'Add feeds to folder',
                        style: context.textStyles.newsFeedInfoTitle.copyWith(
                          color: context.colors.background,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: feeds.length,
                        itemBuilder: (_, index) {
                          final feed = feeds[index];

                          return FolderListTile(
                            isDraggable: false,
                            horizontalPadding: 0,
                            key: ValueKey(feed),
                            onPressedDelete: () {},
                            onPressed: () => addFeed(feed),
                            title: feed.siteName ?? feed.title ?? '',
                            subtitle: feed.title,
                            url: feed.url,
                            showActiveIndicator: false,
                            fontFamily: widget.fontFamily,
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      TextButton(
                        onPressed: widget.outsideDialogPressed,
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
                          // TODO
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
    ),
  );
}
