import 'package:flutter/material.dart';

import '../models/novinarko_theme_enum.dart';
import '../theme/theme.dart';
import 'hive_service.dart';
import 'logger_service.dart';
import 'settings_service.dart';

class ThemeService extends ValueNotifier<ThemeData> {
  final LoggerService logger;
  final HiveService hive;
  final SettingsService settings;

  ThemeService({
    required this.logger,
    required this.hive,
    required this.settings,
  }) : super(NovinarkoTheme.light) {
    value = getThemeData();
  }

  ///
  /// METHODS
  ///

  ThemeData getThemeData() => switch (settings.value.novinarkoThemeEnum) {
        NovinarkoThemeEnum.light => NovinarkoTheme.light,
        NovinarkoThemeEnum.dark => NovinarkoTheme.dark,
        NovinarkoThemeEnum.sepia => NovinarkoTheme.sepia,
      };

  Future<void> updateTheme(ThemeData newTheme) async {
    value = newTheme;

    if (newTheme == NovinarkoTheme.light) {
      await hive.storeSettings(
        settings.value.copyWith(novinarkoThemeEnum: NovinarkoThemeEnum.light),
      );
    } else if (newTheme == NovinarkoTheme.dark) {
      await hive.storeSettings(
        settings.value.copyWith(novinarkoThemeEnum: NovinarkoThemeEnum.dark),
      );
    } else if (newTheme == NovinarkoTheme.sepia) {
      await hive.storeSettings(
        settings.value.copyWith(novinarkoThemeEnum: NovinarkoThemeEnum.sepia),
      );
    }
  }
}
