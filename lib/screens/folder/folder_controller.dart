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
}
