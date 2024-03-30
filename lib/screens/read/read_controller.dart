import 'package:flutter/material.dart';

import '../../models/novinarko_rss_item.dart';
import '../../services/logger_service.dart';

class ReadController extends ValueNotifier<List<NovinarkoRssItem>> {
  final LoggerService logger;

  ReadController({
    required this.logger,
  }) : super([]);

  ///
  /// VARIABLES
  ///

  AnimationController? shakeFabController;

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
}
