import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants.dart';
import '../../../widgets/novinarko_divider.dart';
import 'search_list_tile_loading.dart';

class SearchLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (_, index) => SearchListTileLoading(),
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
