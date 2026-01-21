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

  Future<void> deleteFolder(FolderModel folder) async {
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
