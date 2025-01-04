// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';

import '../../services/logger_service.dart';

class ActiveUrlController extends ValueNotifier<String> {
  final LoggerService logger;

  ActiveUrlController({
    required this.logger,
  }) : super('nooo');

  ///
  /// METHODS
  ///

  void updateState(String newState) => value = newState;
}
