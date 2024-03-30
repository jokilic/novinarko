import 'package:get_it/get_it.dart';

import '../screens/news/news_controller.dart';
import '../screens/read/read_controller.dart';
import '../screens/search/search_controller.dart';
import '../services/active_feed_service.dart';
import '../services/api_service.dart';
import '../services/dio_service.dart';
import '../services/hive_service.dart';
import '../services/logger_service.dart';
import '../services/settings_service.dart';
import '../services/theme_service.dart';

final getIt = GetIt.instance;

void initializeServices() => getIt
  ..registerSingletonAsync(
    () async => LoggerService(),
  )
  ..registerSingletonAsync(
    () async => DioService(
      getIt.get<LoggerService>(),
    ),
    dependsOn: [LoggerService],
  )
  ..registerSingletonAsync(
    () async {
      final hive = HiveService(
        getIt.get<LoggerService>(),
      );
      await hive.init();
      return hive;
    },
    dependsOn: [LoggerService],
  )
  ..registerSingletonAsync(
    () async => APIService(
      logger: getIt.get<LoggerService>(),
      dio: getIt.get<DioService>().dio,
    ),
    dependsOn: [LoggerService, DioService],
  )
  ..registerSingletonAsync(
    () async => SettingsService(
      logger: getIt.get<LoggerService>(),
      hive: getIt.get<HiveService>(),
    ),
    dependsOn: [LoggerService, HiveService],
  )
  ..registerSingletonAsync(
    () async => ThemeService(
      logger: getIt.get<LoggerService>(),
      hive: getIt.get<HiveService>(),
      settings: getIt.get<SettingsService>(),
    ),
    dependsOn: [LoggerService, HiveService, SettingsService],
  )
  ..registerSingletonAsync(
    () async => ActiveFeedService(
      logger: getIt.get<LoggerService>(),
      hive: getIt.get<HiveService>(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

void initializeControllers() => getIt
  ..registerLazySingleton(
    () => SearchController(
      logger: getIt.get<LoggerService>(),
      api: getIt.get<APIService>(),
      hive: getIt.get<HiveService>(),
      activeFeedService: getIt.get<ActiveFeedService>(),
    ),
  )
  ..registerLazySingleton(
    () => NewsController(
      logger: getIt.get<LoggerService>(),
      api: getIt.get<APIService>(),
      hive: getIt.get<HiveService>(),
      activeFeedService: getIt.get<ActiveFeedService>(),
    )..init(),
  )
  ..registerLazySingleton(
    () => ReadController(
      logger: getIt.get<LoggerService>(),
    ),
  );
