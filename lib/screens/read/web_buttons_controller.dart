// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';

import '../../services/logger_service.dart';

class WebButtonsController extends ValueNotifier<({bool showPrevious, bool showNext})> {
  final LoggerService logger;

  WebButtonsController({
    required this.logger,
  }) : super((showPrevious: false, showNext: true));

  ///
  /// METHODS
  ///

  void updateState(({bool showPrevious, bool showNext}) newState) => value = newState;
}
