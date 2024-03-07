import 'package:flutter/material.dart';

import '../theme/theme.dart';

class NovinarkoIconTextWidget extends StatelessWidget {
  final String icon;
  final String? title;
  final String? subtitle;
  final double verticalPadding;

  const NovinarkoIconTextWidget({
    required this.icon,
    this.title,
    this.subtitle,
    this.verticalPadding = 56,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 56,
              vertical: verticalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

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
                  Text(
                    title!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.iconTextTitle,
                  ),

                const SizedBox(height: 8),

                /// Search subtitle
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: context.textStyles.iconTextSubtitle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
