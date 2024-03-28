import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../services/hive_service.dart';
import '../../util/dependencies.dart';
import 'news_controller.dart';
import 'widgets/news_app_bar.dart';
import 'widgets/news_content.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void dispose() {
    getIt.resetLazySingleton<NewsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => NewsWidget();
}

class NewsWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final newsState = watchIt<NewsController>().value;
    final showImages = watchIt<HiveService>().getSettings().useImagesInArticles;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NewsAppBar(),
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
          showImages: showImages,
        ),
      ),
    );
  }
}
