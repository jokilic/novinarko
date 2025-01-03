import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class SearchListTileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material(
        color: context.colors.text.withValues(alpha: 0),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {},
          highlightColor: context.colors.primary.withValues(alpha: 0.6),
          splashColor: context.colors.primary.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          child: Animate(
            onPlay: (controller) => controller.loop(
              reverse: true,
              min: 0.6,
            ),
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: NovinarkoConstants.shimmerDuration,
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  ///
                  /// Title & favicon
                  ///
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              1,
                              (_) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: context.colors.text,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 24),

                      /// Favicon
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.colors.text,
                            width: 2,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///
                  /// Description
                  ///
                  Container(
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        2,
                        (_) => Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 88,
                          ),
                          height: 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: context.colors.text,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      );
}
