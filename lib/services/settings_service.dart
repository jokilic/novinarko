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

  Future<bool> inAppBrowserPressed() async {
    final newValue = !value.useInAppBrowser;

    value = value.copyWith(
      useInAppBrowser: newValue,
    );
    await hive.storeSettings(value);

    return newValue;
  }

  Future<bool> imagesInArticlesPressed() async {
    final newValue = !value.useImagesInArticles;

    value = value.copyWith(
      useImagesInArticles: newValue,
    );
    await hive.storeSettings(value);

    return newValue;
  }

  Future<bool> adBlockerPressed() async {
    final newValue = !value.useAdBlocker;

    value = value.copyWith(
      useAdBlocker: newValue,
    );
    await hive.storeSettings(value);

    return newValue;
  }
}
