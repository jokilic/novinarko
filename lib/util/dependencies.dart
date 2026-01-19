import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../screens/feeds/feeds_controller.dart';
import '../screens/news/controllers/news_controller.dart';
import '../screens/news/controllers/news_read_controller.dart';
import '../screens/news/controllers/news_read_loader_controller.dart';
import '../screens/read/controllers/read_controller.dart';
import '../screens/read/controllers/read_loader_controller.dart';
import '../screens/read/controllers/web_buttons_controller.dart';
import '../screens/search/search_controller.dart';
import '../services/active_feed_folder_service.dart';
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
      internetConnection: InternetConnection(),
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
    () async => ActiveFeedFolderService(
      logger: getIt.get<LoggerService>(),
      hive: getIt.get<HiveService>(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

void initializeControllers() {
  getIt
    ..registerSingletonAsync(
      () async => SearchController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
        hive: getIt.get<HiveService>(),
        activeFeedService: getIt.get<ActiveFeedFolderService>(),
      ),
      dependsOn: [LoggerService, APIService, HiveService, ActiveFeedFolderService],
    )
    ..registerSingletonAsync(
      () async => FeedsController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
        activeFeedService: getIt.get<ActiveFeedFolderService>(),
      ),
      dependsOn: [LoggerService, HiveService, ActiveFeedFolderService],
    )
    ..registerLazySingleton(
      () => NewsReadLoaderController(
        logger: getIt.get<LoggerService>(),
      ),
    )
    ..registerLazySingleton(
      () => NewsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
        hive: getIt.get<HiveService>(),
        activeFeedService: getIt.get<ActiveFeedFolderService>(),
      )..init(),
    )
    ..registerLazySingleton(
      () => NewsReadController(
        logger: getIt.get<LoggerService>(),
        settings: getIt.get<SettingsService>(),
        loader: getIt.get<NewsReadLoaderController>(),
      ),
    )
    ..registerLazySingleton(
      () => WebButtonsController(
        logger: getIt.get<LoggerService>(),
      ),
    )
    ..registerLazySingleton(
      () => ReadLoaderController(
        logger: getIt.get<LoggerService>(),
      ),
    )
    ..registerLazySingleton(
      () => ReadController(
        logger: getIt.get<LoggerService>(),
        webButtons: getIt.get<WebButtonsController>(),
      ),
    );
}
