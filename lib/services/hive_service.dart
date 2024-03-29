import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/feed_search_model.dart';
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
  late final Box<NovinarkoThemeEnum> themeBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(FeedSearchModelAdapter())
      ..registerAdapter(NovinarkoThemeEnumAdapter());

    feedBox = await Hive.openBox<FeedSearchModel>('feedBox');
    activeFeedBox = await Hive.openBox<FeedSearchModel>('activeFeedBox');
    themeBox = await Hive.openBox<NovinarkoThemeEnum>('themeBox');

    value = getFeeds();
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await feedBox.close();
    await activeFeedBox.close();
    await themeBox.close();
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
  /// THEME
  ///

  /// Gets `theme` value from [Hive]
  NovinarkoThemeEnum getThemeEnum() => themeBox.get(0) ?? NovinarkoThemeEnum.light;

  /// Stores a new `theme` value in [Hive]
  Future<void> storeThemeEnum(NovinarkoThemeEnum novinarkoThemeEnum) async => themeBox.put(0, novinarkoThemeEnum);
}
