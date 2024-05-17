import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../models/feed_search_model.dart';
import '../models/novinarko_settings.dart';
import '../models/novinarko_theme_enum.dart';
import 'logger_service.dart';

class HiveService extends ValueNotifier<List<FeedSearchModel>> implements Disposable {
  final LoggerService logger;

  HiveService(this.logger) : super([]);

  ///
  /// VARIABLES
  ///

  late final Box<FeedSearchModel> feedBox;
  late final Box<FeedSearchModel> activeFeedBox;
  late final Box<NovinarkoSettings> settingsBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    Directory? directoryPath;
    if (!kIsWeb) {
      directoryPath = await getApplicationSupportDirectory();
    }

    Hive
      ..init(directoryPath?.path)
      ..registerAdapter(FeedSearchModelAdapter())
      ..registerAdapter(NovinarkoThemeEnumAdapter())
      ..registerAdapter(NovinarkoSettingsAdapter());

    feedBox = await Hive.openBox<FeedSearchModel>('feedBox');
    activeFeedBox = await Hive.openBox<FeedSearchModel>('activeFeedBox');
    settingsBox = await Hive.openBox<NovinarkoSettings>('settingsBox');

    value = getFeeds();
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await feedBox.close();
    await activeFeedBox.close();
    await settingsBox.close();
    await Hive.close();
  }

  ///
  /// FEEDS
  ///

  /// Gets all `feed` values from [Hive]
  List<FeedSearchModel> getFeeds() => feedBox.values.toList();

  /// Stores a new `feed` value in [Hive]
  Future<void> storeFeed(FeedSearchModel feed) async {
    if (feed.url != null) {
      await feedBox.put(feed.url, feed);
      value = getFeeds();
    }
  }

  /// Deletes `feed` value from [Hive]
  Future<void> deleteFeed(FeedSearchModel feed) async {
    await feedBox.delete(feed.url);
    value = getFeeds();
  }

  ///
  /// ACTIVE FEED
  ///

  /// Gets `active feed` value from [Hive]
  FeedSearchModel? getActiveFeed() => activeFeedBox.get(0);

  /// Stores a new `active feed` value in [Hive]
  Future<void> storeActiveFeed(FeedSearchModel feed) async => activeFeedBox.put(0, feed);

  /// Deletes `active feed` value from [Hive]
  Future<void> deleteActiveFeed() async => activeFeedBox.clear();

  ///
  /// SETTINGS
  ///

  /// Gets `settings` value from [Hive]
  NovinarkoSettings getSettings() =>
      settingsBox.get(0) ??
      NovinarkoSettings(
        novinarkoThemeEnum: NovinarkoThemeEnum.light,
        useInAppBrowser: !kIsWeb && (Platform.isAndroid || Platform.isIOS),
        useImagesInArticles: false,
        useAdBlocker: false,
      );

  /// Stores a new `settings` value in [Hive]
  Future<void> storeSettings(NovinarkoSettings novinarkoSettings) async => settingsBox.put(0, novinarkoSettings);
}
