import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/active_feed_folder_service.dart';
import '../../services/hive_service.dart';
import '../../services/settings_service.dart';
import '../../theme/theme.dart';
import '../../util/dependencies.dart';
import '../../util/snowflake/snowflake_widget.dart';
import 'feeds_controller.dart';
import 'widgets/feeds_app_bar.dart';
import 'widgets/feeds_content.dart';

class FeedsScreen extends WatchingStatefulWidget {
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  void dispose() {
    getIt.get<FeedsController>().clearCustomTextControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FeedsWidget();
}

class FeedsWidget extends WatchingWidget {
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
          appBar: FeedsAppBar(),
          body: Animate(
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: NovinarkoConstants.animationDuration,
              ),
            ],
            child: FeedsContent(
              feeds: feeds.toList(),
              folders: folders.toList(),
              activeFeed: activeFeed,
              activeFolder: activeFolder,
              onReorder: getIt.get<HiveService>().reorderFeedsAndFolders,
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
