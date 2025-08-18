import 'package:flutter/material.dart';

import '../models/novinarko_settings.dart';
import '../util/sentry.dart';
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

  Future<void> fontPressed({required String fontFamily}) async {
    triggerSentryBreadcrumb(
      message: 'Settings -> Font pressed -> $fontFamily',
    );

    value = value.copyWith(
      fontFamily: fontFamily,
    );
    await hive.storeSettings(value);
  }

  Future<bool> imagesInArticlesPressed() async {
    final newValue = !value.useImagesInArticles;

    triggerSentryBreadcrumb(
      message: 'Settings -> Images in articles pressed -> $newValue',
    );

    value = value.copyWith(
      useImagesInArticles: newValue,
    );
    await hive.storeSettings(value);

    return newValue;
  }

  Future<bool> inAppBrowserPressed() async {
    final newValue = !value.useInAppBrowser;

    triggerSentryBreadcrumb(
      message: 'Settings -> In App Browser pressed -> $newValue',
    );

    value = value.copyWith(
      useInAppBrowser: newValue,
    );
    await hive.storeSettings(value);

    return newValue;
  }

  Future<bool> adBlockerPressed() async {
    final newValue = !value.useAdBlocker;

    triggerSentryBreadcrumb(
      message: 'Settings -> Ad blocker pressed -> $newValue',
    );

    value = value.copyWith(
      useAdBlocker: newValue,
    );
    await hive.storeSettings(value);

    return newValue;
  }

  Future<bool> shimmerLoaderPressed() async {
    final newValue = !value.useShimmerLoader;

    triggerSentryBreadcrumb(
      message: 'Settings -> Shimmer loader pressed -> $newValue',
    );

    value = value.copyWith(
      useShimmerLoader: newValue,
    );
    await hive.storeSettings(value);

    return newValue;
  }
}
