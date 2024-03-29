import 'package:flutter/material.dart';

import '../models/novinarko_settings.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class SettingsService extends ValueNotifier<NovinarkoSettings> {
  final LoggerService logger;
  final HiveService hive;

  SettingsService({
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
    await hive.storeSettings(value);
  }

  Future<void> imagesInArticlesPressed() async {
    value = value.copyWith(
      useImagesInArticles: !value.useImagesInArticles,
    );
    await hive.storeSettings(value);
  }
}
