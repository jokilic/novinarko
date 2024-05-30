import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/hive_service.dart';
import '../../services/settings_service.dart';
import '../../util/dependencies.dart';
import 'search_controller.dart';
import 'widgets/search_app_bar.dart';
import 'widgets/search_content.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    getIt.resetLazySingleton<SearchController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SearchWidget();
}

class SearchWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchState = watchIt<SearchController>().value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SearchAppBar(
        onSubmitted: (value) => getIt.get<SearchController>().searchTriggered(value.trim()),
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
          hiveFeeds: watchIt<HiveService>().value,
          shimmerLoader: watchIt<SettingsService>().value.useShimmerLoader,
        ),
      ),
    );
  }
}
