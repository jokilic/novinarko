import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../models/feed_model.dart';
import '../models/novinarko_settings.dart';
import '../models/novinarko_theme_enum.dart';
import '../util/path.dart';
import 'logger_service.dart';

class HiveService extends ValueNotifier<List<FeedModel>> implements Disposable {
  final LoggerService logger;

  HiveService(this.logger) : super([]);

  ///
  /// VARIABLES
  ///

  late final Box<FeedModel> feedBox;
  late final Box<FeedModel> activeFeedBox;
  late final Box<NovinarkoSettings> settingsBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapter(FeedModelAdapter())
      ..registerAdapter(NovinarkoThemeEnumAdapter())
      ..registerAdapter(NovinarkoSettingsAdapter());

    feedBox = await Hive.openBox<FeedModel>('feedBox');
    activeFeedBox = await Hive.openBox<FeedModel>('activeFeedBox');
    settingsBox = await Hive.openBox<NovinarkoSettings>('settingsBox');

    updateState();
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
  List<FeedModel> getFeeds() => feedBox.values.toList();

  /// Stores a new `feed` value in [Hive]
  Future<void> storeFeed({
    required FeedModel feed,
    required int index,
  }) async {
    if (feed.url != null) {
      await feedBox.put(index, feed);
    }
  }

  /// Deletes `feed` value from [Hive]
  Future<void> deleteFeed(int index) async => writeAllFeedsToHive(
    feeds: List.from(value..removeAt(index)),
  );

  /// Reorders `feed` in [Hive]
  Future<void> reorderFeeds(int oldIndex, int newIndex) async {
    /// Rearange feeds
    final item = value.removeAt(oldIndex);
    value.insert(
      oldIndex < newIndex ? newIndex - 1 : newIndex,
      item,
    );

    /// Update all feeds in [Hive]
    await writeAllFeedsToHive(feeds: value);
  }

  /// Replace [Hive] box with passed `List<FeedSearchModel>`
  Future<void> writeAllFeedsToHive({required List<FeedModel> feeds}) async {
    /// Update `state`
    value = feeds;

    /// Clear current [Hive] box
    await feedBox.clear();

    if (feeds.isNotEmpty) {
      /// Add passed `List<FeedSearchModel>` to [Hive]
      for (var i = 0; i < feeds.length; i++) {
        await storeFeed(feed: feeds[i], index: i);
      }

      /// Update `state` again (needed because issues with `GlobalKey`)
      updateState();
    }
  }

  /// Updates state with values from [Hive]
  void updateState() => value = getFeeds();

  ///
  /// ACTIVE FEED
  ///

  /// Gets `activeFeed` value from [Hive]
  FeedModel? getActiveFeed() => activeFeedBox.get(0);

  /// Stores a new `activeFeed` value in [Hive]
  Future<void> storeActiveFeed(FeedModel feed) async => activeFeedBox.put(0, feed);

  /// Deletes `activeFeed` value from [Hive]
  Future<void> deleteActiveFeed() async => activeFeedBox.clear();

  ///
  /// SETTINGS
  ///

  /// Gets `settings` value from [Hive]
  NovinarkoSettings getSettings() =>
      settingsBox.get(0) ??
      NovinarkoSettings(
        novinarkoThemeEnum: null,
        useInAppBrowser: !kIsWeb,
        useImagesInArticles: true,
        useAdBlocker: false,
        useShimmerLoader: true,
        fontFamily: 'Merriweather',
        showSnowflakes: false,
      );

  /// Stores a new `settings` value in [Hive]
  Future<void> storeSettings(NovinarkoSettings novinarkoSettings) async => settingsBox.put(0, novinarkoSettings);
}
