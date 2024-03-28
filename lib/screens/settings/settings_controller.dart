import 'package:flutter/material.dart';

import '../../models/novinarko_settings.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';

class SettingsController extends ValueNotifier<NovinarkoSettings> {
  final LoggerService logger;
  final HiveService hive;

  SettingsController({
    required this.logger,
    required this.hive,
  }) : super(hive.getSettings());

  ///
  /// METHODS
  ///

  Future<void> inAppBrowserPressed() async {
    value = value.copyWith(
      useInAppBrowser: !value.useInAppBrowser,
    );
    return hive.storeSettings(value);
  }

  Future<void> imagesInArticlesPressed() async {
    value = value.copyWith(
      useImagesInArticles: !value.useImagesInArticles,
    );
    return hive.storeSettings(value);
  }
}
