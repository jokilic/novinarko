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

  const NovinarkoIconTextWidget({
    required this.icon,
    this.title,
    this.subtitle,
    this.verticalPadding = 56,
    this.arrowAlignment,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: verticalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 104),

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
                        duration: Duration(milliseconds: 750),
                      ),
                    ],
                    child: Transform.rotate(
                      angle: 0.5 * pi,
                      child: Image.asset(
                        NovinarkoIcons.back,
                        fit: BoxFit.cover,
                        color: context.colors.text,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(height: 40),

              const SizedBox(height: 120),

              Image.asset(
                icon,
                fit: BoxFit.cover,
                color: context.colors.text,
                height: 64,
                width: 64,
              ),

              const SizedBox(height: 36),

              /// Search title
              if (title != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    title!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.iconTextTitle,
                  ),
                ),

              const SizedBox(height: 8),

              /// Search subtitle
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: context.textStyles.iconTextSubtitle,
                  ),
                ),
            ],
          ),
        ),
      );
}
