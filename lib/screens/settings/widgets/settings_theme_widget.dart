import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SettingsThemeWidget extends StatelessWidget {
  final Function() onPressed;
  final Color color;

  const SettingsThemeWidget({
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          highlightColor: context.colors.primary.withOpacity(0.6),
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          backgroundColor: color,
          side: BorderSide(
            color: context.colors.text,
          ),
        ),
        icon: const SizedBox.shrink(),
      );
}
