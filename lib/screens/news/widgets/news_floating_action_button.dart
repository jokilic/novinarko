import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class NewsFloatingActionButton extends StatelessWidget {
  final Function() onPressed;

  const NewsFloatingActionButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        onPressed: onPressed,
        label: Text(
          // TODO: Localize
          'Read'.toUpperCase(),
          style: context.textStyles.floatingActionButtonTitle,
        ),
        icon: Icon(
          Icons.public_rounded,
          color: context.colors.text,
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
