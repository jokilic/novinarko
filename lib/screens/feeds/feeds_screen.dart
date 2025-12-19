import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/active_feed_service.dart';
import '../../services/hive_service.dart';
import '../../services/settings_service.dart';
import '../../theme/theme.dart';
import '../../util/dependencies.dart';
import '../../util/snowflake/snowflake_widget.dart';
import 'widgets/feeds_app_bar.dart';
import 'widgets/feeds_content.dart';

class FeedsScreen extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final activeFeed = watchIt<ActiveFeedService>().value;
    final feeds = watchIt<HiveService>().value;
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
              activeFeed: activeFeed,
              feeds: feeds.toList(),
              onReorder: getIt.get<HiveService>().reorderFeeds,
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
