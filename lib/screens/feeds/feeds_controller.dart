import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../constants.dart';
import '../../models/folder_model.dart';
import '../../services/active_feed_folder_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/snackbars.dart';

class FeedsController implements Disposable {
  final LoggerService logger;
  final HiveService hive;
  final ActiveFeedFolderService activeFeedFolder;

  FeedsController({
    required this.logger,
    required this.hive,
    required this.activeFeedFolder,
  });

  ///
  /// VARIABLES
  ///

  late final folderTitleTextController = TextEditingController();
  late final folderDescriptionTextController = TextEditingController();

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    folderTitleTextController.dispose();
    folderDescriptionTextController.dispose();
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
    final folderAdded = await storeCustomFolder();

    /// Show proper snackbar
    if (folderAdded) {
      showSnackbar(
        context,
        text: 'folderDialogFolderAdded'.tr(),
        icon: NovinarkoIcons.check,
        isDark: true,
      );

      /// Clear [TextEditingControllers]
      clearCustomTextControllers();

      /// Remove dialog
      Navigator.of(context).pop();
    } else {
      showSnackbar(
        dialogContext,
        text: 'folderDialogFolderAlreadyExists'.tr(),
        icon: NovinarkoIcons.close,
        isDark: true,
      );
    }
  }

  Future<bool> storeCustomFolder() async {
    final folderTitle = folderTitleTextController.text.trim();
    final descriptionTitle = folderDescriptionTextController.text.trim();

    /// Title is not typed, exit
    if (folderTitle.isEmpty) {
      return false;
    }

    /// Check if `folder` already exists
    final folderExists = hive.getFolders().any((folder) => folder.title == folderTitle);

    /// Store custom folder
    if (!folderExists) {
      final folder = FolderModel(
        title: folderTitle,
        description: descriptionTitle,
        feeds: [],
      );

      await activeFeedFolder.storeOrDeleteFolder(folder);

      return true;
    }

    return false;
  }

  void clearCustomTextControllers() {
    folderTitleTextController.clear();
    folderDescriptionTextController.clear();
  }
}
