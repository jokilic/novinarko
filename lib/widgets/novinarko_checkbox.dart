import 'package:flutter/material.dart';

import '../constants.dart';
import '../theme/theme.dart';

class NovinarkoCheckbox extends StatelessWidget {
  final bool value;

  const NovinarkoCheckbox({
    required this.value,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.colors.text,
            width: 1.5,
          ),
        ),
        child: AnimatedOpacity(
          opacity: value ? 1 : 0,
          duration: NovinarkoConstants.animationDuration,
          curve: Curves.easeIn,
          child: Image.asset(
            NovinarkoIcons.check,
            color: context.colors.text,
          ),
        ),
      );
}
