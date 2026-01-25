import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/active_feed_folder_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/settings_service.dart';
import '../../theme/theme.dart';
import '../../util/dependencies.dart';
import '../../util/snowflake/snowflake_widget.dart';
import 'folder_controller.dart';
import 'widgets/folder_app_bar.dart';
import 'widgets/folder_content.dart';

class FolderScreen extends StatefulWidget {
  final String passedFolderName;

  const FolderScreen({
    required this.passedFolderName,
  });

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  @override
  void initState() {
    super.initState();

    getIt.registerLazySingleton(
      () => FolderController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
        activeFeedFolder: getIt.get<ActiveFeedFolderService>(),
      ),
      instanceName: widget.passedFolderName,
    );
  }

  @override
  void dispose() {
    getIt.unregister<FolderController>(
      instanceName: widget.passedFolderName,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FolderWidget(
    instanceName: widget.passedFolderName,
  );
}

class FolderWidget extends WatchingWidget {
  final String instanceName;

  const FolderWidget({
    required this.instanceName,
  });

  @override
  Widget build(BuildContext context) {
    final activeFeedFolderState = watchIt<ActiveFeedFolderService>().value;
    final activeFeed = activeFeedFolderState?.feed;
    final activeFolder = activeFeedFolderState?.folder;

    final folderToWatch = watchIt<HiveService>().value.folders
        .where(
          (f) => f.title == instanceName,
        )
        .firstOrNull;

    final settings = watchIt<SettingsService>().value;

    return Stack(
      children: [
        ///
        /// CONTENT
        ///
        Scaffold(
          backgroundColor: context.colors.text,
          extendBodyBehindAppBar: true,
          appBar: FolderAppBar(
            instanceName: instanceName,
          ),
          body: Animate(
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: NovinarkoConstants.animationDuration,
              ),
            ],
            child: FolderContent(
              folder: folderToWatch,
              activeFeed: activeFeed,
              activeFolder: activeFolder,
              onReorder: (oldIndex, newIndex) => getIt
                  .get<FolderController>(
                    instanceName: instanceName,
                  )
                  .reorderFeeds(
                    oldIndex,
                    newIndex,
                    folder: folderToWatch,
                  ),
              fontFamily: settings.fontFamily,
            ),
          ),
        ),

        ///
        /// SNOWFLAKES
        ///
        if (settings.showSnowflakes)
          SnowflakeWidget(
            color: context.colors.background.withValues(alpha: 0.6),
          ),
      ],
    );
  }
}
