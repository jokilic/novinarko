import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/active_feed_service.dart';
import '../../services/hive_service.dart';
import '../../theme/theme.dart';
import 'widgets/feeds_app_bar.dart';
import 'widgets/feeds_content.dart';

class FeedsScreen extends WatchingWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
            activeFeed: watchIt<ActiveFeedService>().value,
            feeds: watchIt<HiveService>().value.toList(),
          ),
        ),
      );
}
