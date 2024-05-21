// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide Disposable;
import 'package:get_it/get_it.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../constants.dart';
import '../../services/logger_service.dart';
import '../../services/settings_service.dart';
import '../../util/peter_lowe_ad_hosts.dart';
import 'web_buttons_controller.dart';

class ReadController implements Disposable {
  final LoggerService logger;
  final SettingsService settings;
  final WebButtonsController webButtons;

  ReadController({
    required this.logger,
    required this.settings,
    required this.webButtons,
  }) {
    pageController = PreloadPageController();

    webViewSettings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true,
      contentBlockers: generateContentBlockers(
        shouldUseContentBlockers: settings.value.useInAppBrowser && settings.value.useAdBlocker,
      ),
    );
  }

  ///
  /// VARIABLES
  ///

  late int itemLength;
  late PreloadPageController pageController;
  late final InAppWebViewSettings webViewSettings;

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

  /// Logic to generate content blockers in order to have an ad-free experience
  List<ContentBlocker> generateContentBlockers({required bool shouldUseContentBlockers}) {
    final contentBlockers = <ContentBlocker>[];

    if (shouldUseContentBlockers) {
      /// For each `adHost`, add a [ContentBlocker] to block its loading
      for (final adHost in peterLoweAdHosts) {
        contentBlockers.add(
          ContentBlocker(
            trigger: ContentBlockerTrigger(
              urlFilter: adHost,
            ),
            action: ContentBlockerAction(
              type: ContentBlockerActionType.BLOCK,
            ),
          ),
        );
      }

      /// Apply the `display: none` style to some HTML elements
      contentBlockers.add(
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
    } else {
      contentBlockers.clear();
    }

    return contentBlockers;
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
