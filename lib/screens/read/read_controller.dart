// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../constants.dart';
import '../../services/logger_service.dart';
import '../../services/settings_service.dart';
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

    if (settings.value.useInAppBrowser) {
      logger.f('Using in-app browser');
    }
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
