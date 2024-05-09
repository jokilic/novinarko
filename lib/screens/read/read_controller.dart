import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../constants.dart';
import '../../models/novinarko_rss_item.dart';
import '../../services/logger_service.dart';
import 'web_buttons_controller.dart';

class ReadController extends ValueNotifier<List<NovinarkoRssItem>> {
  final LoggerService logger;
  final WebButtonsController webButtons;

  ReadController({
    required this.logger,
    required this.webButtons,
  }) : super([]) {
    pageController = PreloadPageController();
  }

  ///
  /// VARIABLES
  ///

  AnimationController? shakeFabController;

  late PreloadPageController pageController;

  ///
  /// METHODS
  ///

  /// Adds an [NovinarkoRssItem] for reading in [ReadScreen]
  void addItemForReading(NovinarkoRssItem item) {
    /// Check if article is already in the list
    final articleExists = value.any((article) => article == item);

    /// Article exists in the list, remove it
    if (articleExists) {
      value.remove(item);
    }

    /// Article doesn't exist in the list, add it
    else {
      value.add(item);
    }

    /// Assign new state value
    value = List.from(value);

    /// Trigger FAB animation
    shakeFabController?.reset();
    shakeFabController?.forward();
  }

  /// Clears all [NovinarkoRssItem] from `state`
  void clearItemsForReading() => value = [];

  /// Decrements the `pageController` index
  Future<void> openPrevious() async {
    await pageController.previousPage(
      duration: NovinarkoConstants.animationDuration,
      curve: Curves.easeIn,
    );

    updateWebButtonVisibility(
      page: pageController.page?.round() ?? 0,
      itemLength: value.length,
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
      itemLength: value.length,
    );
  }

  /// Updates visibility of web buttons (previous & next)
  void updateWebButtonVisibility({required int page, required int itemLength}) => webButtons.updateState(
        (showPrevious: page > 0, showNext: page != itemLength - 1),
      );
}
