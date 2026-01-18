import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../models/folder_model.dart';
import '../../services/active_feed_folder_service.dart';
import '../../services/hive_service.dart';
import '../../services/settings_service.dart';
import '../../theme/theme.dart';
import '../../util/dependencies.dart';
import '../../util/snowflake/snowflake_widget.dart';
import 'widgets/folder_app_bar.dart';
import 'widgets/folder_content.dart';

class FolderScreen extends WatchingWidget {
  final FolderModel folder;

  const FolderScreen({
    required this.folder,
  });

  @override
  Widget build(BuildContext context) {
    final hiveState = watchIt<HiveService>().value;
    final feeds = hiveState.feeds;
    final folders = hiveState.folders;

    final activeFeedFolderState = watchIt<ActiveFeedFolderService>().value;
    final activeFeed = activeFeedFolderState?.feed;
    final activeFolder = activeFeedFolderState?.folder;

    final settings = watchIt<SettingsService>().value;

    return Stack(
      children: [
        ///
        /// CONTENT
        ///
        Scaffold(
          backgroundColor: context.colors.text,
          extendBodyBehindAppBar: true,
          appBar: FolderAppBar(),
          body: Animate(
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: NovinarkoConstants.animationDuration,
              ),
            ],
            child: FolderContent(
              folder: folder,
              activeFeed: activeFeed,
              activeFolder: activeFolder,
              onReorder: getIt.get<HiveService>().reorderFolders,
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
            numberOfSnowflakes: 50,
          ),
      ],
    );
  }
}
