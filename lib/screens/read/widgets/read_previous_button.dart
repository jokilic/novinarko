import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class ReadPreviousButton extends StatelessWidget {
  final Function() onPressed;

  const ReadPreviousButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'prev',
        onPressed: onPressed,
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
        child: Image.asset(
          NovinarkoIcons.back,
          fit: BoxFit.cover,
          color: context.colors.text,
          height: 20,
          width: 20,
        ),
      );
}