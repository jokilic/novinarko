import 'package:flutter/material.dart';

import '../models/novinarko_theme_enum.dart';
import '../theme/theme.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class ThemeService extends ValueNotifier<ThemeData> {
  final LoggerService logger;
  final HiveService hive;

  ThemeService({
    required this.logger,
    required this.hive,
  }) : super(NovinarkoTheme.light) {
    value = getThemeData();
  }

  ///
  /// METHODS
  ///

  ThemeData getThemeData() => switch (hive.getThemeEnum()) {
        NovinarkoThemeEnum.light => NovinarkoTheme.light,
        NovinarkoThemeEnum.dark => NovinarkoTheme.dark,
        NovinarkoThemeEnum.sepia => NovinarkoTheme.sepia,
      };

  Future<void> updateTheme() async {
    /// Theme is `light`, switch to `dark`
    if (value == NovinarkoTheme.light) {
      value = NovinarkoTheme.dark;
      await hive.storeThemeEnum(NovinarkoThemeEnum.dark);
    }

    /// Theme is `dark`, switch to `sepia`
    else if (value == NovinarkoTheme.dark) {
      value = NovinarkoTheme.sepia;
      await hive.storeThemeEnum(NovinarkoThemeEnum.sepia);
    }

    /// Theme is `sepia`, switch to `light`
    else if (value == NovinarkoTheme.sepia) {
      value = NovinarkoTheme.light;
      await hive.storeThemeEnum(NovinarkoThemeEnum.light);
    }
  }
}
