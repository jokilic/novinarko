import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SettingsListTile extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Widget rightWidget;
  final String? description;

  const SettingsListTile({
    required this.onPressed,
    required this.title,
    required this.rightWidget,
    this.description,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        highlightColor: context.colors.primary.withOpacity(0.6),
        splashColor: context.colors.primary.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ///
              /// Title & description
              ///
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: context.textStyles.newsTitle,
                    ),

                    const SizedBox(height: 8),

                    /// Description
                    if (description != null)
                      Text(
                        description!,
                        textAlign: TextAlign.left,
                        style: context.textStyles.newsDescription,
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              ///
              /// Right widget
              ///
              rightWidget,
            ],
          ),
        ),
      );
}
