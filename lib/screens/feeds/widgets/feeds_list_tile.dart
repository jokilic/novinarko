import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class FeedsListTile extends StatelessWidget {
  final Function() onPressed;
  final Function() onPressedDelete;
  final String title;
  final String? subtitle;
  final String? url;
  final bool showActiveIndicator;
  final bool isDraggable;
  @override
  final Key key;

  const FeedsListTile({
    required this.onPressed,
    required this.onPressedDelete,
    required this.title,
    required this.showActiveIndicator,
    required this.key,
    this.isDraggable = true,
    this.subtitle,
    this.url,
  });

  @override
  Widget build(BuildContext context) => SwipeActionCell(
        backgroundColor: Colors.transparent,
        isDraggable: isDraggable,
        key: key,
        openAnimationCurve: Curves.easeIn,
        closeAnimationCurve: Curves.easeIn,
        trailingActions: [
          SwipeAction(
            onTap: (_) => onPressedDelete(),
            color: Colors.transparent,
            backgroundRadius: 100,
            content: InkWell(
              onTap: onPressedDelete,
              highlightColor: context.colors.primary.withValues(alpha: 0.6),
              splashColor: context.colors.primary.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  NovinarkoIcons.delete,
                  fit: BoxFit.cover,
                  color: context.colors.background,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ),
        ],
        child: InkWell(
          onTap: onPressed,
          highlightColor: context.colors.primary.withValues(alpha: 0.6),
          splashColor: context.colors.primary.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// Title & active indicator
                ///
                Row(
                  children: [
                    /// Title
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: context.textStyles.feedsTitle,
                      ),
                    ),

                    /// Active indicator
                    const SizedBox(width: 20),
                    AnimatedSwitcher(
                      duration: NovinarkoConstants.animationDuration,
                      child: showActiveIndicator
                          ? Container(
                              height: 14,
                              width: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colors.primary,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),

                ///
                /// Subtitle
                ///
                if (subtitle != null)
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: context.textStyles.feedsSubtitle,
                  ),

                ///
                /// URL
                ///
                if (url != null)
                  Text(
                    url!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: context.textStyles.feedsUrl,
                  ),
              ],
            ),
          ),
        ),
      );
}
