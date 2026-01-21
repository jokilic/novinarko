import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants.dart';
import '../theme/theme.dart';

class NovinarkoIconTextWidget extends StatelessWidget {
  final String icon;
  final String? title;
  final String? subtitle;
  final double verticalPadding;
  final AlignmentGeometry? arrowAlignment;
  final String fontFamily;
  final bool isDark;
  final double? customTopSpacing;

  const NovinarkoIconTextWidget({
    required this.icon,
    required this.fontFamily,
    this.title,
    this.subtitle,
    this.verticalPadding = 56,
    this.arrowAlignment,
    this.isDark = false,
    this.customTopSpacing,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: verticalPadding,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: customTopSpacing ?? 104),
            if (arrowAlignment != null)
              Align(
                alignment: arrowAlignment!,
                child: Animate(
                  onComplete: (controller) => controller.loop(reverse: true),
                  effects: const [
                    MoveEffect(
                      begin: Offset(0, -4),
                      end: Offset(0, -8),
                      curve: Curves.easeIn,
                      duration: NovinarkoConstants.animationDuration,
                    ),
                  ],
                  child: Transform.rotate(
                    angle: 0.5 * pi,
                    child: Image.asset(
                      NovinarkoIcons.back,
                      fit: BoxFit.cover,
                      color: isDark ? context.colors.background : context.colors.text,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              )
            else
              SizedBox(height: customTopSpacing == null ? 40 : 0),

            if (customTopSpacing == null) const SizedBox(height: 120),

            Image.asset(
              icon,
              fit: BoxFit.cover,
              color: isDark ? context.colors.background : context.colors.text,
              height: 80,
              width: 80,
            ),

            const SizedBox(height: 36),

            /// Title
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  title!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.iconTextTitle.copyWith(
                    fontFamily: fontFamily,
                    color: isDark ? context.colors.background : context.colors.text,
                  ),
                ),
              ),

            const SizedBox(height: 8),

            /// Subtitle
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: context.textStyles.iconTextSubtitle.copyWith(
                    color: isDark ? context.colors.background : context.colors.text,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
