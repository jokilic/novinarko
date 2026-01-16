import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/hive_service.dart';
import '../../services/settings_service.dart';
import '../../theme/theme.dart';
import '../../util/snowflake/snowflake_widget.dart';
import 'search_controller.dart';
import 'widgets/search_app_bar.dart';
import 'widgets/search_content.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  // @override
  // void dispose() {
  //   getIt.resetLazySingleton<SearchController>();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => SearchWidget();
}

class SearchWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchState = watchIt<SearchController>().value;
    final settings = watchIt<SettingsService>().value;
    final hiveState = watchIt<HiveService>().value;

    return Stack(
      children: [
        ///
        /// CONTENT
        ///
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: SearchAppBar(
            hasFeeds: hiveState.feeds.isNotEmpty,
          ),
          body: Animate(
            key: ValueKey(searchState),
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: NovinarkoConstants.animationDuration,
              ),
            ],
            child: SearchContent(
              searchState: searchState,
              hiveFeeds: hiveState.feeds,
              shimmerLoader: settings.useShimmerLoader,
              fontFamily: settings.fontFamily,
            ),
          ),
        ),

        ///
        /// SNOWFLAKES
        ///
        if (settings.showSnowflakes)
          SnowflakeWidget(
            color: context.colors.text.withValues(alpha: 0.6),
            numberOfSnowflakes: 50,
          ),
      ],
    );
  }
}
