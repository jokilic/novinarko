import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import 'screens/news/news_screen.dart';
import 'screens/search/search_screen.dart';
import 'services/hive_service.dart';
import 'services/settings_service.dart';
import 'services/theme_service.dart';
import 'theme/theme.dart';
import 'util/dependencies.dart';
import 'util/display_mode.dart';
import 'util/snowflake/snowflake_widget.dart';
import 'widgets/novinarko_loader.dart';

/// Feed limit to be used in the app
const feedLimit = 10;

Future<void> main() async {
  /// Initialize Flutter related tasks
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Use `edge-to-edge` display
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// Set refresh rate to high
  await setDisplayMode();

  /// Initialize [EasyLocalization]
  await EasyLocalization.ensureInitialized();

  /// Initialize services
  initializeServices();

  /// Initialize lazy controllers
  initializeControllers();

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Init [Sentry] & run [Novinarko]
  runApp(NovinarkoApp());
}

class NovinarkoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => EasyLocalization(
    useOnlyLangCode: true,
    supportedLocales: const [
      Locale('en'),
      Locale('hr'),
    ],
    fallbackLocale: const Locale('en'),
    path: 'assets/translations',
    child: NovinarkoWidget(),
  );
}

class NovinarkoWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final theme = watchIt<ThemeService>().value;
    final feeds = watchIt<HiveService>().value.toList();
    final settings = watchIt<SettingsService>().value;

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Stack(
          children: [
            ///
            /// CONTENT
            ///
            if (feeds.isNotEmpty) NewsScreen() else SearchScreen(),

            ///
            /// SNOWFLAKES
            ///
            if (settings.showSnowflakes)
              SnowflakeWidget(
                color: context.colors.text.withValues(alpha: 0.6),
                numberOfSnowflakes: 50,
              ),
          ],
        ),
      ),
      onGenerateTitle: (_) => 'appName'.tr(),
      theme: theme ?? NovinarkoTheme.green,
      darkTheme: theme ?? NovinarkoTheme.green,
      builder: (context, child) => kDebugMode
          ? Banner(
              message: 'Debug'.toUpperCase(),
              color: context.colors.text,
              location: BannerLocation.topEnd,
              layoutDirection: TextDirection.ltr,
              child: child ?? const NovinarkoLoader(),
            )
          : child ?? const NovinarkoLoader(),
    );
  }
}
