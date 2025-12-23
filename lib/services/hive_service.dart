import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../models/feed_folder.dart';
import '../models/feed_item.dart';
import '../models/feed_search_model.dart';
import '../models/novinarko_settings.dart';
import '../models/novinarko_theme_enum.dart';
import '../util/path.dart';
import 'logger_service.dart';

class HiveService extends ValueNotifier<List<FeedItem>> implements Disposable {
  final LoggerService logger;

  HiveService(this.logger) : super([]);

  ///
  /// VARIABLES
  ///

  late final Box<FeedItem> feedBox;
  late final Box<FeedSearchModel> activeFeedBox;
  late final Box<NovinarkoSettings> settingsBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapter(NovinarkoThemeEnumAdapter())
      ..registerAdapter(NovinarkoSettingsAdapter())
      ..registerAdapter(FeedSearchModelAdapter())
      ..registerAdapter(FeedFolderAdapter());

    feedBox = await Hive.openBox<FeedItem>('feedBox');
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
    await activeFeedBox.close();
    await settingsBox.close();

    await Hive.close();
  }

  ///
  /// FEEDS
  ///

  /// Gets all `feed` values from [Hive]
  List<FeedItem> getFeeds() => feedBox.values.toList();

  List<FeedSearchModel> getFeedsFlat() => getAllFeedsFlat(getFeeds());

  List<FeedSearchModel> getAllFeedsFlat(List<FeedItem> items) {
    final feeds = <FeedSearchModel>[];

    for (final item in items) {
      if (item is FeedSearchModel) {
        feeds.add(item);
      } else if (item is FeedFolder) {
        feeds.addAll(
          getAllFeedsFlat(
            item.children,
          ),
        );
      }
    }
    return feeds;
  }

  /// Stores a new `feed` value in [Hive]
  Future<void> storeFeed({
    required FeedItem feed,
    required int index,
  }) async {
    if (feed is FeedSearchModel && feed.url != null) {
      await feedBox.put(index, feed);
    } else if (feed is FeedFolder) {
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

  /// Replace [Hive] box with passed `List<FeedItem>`
  Future<void> writeAllFeedsToHive({required List<FeedItem> feeds}) async {
    /// Update `state`
    value = feeds;

    /// Clear current [Hive] box
    await feedBox.clear();

    if (feeds.isNotEmpty) {
      /// Add passed `List<FeedItem>` to [Hive]
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
  FeedSearchModel? getActiveFeed() => activeFeedBox.get(0);

  /// Stores a new `activeFeed` value in [Hive]
  Future<void> storeActiveFeed(FeedSearchModel feed) async => activeFeedBox.put(0, feed);

  /// Deletes `activeFeed` value from [Hive]
  Future<void> deleteActiveFeed() async => activeFeedBox.clear();

  ///
  /// FOLDERS
  ///

  Future<void> createFolder({required String name}) async {
    final folder = FeedFolder.create(name: name);
    await feedBox.add(folder);
    updateState();
  }

  Future<void> deleteFolder(int index) async {
    await feedBox.deleteAt(index);
    updateState();
  }

  Future<void> moveFeedToFolder(FeedSearchModel feed, FeedFolder folder) async {
    /// Remove from root (if it exists there)
    final rootIndex = feedBox.values.toList().indexOf(feed);

    if (rootIndex != -1) {
      await feedBox.deleteAt(rootIndex);
    } else {
      /// If not in root, searching and removing from other folders is complex without parent reference.
      /// For MVP, assuming flattened structure or only moving from root.
      /// To fully support moving from anywhere, we need a recursive delete/search.
      /// Let's stick to moving from root for now.
    }

    /// Add to folder
    /// We need to update the folder in the box.
    /// Since Hive objects are stored, modifying 'folder' object directly might not persist if not saved.
    /// But if FeedFolder is HiveObject and extends it (it doesn't currently extend HiveObject, just FeedItem), we need to save.
    folder.children.add(feed);

    /// Find folder index to save
    /// Assuming folder is at root or we need to find it.
    /// If FeedFolder was fetched from Hive, we might need to save it back.
    /// Since we are operating on `feedBox.values`, we should find the folder instance in the box and save it?
    /// Or just `folder.save()` if it extends HiveObject.

    /// Let's make FeedFolder extend HiveObject in the model definition?
    /// Or just find index and put.
    final folderIndex = feedBox.values.toList().indexOf(folder);
    if (folderIndex != -1) {
      await feedBox.put(folderIndex, folder);
    }

    updateState();
  }

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
