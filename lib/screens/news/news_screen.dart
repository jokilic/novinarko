import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../routing.dart';
import '../../services/settings_service.dart';
import '../../util/dependencies.dart';
import '../read/read_controller.dart';
import 'news_controller.dart';
import 'widgets/news_app_bar.dart';
import 'widgets/news_content.dart';
import 'widgets/news_floating_action_button.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void dispose() {
    getIt
      ..resetLazySingleton<NewsController>()
      ..resetLazySingleton<ReadController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => NewsWidget();
}

class NewsWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final newsState = watchIt<NewsController>().value;
    final settings = watchIt<SettingsService>().value;
    final readItems = watchIt<ReadController>().value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NewsAppBar(),
      floatingActionButton: settings.useInAppBrowser
          ? Animate(
              autoPlay: false,
              onInit: (controller) => getIt.get<ReadController>().shakeFabController = controller,
              effects: const [
                ShakeEffect(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 450),
                ),
              ],
              child: IgnorePointer(
                ignoring: readItems.isEmpty,
                child: AnimatedOpacity(
                  opacity: readItems.isNotEmpty ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeIn,
                  child: NewsFloatingActionButton(
                    onPressed: () => openRead(
                      context,
                      items: readItems,
                    ),
                    readNumber: readItems.length,
                  ),
                ),
              ),
            )
          : null,
      body: Animate(
        key: ValueKey(newsState),
        effects: const [
          FadeEffect(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 450),
          ),
        ],
        child: NewsContent(
          newsState: newsState,
          readItems: readItems,
          showImages: settings.useImagesInArticles,
          inAppBrowser: settings.useInAppBrowser,
        ),
      ),
    );
  }
}
