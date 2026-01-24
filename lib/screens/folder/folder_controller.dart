import '../../models/feed_model.dart';
import '../../models/folder_model.dart';
import '../../services/active_feed_folder_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';

class FolderController {
  final LoggerService logger;
  final HiveService hive;
  final ActiveFeedFolderService activeFeedFolder;

  FolderController({
    required this.logger,
    required this.hive,
    required this.activeFeedFolder,
  });

  ///
  /// METHODS
  ///

  Future<void> reorderFeeds(
    int oldIndex,
    int newIndex, {
    required FolderModel? folder,
  }) async {
    if (folder == null) {
      return;
    }

    final folders = hive.getFolders();
    final folderIndex = folders.indexWhere(
      (item) => item.title == folder.title,
    );

    if (folderIndex == -1) {
      return;
    }

    final currentFolder = folders[folderIndex];
    final currentFeeds = List<FeedModel>.from(
      currentFolder.feeds ?? const [],
    );

    if (currentFeeds.isEmpty || oldIndex < 0 || oldIndex >= currentFeeds.length) {
      return;
    }

    final feed = currentFeeds.removeAt(oldIndex);
    currentFeeds.insert(
      oldIndex < newIndex ? newIndex - 1 : newIndex,
      feed,
    );

    final updatedFolder = FolderModel(
      title: currentFolder.title,
      description: currentFolder.description,
      feeds: currentFeeds,
    );

    await hive.storeFolder(
      folder: updatedFolder,
      index: folderIndex,
    );

    hive.updateState();
  }

  Future<void> addFeed({
    required FeedModel feed,
    required FolderModel folder,
  }) async {
    final folders = hive.getFolders();
    final folderIndex = folders.indexWhere(
      (item) => item.title == folder.title,
    );

    if (folderIndex == -1) {
      return;
    }

    final currentFolder = folders[folderIndex];
    final updatedFolder = FolderModel(
      title: currentFolder.title,
      description: currentFolder.description,
      feeds: [...?currentFolder.feeds, feed],
    );

    await hive.storeFolder(
      folder: updatedFolder,
      index: folderIndex,
    );

    hive.updateState();
  }

  Future<void> deleteFeed({
    required FeedModel feed,
    required FolderModel folder,
  }) async {
    final folderIndex = hive.getFolders().indexOf(folder);
    if (folderIndex == -1) {
      return;
    }

    final updatedFolder = FolderModel(
      title: folder.title,
      description: folder.description,
      feeds: List<FeedModel>.from(
        folder.feeds ?? []
          ..remove(feed),
      ),
    );

    await hive.storeFolder(
      folder: updatedFolder,
      index: folderIndex,
    );

    hive.updateState();
  }

  Future<void> deleteFolder({required FolderModel? folder}) async {
    if (folder == null) {
      return;
    }

    /// Find the `index` of passed `folder`
    final index = hive.getFolders().indexOf(folder);

    /// Passed `folder` is not found
    if (index == -1) {
      logger.w('FolderController -> deleteFolder() -> folder not found: ${folder.title}');
      return;
    }

    /// Delete `folder`
    await hive.deleteFolder(index);

    /// Remove `activeFolder` if deleted `folder` was active
    if (activeFeedFolder.value?.folder == folder) {
      await activeFeedFolder.updateActiveFolder(null);
    }
  }
}
