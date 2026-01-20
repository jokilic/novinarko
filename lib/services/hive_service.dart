import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../models/feed_model.dart';
import '../models/folder_model.dart';
import '../models/novinarko_settings.dart';
import '../models/novinarko_theme_enum.dart';
import '../util/path.dart';
import 'logger_service.dart';

class HiveService extends ValueNotifier<({List<FeedModel> feeds, List<FolderModel> folders})> implements Disposable {
  final LoggerService logger;

  HiveService(this.logger) : super((feeds: [], folders: []));

  ///
  /// VARIABLES
  ///

  late final Box<NovinarkoSettings> settingsBox;

  late final Box<FolderModel> folderBox;
  late final Box<FeedModel> feedBox;

  late final Box<List<String>> feedFolderOrderBox;

  late final Box<FolderModel> activeFolderBox;
  late final Box<FeedModel> activeFeedBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapter(NovinarkoThemeEnumAdapter())
      ..registerAdapter(NovinarkoSettingsAdapter())
      ..registerAdapter(FolderModelAdapter())
      ..registerAdapter(FeedModelAdapter());

    settingsBox = await Hive.openBox<NovinarkoSettings>('settingsBox');

    folderBox = await Hive.openBox<FolderModel>('folderBox');
    feedBox = await Hive.openBox<FeedModel>('feedBox');

    feedFolderOrderBox = await Hive.openBox<List<String>>('feedFolderOrderBox');

    activeFolderBox = await Hive.openBox<FolderModel>('activeFolderBox');
    activeFeedBox = await Hive.openBox<FeedModel>('activeFeedBox');

    updateState();
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await settingsBox.close();

    await folderBox.close();
    await feedBox.close();

    await feedFolderOrderBox.close();

    await activeFolderBox.close();
    await activeFeedBox.close();

    await Hive.close();
  }

  ///
  /// METHODS
  ///

  /// Reorders `feed` & `folders` in [Hive]
  Future<void> reorderFeedsAndFolders(int oldIndex, int newIndex) async {
    final currentFeeds = List<FeedModel>.from(value.feeds);
    final currentFolders = List<FolderModel>.from(value.folders);

    final order = buildFeedFolderOrder(
      feeds: currentFeeds,
      folders: currentFolders,
    );

    if (order.isEmpty) {
      return;
    }

    final itemKey = order.removeAt(oldIndex);
    order.insert(
      oldIndex < newIndex ? newIndex - 1 : newIndex,
      itemKey,
    );

    await feedFolderOrderBox.put(0, order);

    final feedByKey = {
      for (final feed in currentFeeds) feedOrderKey(feed): feed,
    };
    final folderByKey = {
      for (final folder in currentFolders) folderOrderKey(folder): folder,
    };

    final reorderedFeeds = <FeedModel>[];
    final reorderedFolders = <FolderModel>[];

    for (final key in order) {
      final folder = folderByKey[key];
      final feed = feedByKey[key];

      if (folder != null) {
        reorderedFolders.add(folder);
        continue;
      }

      if (feed != null) {
        reorderedFeeds.add(feed);
      }
    }

    await writeAllFoldersToHive(
      folders: reorderedFolders,
    );

    await writeAllFeedsToHive(
      feeds: reorderedFeeds,
    );
  }

  String feedOrderKey(FeedModel feed) => 'feed:${feed.url ?? feed.siteUrl ?? feed.title ?? feed.description ?? feed.hashCode.toString()}';

  String folderOrderKey(FolderModel folder) => 'folder:${folder.title}';

  List<String> buildFeedFolderOrder({
    required List<FeedModel> feeds,
    required List<FolderModel> folders,
  }) {
    final storedOrder = List<String>.from(
      feedFolderOrderBox.get(0) ?? const [],
    );

    final feedKeys = feeds.map(feedOrderKey).toSet();
    final folderKeys = folders.map(folderOrderKey).toSet();

    final validKeys = {...feedKeys, ...folderKeys};

    final order = <String>[];
    for (final key in storedOrder) {
      if (validKeys.contains(key)) {
        order.add(key);
      }
    }

    for (final folder in folders) {
      final key = folderOrderKey(folder);
      if (!order.contains(key)) {
        order.add(key);
      }
    }

    for (final feed in feeds) {
      final key = feedOrderKey(feed);
      if (!order.contains(key)) {
        order.add(key);
      }
    }

    return order;
  }

  List<Object> getOrderedFeedsAndFolders({
    List<FeedModel>? feeds,
    List<FolderModel>? folders,
  }) {
    final currentFeeds = feeds ?? value.feeds;
    final currentFolders = folders ?? value.folders;

    final order = buildFeedFolderOrder(
      feeds: currentFeeds,
      folders: currentFolders,
    );

    final feedByKey = {
      for (final feed in currentFeeds) feedOrderKey(feed): feed,
    };
    final folderByKey = {
      for (final folder in currentFolders) folderOrderKey(folder): folder,
    };

    return [
      for (final key in order)
        if (folderByKey.containsKey(key)) folderByKey[key]! else if (feedByKey.containsKey(key)) feedByKey[key]!,
    ];
  }

  /// Updates state with values from [Hive]
  void updateState({List<FeedModel>? feeds, List<FolderModel>? folders}) => value = (
    feeds: feeds ?? getFeeds(),
    folders: folders ?? getFolders(),
  );

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
    feeds: List<FeedModel>.from(
      value.feeds..removeAt(index),
    ),
  );

  /// Replace [Hive] box with passed `List<FeedModel>`
  Future<void> writeAllFeedsToHive({required List<FeedModel> feeds}) async {
    /// Update `state`
    updateState(
      feeds: feeds,
    );

    /// Clear current [Hive] box
    await feedBox.clear();

    if (feeds.isNotEmpty) {
      /// Add passed `List<FeedModel>` to [Hive]
      for (var i = 0; i < feeds.length; i++) {
        await storeFeed(
          feed: feeds[i],
          index: i,
        );
      }

      /// Update `state` again
      updateState();
    }
  }

  ///
  /// FOLDERS
  ///

  /// Gets all `folder` values from [Hive]
  List<FolderModel> getFolders() => folderBox.values.toList();

  /// Stores a new `folder` value in [Hive]
  Future<void> storeFolder({
    required FolderModel folder,
    required int index,
  }) async {
    if (folder.title.isNotEmpty) {
      await folderBox.put(index, folder);
    }
  }

  /// Deletes `folder` value from [Hive]
  Future<void> deleteFolder(int index) async => writeAllFoldersToHive(
    folders: List<FolderModel>.from(
      value.folders..removeAt(index),
    ),
  );

  /// Replace [Hive] box with passed `List<FolderModel>`
  Future<void> writeAllFoldersToHive({required List<FolderModel> folders}) async {
    /// Update `state`
    updateState(
      folders: folders,
    );

    /// Clear current [Hive] box
    await folderBox.clear();

    if (folders.isNotEmpty) {
      /// Add passed `List<FeedModel>` to [Hive]
      for (var i = 0; i < folders.length; i++) {
        await storeFolder(
          folder: folders[i],
          index: i,
        );
      }

      /// Update `state` again
      updateState();
    }
  }

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
  /// ACTIVE FOLDER
  ///

  /// Gets `activeFolder` value from [Hive]
  FolderModel? getActiveFolder() => activeFolderBox.get(0);

  /// Stores a new `activeFolder` value in [Hive]
  Future<void> storeActiveFolder(FolderModel folder) async => activeFolderBox.put(0, folder);

  /// Deletes `activeFolder` value from [Hive]
  Future<void> deleteActiveFolder() async => activeFolderBox.clear();

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
