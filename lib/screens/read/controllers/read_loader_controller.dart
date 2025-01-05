import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../services/logger_service.dart';

class ReadLoaderController extends ValueNotifier<double> {
  final LoggerService logger;

  ReadLoaderController({
    required this.logger,
  }) : super(0);

  ///
  /// METHODS
  ///

  set setLoader(double newValue) => value = newValue;
}
