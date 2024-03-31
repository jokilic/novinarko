import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../models/novinarko_rss_item.dart';
import '../../services/logger_service.dart';

class ReadController extends ValueNotifier<List<NovinarkoRssItem>> {
  final LoggerService logger;

  ReadController({
    required this.logger,
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
  void openPrevious() => pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

  /// Increments the `pageController` index
  void openNext() => pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
}
