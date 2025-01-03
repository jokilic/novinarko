import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class ReadPreviousButton extends StatelessWidget {
  final Function() onPressed;

  const ReadPreviousButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => FloatingActionButton.small(
        heroTag: 'prev',
        onPressed: onPressed,
        backgroundColor: context.colors.background,
        focusColor: context.colors.primary.withValues(alpha: 0.6),
        hoverColor: context.colors.primary.withValues(alpha: 0.6),
        splashColor: context.colors.primary.withValues(alpha: 0.6),
        enableFeedback: true,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.colors.text,
            width: 2,
          ),
        ),
        child: Image.asset(
          NovinarkoIcons.back,
          fit: BoxFit.cover,
          color: context.colors.text,
          height: 16,
          width: 16,
        ),
      );
}
