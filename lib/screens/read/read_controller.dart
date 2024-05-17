// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide Disposable;
import 'package:get_it/get_it.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../constants.dart';
import '../../services/logger_service.dart';
import '../../services/settings_service.dart';
import '../../util/ad_url_filters.dart';
import 'web_buttons_controller.dart';

class ReadController extends ValueNotifier<List<ContentBlocker>> implements Disposable {
  final LoggerService logger;
  final SettingsService settings;
  final WebButtonsController webButtons;

  ReadController({
    required this.logger,
    required this.settings,
    required this.webButtons,
  }) : super([]) {
    pageController = PreloadPageController();

    final shouldUseContentBlockers = settings.value.useInAppBrowser && settings.value.useAdBlocker;

    setContentBlockers(
      shouldUseContentBlockers: shouldUseContentBlockers,
    );
  }

  ///
  /// VARIABLES
  ///

  late int itemLength;
  late PreloadPageController pageController;

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    pageController.dispose();
  }

  ///
  /// METHODS
  ///

  /// Logic to set content blockers in order to have an ad-free experience
  bool setContentBlockers({required bool shouldUseContentBlockers}) {
    if (shouldUseContentBlockers) {
      /// For each `adUrlFilter`, add a [ContentBlocker] to block its loading
      for (final adUrlFilter in adUrlFilters) {
        value.add(
          ContentBlocker(
            trigger: ContentBlockerTrigger(
              urlFilter: adUrlFilter,
            ),
            action: ContentBlockerAction(
              type: ContentBlockerActionType.BLOCK,
            ),
          ),
        );
      }

      /// Apply the `display: none` style to some HTML elements
      value.add(
        ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: '.*',
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: '.banner, .banners, .ads, .ad, .advert',
          ),
        ),
      );

      return true;
    } else {
      value.clear();
    }

    return false;
  }

  /// Updates `itemLength` variable
  void setItemLength(int value) {
    itemLength = value;
  }

  /// Decrements the `pageController` index
  Future<void> openPrevious() async {
    await pageController.previousPage(
      duration: NovinarkoConstants.animationDuration,
      curve: Curves.easeIn,
    );

    updateWebButtonVisibility(
      page: pageController.page?.round() ?? 0,
      itemLength: itemLength,
    );
  }

  /// Increments the `pageController` index
  Future<void> openNext() async {
    await pageController.nextPage(
      duration: NovinarkoConstants.animationDuration,
      curve: Curves.easeIn,
    );

    updateWebButtonVisibility(
      page: pageController.page?.round() ?? 0,
      itemLength: itemLength,
    );
  }

  /// Updates visibility of web buttons (previous & next)
  void updateWebButtonVisibility({required int page, required int itemLength}) => webButtons.updateState(
        (showPrevious: page > 0, showNext: page != itemLength - 1),
      );
}
