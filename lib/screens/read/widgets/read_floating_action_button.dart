import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class ReadFloatingActionButton extends StatelessWidget {
  final Function() onPressed;

  const ReadFloatingActionButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        onPressed: onPressed,
        label: Text(
          // TODO: Localize
          'Back'.toUpperCase(),
          style: context.textStyles.floatingActionButtonTitle,
        ),
        icon: Image.asset(
          NovinarkoIcons.back,
          fit: BoxFit.cover,
          color: context.colors.text,
          height: 20,
          width: 20,
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
