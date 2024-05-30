import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants.dart';
import '../../../widgets/novinarko_divider.dart';
import 'news_list_tile_loading.dart';

class NewsLoading extends StatelessWidget {
  final bool showImages;

  const NewsLoading({
    required this.showImages,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (_, index) => NewsListTileLoading(
          showImages: showImages,
        ),
        separatorBuilder: (_, __) => Animate(
          onPlay: (controller) => controller.loop(
            reverse: true,
          ),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: NovinarkoConstants.shimmerDuration,
            ),
          ],
          child: NovinarkoDivider(),
        ),
      );
}
