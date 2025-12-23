import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../constants.dart';
import '../../models/feeds_folder_model.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/snackbars.dart';

class FeedsController implements Disposable {
  final LoggerService logger;
  final HiveService hive;

  FeedsController({
    required this.logger,
    required this.hive,
  });

  ///
  /// VARIABLES
  ///

  late final folderNameTextController = TextEditingController();

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    folderNameTextController.dispose();
  }

  ///
  /// METHODS
  ///

  Future<void> addFolderPressed({
    required BuildContext context,
    required BuildContext dialogContext,
  }) async {
    /// Dismiss keyboard
    FocusScope.of(context).unfocus();

    /// Add folder
    final folderAdded = await storeFolder();

    /// Show proper snackbar
    if (folderAdded) {
      showSnackbar(
        context,
        // TODO: Localize
        text: 'Folder added',
        icon: NovinarkoIcons.check,
        isFeeds: true,
      );

      /// Clear [TextEditingControllers]
      clearTextControllers();

      Navigator.of(context).pop();
    } else {
      showSnackbar(
        dialogContext,
        // TODO: Localize
        text: 'Folder not added',
        icon: NovinarkoIcons.close,
        isFeeds: true,
      );
    }
  }

  Future<bool> storeFolder() async {
    final folderTitle = folderNameTextController.text.trim();

    /// Folder title is not typed, exit
    if (folderTitle.isEmpty) {
      return false;
    }

    /// Check if folder already exists
    if (hive.value.folders.any((folder) => folder.name == folderTitle)) {
      return false;
    }

    /// Store folder
    final folder = FeedsFolderModel(
      name: folderTitle,
      feeds: [],
    );

    await hive.storeFolder(
      folder: folder,
      index: hive.value.folders.length,
    );

    return true;
  }

  void clearTextControllers() {
    folderNameTextController.clear();
  }
}
