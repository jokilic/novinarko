import 'package:flutter/material.dart';

import '../models/feed_search_model.dart';
import '../screens/news/controllers/news_controller.dart';
import '../util/dependencies.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class ActiveFeedService extends ValueNotifier<FeedSearchModel?> {
  final LoggerService logger;
  final HiveService hive;

  ActiveFeedService({
    required this.logger,
    required this.hive,
  }) : super(hive.getActiveFeed());

  ///
  /// METHODS
  ///

  Future<void> updateActiveFeed(FeedSearchModel? feed) async {
    /// `feed` passed, store value in [Hive]
    if (feed != null) {
      await hive.storeActiveFeed(feed);
    }

    /// `null` passed, remove value from [Hive]
    if (feed == null) {
      await hive.deleteActiveFeed();
    }

    /// Update state
    value = hive.getActiveFeed();
  }

  Future<void> storeOrDeleteFeed(FeedSearchModel feed) async {
    /// Store `feed` in [Hive] and refresh if `activeFeed == null`
    if (!hive.value.contains(feed)) {
      await hive.storeFeed(
        feed: feed,
        index: hive.value.length,
      );
      hive.updateState();

      if (value == null) {
        if (getIt.isRegistered<NewsController>()) {
          await getIt.get<NewsController>().loadFeed(null);
        }
      }
    }

    /// Delete `feed` from [Hive] and set `activeFeed = null` if deleted feed was the active one
    else {
      await hive.deleteFeed(
        hive.value.indexOf(feed),
      );

      if (feed == value) {
        await updateActiveFeed(null);

        if (getIt.isRegistered<NewsController>()) {
          await getIt.get<NewsController>().loadFeed(null);
        }
      }
    }
  }
}
