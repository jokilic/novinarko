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

  Future<void> reorderFeeds(int oldIndex, int newIndex) async {
    // TODO: Reorder feeds within this folder
  }

  Future<void> addFeed({
    required FeedModel feed,
    required FolderModel folder,
  }) async {
    // TODO: I add a feed from dialog, all works well, then I add another feed to the same folder, it doesn't work (folderIndex == -1)

    logger.f('Adding -> ${feed.title}');

    final folderIndex = hive.getFolders().indexOf(folder);
    logger.f('Index == $folderIndex');

    if (folderIndex == -1) {
      return;
    }

    final updatedFolder = FolderModel(
      title: folder.title,
      description: folder.description,
      feeds: [...?folder.feeds, feed],
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
