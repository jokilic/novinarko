import 'package:flutter/material.dart';

import '../models/novinarko_theme_enum.dart';
import '../theme/theme.dart';
import '../util/sentry.dart';
import 'hive_service.dart';
import 'logger_service.dart';
import 'settings_service.dart';

class ThemeService extends ValueNotifier<ThemeData?> {
  final LoggerService logger;
  final HiveService hive;
  final SettingsService settings;

  ThemeService({
    required this.logger,
    required this.hive,
    required this.settings,
  }) : super(NovinarkoTheme.green) {
    value = getThemeData();
  }

  ///
  /// METHODS
  ///

  ThemeData? getThemeData() => switch (settings.value.novinarkoThemeEnum) {
    NovinarkoThemeEnum.light => NovinarkoTheme.light,
    NovinarkoThemeEnum.dark => NovinarkoTheme.dark,
    NovinarkoThemeEnum.sepia => NovinarkoTheme.sepia,
    NovinarkoThemeEnum.green => NovinarkoTheme.green,
    _ => null,
  };

  Future<void> updateTheme(ThemeData newTheme) async {
    value = newTheme;

    if (newTheme == NovinarkoTheme.light) {
      triggerSentryBreadcrumb(
        message: 'Settings -> Theme pressed -> light',
      );

      await hive.storeSettings(
        settings.value.copyWith(
          novinarkoThemeEnum: NovinarkoThemeEnum.light,
        ),
      );
    } else if (newTheme == NovinarkoTheme.dark) {
      triggerSentryBreadcrumb(
        message: 'Settings -> Theme pressed -> dark',
      );

      await hive.storeSettings(
        settings.value.copyWith(
          novinarkoThemeEnum: NovinarkoThemeEnum.dark,
        ),
      );
    } else if (newTheme == NovinarkoTheme.sepia) {
      triggerSentryBreadcrumb(
        message: 'Settings -> Theme pressed -> sepia',
      );

      await hive.storeSettings(
        settings.value.copyWith(
          novinarkoThemeEnum: NovinarkoThemeEnum.sepia,
        ),
      );
    } else if (newTheme == NovinarkoTheme.green) {
      triggerSentryBreadcrumb(
        message: 'Settings -> Theme pressed -> green',
      );

      await hive.storeSettings(
        settings.value.copyWith(
          novinarkoThemeEnum: NovinarkoThemeEnum.green,
        ),
      );
    }
  }
}
