import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../models/feed_search_model.dart';
import '../models/feeds_folder_model.dart';
import '../models/novinarko_settings.dart';
import '../models/novinarko_theme_enum.dart';
import '../util/path.dart';
import 'logger_service.dart';

class HiveService extends ValueNotifier<({List<FeedSearchModel> feeds, List<FeedsFolderModel> folders})> implements Disposable {
  final LoggerService logger;

  HiveService(this.logger) : super((feeds: [], folders: []));

  ///
  /// VARIABLES
  ///

  late final Box<FeedSearchModel> feedBox;
  late final Box<FeedsFolderModel> folderBox;
  late final Box<FeedSearchModel> activeFeedBox;
  late final Box<NovinarkoSettings> settingsBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapter(FeedSearchModelAdapter())
      ..registerAdapter(FeedsFolderModelAdapter())
      ..registerAdapter(NovinarkoThemeEnumAdapter())
      ..registerAdapter(NovinarkoSettingsAdapter());

    feedBox = await Hive.openBox<FeedSearchModel>('feedBox');
    folderBox = await Hive.openBox<FeedsFolderModel>('folderBox');
    activeFeedBox = await Hive.openBox<FeedSearchModel>('activeFeedBox');
    settingsBox = await Hive.openBox<NovinarkoSettings>('settingsBox');

    updateState();
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await feedBox.close();
    await folderBox.close();
    await activeFeedBox.close();
    await settingsBox.close();

    await Hive.close();
  }

  ///
  /// METHODS
  ///

  /// Updates state with values from [Hive]
  void updateState({List<FeedSearchModel>? feeds, List<FeedsFolderModel>? folders}) {
    value = (
      feeds: feeds ?? getFeeds(),
      folders: folders ?? getFolders(),
    );
  }

  ///
  /// FEEDS
  ///

  /// Gets all `feed` values from [Hive]
  List<FeedSearchModel> getFeeds() => feedBox.values.toList();

  /// Stores a new `feed` value in [Hive]
  Future<void> storeFeed({
    required FeedSearchModel feed,
    required int index,
  }) async {
    if (feed.url != null) {
      await feedBox.put(index, feed);
    }
  }

  /// Deletes `feed` value from [Hive]
  Future<void> deleteFeed(int index) async => writeAllFeedsToHive(
    feeds: List.from(
      value.feeds..removeAt(index),
    ),
  );

  /// Reorders `feed` in [Hive]
  Future<void> reorderFeeds(int oldIndex, int newIndex) async {
    /// Rearange feeds
    final list = List<FeedSearchModel>.from(value.feeds);

    final item = list.removeAt(oldIndex);

    list.insert(
      oldIndex < newIndex ? newIndex - 1 : newIndex,
      item,
    );

    /// Update all feeds in [Hive]
    await writeAllFeedsToHive(feeds: list);
  }

  /// Replace [Hive] box with passed `List<FeedSearchModel>`
  Future<void> writeAllFeedsToHive({required List<FeedSearchModel> feeds}) async {
    /// Update `state`
    updateState(
      feeds: feeds,
    );

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

  ///
  /// FOLDERS
  ///

  /// Gets all `folder` values from [Hive]
  List<FeedsFolderModel> getFolders() => folderBox.values.toList();

  /// Stores a new `folder` value in [Hive]
  Future<void> storeFolder({
    required FeedsFolderModel folder,
    required int index,
  }) async {
    await folderBox.put(index, folder);
  }

  /// Deletes `folder` value from [Hive]
  Future<void> deleteFolder(int index) async => writeAllFeedsToHive(
    feeds: List.from(value.folders..removeAt(index)),
  );

  /// Reorders `folders` in [Hive]
  Future<void> reorderFolders(int oldIndex, int newIndex) async {
    /// Rearange folders
    final list = List<FeedsFolderModel>.from(value.folders);

    final item = list.removeAt(oldIndex);

    list.insert(
      oldIndex < newIndex ? newIndex - 1 : newIndex,
      item,
    );

    /// Update all feeds in [Hive]
    await writeAllFoldersToHive(folders: list);
  }

  /// Replace [Hive] box with passed `List<FeedsFolderModel>`
  Future<void> writeAllFoldersToHive({required List<FeedsFolderModel> folders}) async {
    /// Update `state`
    updateState(
      folders: folders,
    );

    /// Clear current [Hive] box
    await folderBox.clear();

    if (folders.isNotEmpty) {
      /// Add passed `List<FeedsFolderModel>` to [Hive]
      for (var i = 0; i < folders.length; i++) {
        await storeFolder(folder: folders[i], index: i);
      }

      /// Update `state` again (needed because issues with `GlobalKey`)
      updateState();
    }
  }

  ///
  /// ACTIVE FEED
  ///

  /// Gets `activeFeed` value from [Hive]
  FeedSearchModel? getActiveFeed() => activeFeedBox.get(0);

  /// Stores a new `activeFeed` value in [Hive]
  Future<void> storeActiveFeed(FeedSearchModel feed) async => activeFeedBox.put(0, feed);

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
