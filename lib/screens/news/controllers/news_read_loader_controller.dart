import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../services/logger_service.dart';

class NewsReadLoaderController extends ValueNotifier<double> {
  final LoggerService logger;

  NewsReadLoaderController({
    required this.logger,
  }) : super(0);

  ///
  /// METHODS
  ///

  set setLoader(double newValue) => value = newValue;
}
