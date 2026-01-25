import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:watch_it/watch_it.dart';

import '../../../constants.dart';
import '../../../services/settings_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../search_controller.dart';
import 'search_custom_dialog.dart';

class SearchAppBar extends WatchingWidget implements PreferredSizeWidget {
  final bool hasFeeds;

  const SearchAppBar({
    required this.hasFeeds,
  });

  /// Triggers custom search
  Future<void> triggerCustomSearch(
    BuildContext context, {
    required String fontFamily,
  }) async {
    final controller = getIt.get<SearchController>()
      /// Clear [TextEditingControllers]
      ..clearCustomTextEditingControllers();

    /// Show [SearchCustomDialog]
    await showDialog(
      context: context,
      builder: (context) => SearchCustomDialog(
        addFeedPressed: (dialogContext) => controller.addCustomFeedPressed(
          context: context,
          dialogContext: dialogContext,
        ),
        outsideDialogPressed: () {
          controller.clearCustomTextEditingControllers();
          Navigator.of(context).pop();
        },
        feedTitleTextController: controller.customFeedTitleTextController,
        feedUrlTextController: controller.customFeedUrlTextController,
        siteNameTextController: controller.customFeedSiteNameTextController,
        fontFamily: fontFamily,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fontFamily = watchIt<SettingsService>().value.fontFamily;

    return AppBar(
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
              IgnorePointer(
                ignoring: !hasFeeds,
                child: Opacity(
                  opacity: hasFeeds ? 1 : 0.3,
                  child: SearchAppBarBack(
                    onPressed: Navigator.of(context).pop,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: SearchBarTextField(
                  textController: getIt.get<SearchController>().searchTextController,
                  onSubmitted: (value) => getIt.get<SearchController>().searchTriggered(value),
                  fontFamily: fontFamily,
                ),
              ),
              const SizedBox(width: 40),
              SearchAppBarCustom(
                onPressed: () => triggerCustomSearch(
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

class SearchAppBarBack extends StatelessWidget {
  final Function() onPressed;

  const SearchAppBarBack({
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
        color: context.colors.text,
        width: 2,
      ),
    ),
    icon: Center(
      child: Image.asset(
        NovinarkoIcons.back,
        fit: BoxFit.cover,
        color: context.colors.text,
        height: 20,
        width: 20,
      ),
    ),
  );
}

class SearchBarTextField extends StatelessWidget {
  final TextEditingController textController;
  final Function(String value) onSubmitted;
  final String fontFamily;

  const SearchBarTextField({
    required this.textController,
    required this.onSubmitted,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) => TextField(
    autofocus: true,
    autocorrect: false,
    enableSuggestions: false,
    keyboardType: TextInputType.url,
    textInputAction: TextInputAction.search,
    controller: textController,
    onSubmitted: onSubmitted,
    cursorColor: context.colors.text,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      label: Center(
        child: Text(
          'searchFindFeed'.tr(),
          style: context.textStyles.searchTextField.copyWith(
            fontFamily: fontFamily,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      alignLabelWithHint: true,
    ),
    style: context.textStyles.searchTextField.copyWith(
      fontFamily: fontFamily,
    ),
    textAlign: TextAlign.center,
  );
}

class SearchAppBarCustom extends StatelessWidget {
  final Function() onPressed;

  const SearchAppBarCustom({
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
        color: context.colors.text,
        width: 2,
      ),
    ),
    icon: Center(
      child: Image.asset(
        NovinarkoIcons.customSearch,
        fit: BoxFit.cover,
        color: context.colors.text,
        height: 20,
        width: 20,
      ),
    ),
  );
}
