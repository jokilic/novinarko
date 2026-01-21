import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../constants.dart';
import '../../../models/folder_model.dart';
import '../../../services/hive_service.dart';
import '../../../services/settings_service.dart';
import '../../../services/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../folder_controller.dart';
import 'folder_add_feed_dialog.dart';

class FolderAppBar extends WatchingWidget implements PreferredSizeWidget {
  final FolderModel folder;

  const FolderAppBar({
    required this.folder,
  });

  /// Opens [FolderAddFeedDialog]
  Future<void> openFolderAddFeedDialog(
    BuildContext context, {
    required String fontFamily,
  }) async {
    /// Find `feeds` which aren't in this folder
    final allFeeds = getIt.get<HiveService>().getFeeds();
    final nonAddedFeeds = allFeeds.where((feed) {
      if (folder.feeds == null) {
        return true;
      }
      return !folder.feeds!.contains(feed);
    }).toList();

    await showDialog(
      context: context,
      builder: (context) => FolderAddFeedDialog(
        nonAddedFeeds: nonAddedFeeds,
        outsideDialogPressed: Navigator.of(context).pop,
        onFeedAdded: (feed) {
          // TODO: Add feed to folder
        },
        fontFamily: fontFamily,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = watchIt<ThemeService>().value;
    final isDark = theme == null || theme == NovinarkoTheme.dark || theme == NovinarkoTheme.green || theme == NovinarkoTheme.burgundy || theme == NovinarkoTheme.black;

    final fontFamily = watchIt<SettingsService>().value.fontFamily;

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.infinite,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FolderAppBarBack(
                onPressed: Navigator.of(context).pop,
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      NovinarkoIcons.addFolder,
                      fit: BoxFit.cover,
                      color: context.colors.background,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        folder.title,
                        style: context.textStyles.newsAppBar.copyWith(
                          fontFamily: fontFamily,
                          color: context.colors.background,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              FolderAppBarDelete(
                onPressed: () async {
                  await getIt
                      .get<FolderController>(
                        instanceName: folder.title,
                      )
                      .deleteFolder(folder);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 20),
              FolderAppBarAddFeed(
                onPressed: () => openFolderAddFeedDialog(
                  context,
                  fontFamily: fontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16,
            sigmaY: 16,
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);
}

class FolderAppBarBack extends StatelessWidget {
  final Function() onPressed;

  const FolderAppBarBack({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    style: IconButton.styleFrom(
      highlightColor: context.colors.primary.withValues(alpha: 0.6),
      fixedSize: const Size(50, 50),
      shape: const CircleBorder(),
      side: BorderSide(
        color: context.colors.background,
        width: 2,
      ),
    ),
    icon: Center(
      child: Image.asset(
        NovinarkoIcons.back,
        fit: BoxFit.cover,
        color: context.colors.background,
        height: 20,
        width: 20,
      ),
    ),
  );
}

class FolderAppBarDelete extends StatelessWidget {
  final Function() onPressed;

  const FolderAppBarDelete({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    style: IconButton.styleFrom(
      highlightColor: context.colors.primary.withValues(alpha: 0.6),
      fixedSize: const Size(50, 50),
      shape: const CircleBorder(),
      side: BorderSide(
        color: context.colors.background,
        width: 2,
      ),
    ),
    icon: Center(
      child: Image.asset(
        NovinarkoIcons.delete,
        fit: BoxFit.cover,
        color: context.colors.background,
        height: 20,
        width: 20,
      ),
    ),
  );
}

class FolderAppBarAddFeed extends StatelessWidget {
  final Function() onPressed;

  const FolderAppBarAddFeed({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    style: IconButton.styleFrom(
      highlightColor: context.colors.primary.withValues(alpha: 0.6),
      fixedSize: const Size(50, 50),
      shape: const CircleBorder(),
      side: BorderSide(
        color: context.colors.background,
        width: 2,
      ),
    ),
    icon: Center(
      child: Image.asset(
        NovinarkoIcons.add,
        fit: BoxFit.cover,
        color: context.colors.background,
        height: 20,
        width: 20,
      ),
    ),
  );
}
