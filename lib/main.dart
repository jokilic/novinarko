import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import 'screens/news/news_screen.dart';
import 'services/theme_service.dart';
import 'theme/theme.dart';
import 'util/dependencies.dart';

/// Feed limit to be used in the app
const feedLimit = 10;

Future<void> main() async {
  /// Initialize Flutter related tasks
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Initialize [EasyLocalization]
  await EasyLocalization.ensureInitialized();

  /// Initialize services
  initializeServices();

  /// Initialize lazy controllers
  initializeControllers();

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Run [Novinarko]
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
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: NewsScreen(),
        onGenerateTitle: (_) => 'appName'.tr(),
        theme: watchIt<ThemeService>().value,
        builder: (context, child) => kDebugMode
            ? Banner(
                message: 'Debug'.toUpperCase(),
                color: context.colors.text,
                location: BannerLocation.topEnd,
                layoutDirection: TextDirection.ltr,
                child: child ?? const CircularProgressIndicator(),
              )
            : child ?? const CircularProgressIndicator(),
      );
}
