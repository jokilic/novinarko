import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/hive_service.dart';
import '../../services/settings_service.dart';
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
    final hiveFeeds = watchIt<HiveService>().value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SearchAppBar(
        hasFeeds: hiveFeeds.isNotEmpty,
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
          hiveFeeds: hiveFeeds,
          shimmerLoader: settings.useShimmerLoader,
          fontFamily: settings.fontFamily,
        ),
      ),
    );
  }
}
