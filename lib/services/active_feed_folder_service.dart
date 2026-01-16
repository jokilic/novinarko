import 'package:flutter/material.dart';

import '../models/feed_model.dart';
import '../models/folder_model.dart';
import '../screens/news/controllers/news_controller.dart';
import '../util/dependencies.dart';
import 'hive_service.dart';
import 'logger_service.dart';

/// Class to distinguish `no argument passed` from `explicitly passed null`
class ActiveFeedFolderStateNoChange {
  const ActiveFeedFolderStateNoChange();
}

const activeFeedFolderStateNoChange = ActiveFeedFolderStateNoChange();

class ActiveFeedFolderService extends ValueNotifier<({FeedModel? feed, FolderModel? folder})?> {
  final LoggerService logger;
  final HiveService hive;

  ActiveFeedFolderService({
    required this.logger,
    required this.hive,
  }) : super((feed: hive.getActiveFeed(), folder: hive.getActiveFolder()));

  ///
  /// FEED
  ///

  Future<void> updateActiveFeed(FeedModel? feed) async {
    /// `feed` passed, store value in [Hive]
    if (feed != null) {
      await hive.storeActiveFeed(feed);
    }

    /// `null` passed, remove value from [Hive]
    if (feed == null) {
      await hive.deleteActiveFeed();
    }

    /// Update state
    final newFeed = hive.getActiveFeed();
    updateState(
      feed: newFeed,
      isFeedEmpty: newFeed == null,
    );
  }

  Future<void> storeOrDeleteFeed(FeedModel feed) async {
    /// Store `feed` in [Hive]
    if (!hive.value.feeds.contains(feed)) {
      await hive.storeFeed(
        feed: feed,
        index: hive.value.feeds.length,
      );

      hive.updateState();

      /// Refresh [NewsController] if `activeFeed == null`
      if (value?.feed == null) {
        if (getIt.isRegistered<NewsController>()) {
          await getIt.get<NewsController>().loadFeed(null);
        }
      }
    }
    /// Delete `feed` from [Hive]
    else {
      await hive.deleteFeed(
        hive.value.feeds.indexOf(feed),
      );

      if (feed == value?.feed) {
        await updateActiveFeed(null);

        /// Set `activeFeed = null` if deleted feed was the active one
        if (getIt.isRegistered<NewsController>()) {
          await getIt.get<NewsController>().loadFeed(null);
        }
      }
    }
  }

  ///
  /// FOLDER
  ///

  Future<void> updateActiveFolder(FolderModel? folder) async {
    /// `folder` passed, store value in [Hive]
    if (folder != null) {
      await hive.storeActiveFolder(folder);
    }

    /// `null` passed, remove value from [Hive]
    if (folder == null) {
      await hive.deleteActiveFolder();
    }

    /// Update state
    final newFolder = hive.getActiveFolder();
    updateState(
      folder: newFolder,
      isFolderEmpty: newFolder == null,
    );
  }

  Future<void> storeOrDeleteFolder(FolderModel folder) async {
    /// Store `folder` in [Hive]
    if (!hive.value.folders.contains(folder)) {
      await hive.storeFolder(
        folder: folder,
        index: hive.value.folders.length,
      );

      hive.updateState();
    }
    /// Delete `folder` from [Hive]
    else {
      await hive.deleteFolder(
        hive.value.folders.indexOf(folder),
      );

      if (folder == value?.folder) {
        await updateActiveFolder(null);
      }
    }
  }

  /// Updates `state`
  void updateState({
    FeedModel? feed,
    FolderModel? folder,
    bool isFeedEmpty = false,
    bool isFolderEmpty = false,
  }) => value = (
    feed: isFeedEmpty ? null : feed ?? value?.feed,
    folder: isFolderEmpty ? null : folder ?? value?.folder,
  );
}
