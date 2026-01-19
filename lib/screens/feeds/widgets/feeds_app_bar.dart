import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../constants.dart';
import '../../../routing.dart';
import '../../../services/settings_service.dart';
import '../../../services/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../folder/widgets/folder_dialog.dart';
import '../feeds_controller.dart';

class FeedsAppBar extends WatchingWidget implements PreferredSizeWidget {
  /// Opens [FolderDialog]
  Future<void> openFolderDialog(
    BuildContext context, {
    required String fontFamily,
  }) async {
    final controller = getIt.get<FeedsController>();

    await showDialog(
      context: context,
      builder: (context) => FolderDialog(
        addFolderPressed: (dialogContext) => controller.addFolderPressed(
          context: context,
          dialogContext: dialogContext,
        ),
        outsideDialogPressed: () {
          controller.clearCustomTextControllers();
          Navigator.of(context).pop();
        },
        folderTitleTextController: controller.folderTitleTextController,
        folderDescriptionTextController: controller.folderDescriptionTextController,
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
              FeedsAppBarBack(
                onPressed: Navigator.of(context).pop,
              ),
              const Spacer(),
              FeedsAppBarAddFolder(
                onPressed: () => openFolderDialog(
                  context,
                  fontFamily: fontFamily,
                ),
              ),
              const SizedBox(width: 20),
              FeedsAppBarSettings(
                onPressed: () => openSettings(context),
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

class FeedsAppBarBack extends StatelessWidget {
  final Function() onPressed;

  const FeedsAppBarBack({
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

class FeedsAppBarAddFolder extends StatelessWidget {
  final Function() onPressed;

  const FeedsAppBarAddFolder({
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
        NovinarkoIcons.android,
        fit: BoxFit.cover,
        color: context.colors.background,
        height: 20,
        width: 20,
      ),
    ),
  );
}

class FeedsAppBarSettings extends StatelessWidget {
  final Function() onPressed;

  const FeedsAppBarSettings({
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
        NovinarkoIcons.settings,
        fit: BoxFit.cover,
        color: context.colors.background,
        height: 20,
        width: 20,
      ),
    ),
  );
}
