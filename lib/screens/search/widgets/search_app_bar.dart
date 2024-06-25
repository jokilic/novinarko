import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../constants.dart';
import '../../../main.dart';
import '../../../routing.dart';
import '../../../services/hive_service.dart';
import '../../../services/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../util/snackbars.dart';
import '../search_controller.dart';
import 'search_custom_dialog.dart';

class SearchAppBar extends WatchingWidget implements PreferredSizeWidget {
  /// Triggers search or shows [SnackBar], depending on `feedsLength`
  void searchOrShowSnackbar(
    BuildContext context, {
    required String text,
    required int feedsLength,
  }) {
    /// User has less than feed limit, trigger search
    if (feedsLength < feedLimit) {
      getIt.get<SearchController>().searchTriggered(text);
    }

    /// User has more than feed limit, show [SnackBar]
    else {
      showRemoveSomeFeedsSnackbar(
        context,
        onPressed: () => openFeeds(context),
      );
    }
  }

  /// Triggers custom search or shows [SnackBar], depending on `feedsLength`
  Future<void> customSearchOrShowSnackbar(
    BuildContext context, {
    required int feedsLength,
  }) async {
    /// User has less than feed limit, trigger custom search
    if (feedsLength < feedLimit) {
      /// Clear [TextEditingControllers]
      getIt.get<SearchController>().clearCustomTextControllers();

      /// Show [SearchCustomDialog]
      await showDialog(
        context: context,
        builder: (context) => SearchCustomDialog(
          addFeedPressed: (dialogContext) => getIt.get<SearchController>().addCustomFeedPressed(
                context: context,
                dialogContext: dialogContext,
              ),
          outsideDialogPressed: Navigator.of(context).pop,
          feedTitleTextController: getIt.get<SearchController>().customFeedTitleTextController,
          feedUrlTextController: getIt.get<SearchController>().customFeedUrlTextController,
          siteNameTextController: getIt.get<SearchController>().customFeedSiteNameTextController,
        ),
      );
    }

    /// User has more than feed limit, show [SnackBar]
    else {
      showRemoveSomeFeedsSnackbar(
        context,
        onPressed: () => openFeeds(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedsLength = watchIt<HiveService>().value.length;
    final isDark = watchIt<ThemeService>().value == NovinarkoTheme.dark;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
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
              SearchAppBarBack(
                onPressed: Navigator.of(context).pop,
              ),
              const SizedBox(width: 40),
              Expanded(
                child: SearchBarTextField(
                  textController: getIt.get<SearchController>().searchTextController,
                  onSubmitted: (value) => searchOrShowSnackbar(
                    context,
                    text: value,
                    feedsLength: feedsLength,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              SearchAppBarCustom(
                noSearch: feedsLength >= feedLimit,
                onPressed: () => customSearchOrShowSnackbar(
                  context,
                  feedsLength: feedsLength,
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
          highlightColor: context.colors.primary.withOpacity(0.6),
          fixedSize: const Size(48, 48),
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

  const SearchBarTextField({
    required this.textController,
    required this.onSubmitted,
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
              style: context.textStyles.searchTextField,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
        ),
        style: context.textStyles.searchTextField,
        textAlign: TextAlign.center,
      );
}

class SearchAppBarCustom extends StatelessWidget {
  final Function() onPressed;
  final bool noSearch;

  const SearchAppBarCustom({
    required this.onPressed,
    required this.noSearch,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          highlightColor: context.colors.primary.withOpacity(0.6),
          fixedSize: const Size(48, 48),
          shape: const CircleBorder(),
          side: BorderSide(
            color: context.colors.text,
            width: 2,
          ),
        ),
        icon: Center(
          child: Image.asset(
            noSearch ? NovinarkoIcons.noSearch : NovinarkoIcons.customSearch,
            fit: BoxFit.cover,
            color: context.colors.text,
            height: 20,
            width: 20,
          ),
        ),
      );
}
