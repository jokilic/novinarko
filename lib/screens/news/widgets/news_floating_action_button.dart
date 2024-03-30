import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class NewsFloatingActionButton extends StatelessWidget {
  final Function() onPressed;
  final int readNumber;

  const NewsFloatingActionButton({
    required this.onPressed,
    required this.readNumber,
  });

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        onPressed: onPressed,
        label: Text(
          // TODO: Localize
          'Read'.toUpperCase(),
          style: context.textStyles.floatingActionButtonTitle,
        ),
        icon: Container(
          height: 28,
          width: 28,
          margin: const EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colors.text,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              '$readNumber',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.floatingActionButtonNumber,
            ),
          ),
        ),
        backgroundColor: context.colors.background,
        focusColor: context.colors.primary.withOpacity(0.6),
        hoverColor: context.colors.primary.withOpacity(0.6),
        splashColor: context.colors.primary.withOpacity(0.6),
        enableFeedback: true,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.colors.text,
            width: 1.5,
          ),
        ),
      );
}
