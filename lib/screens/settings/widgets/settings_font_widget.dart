import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SettingsFontWidget extends StatelessWidget {
  final Function() onPressed;
  final String fontFamily;

  const SettingsFontWidget({
    required this.onPressed,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    style: IconButton.styleFrom(
      highlightColor: context.colors.primary.withValues(alpha: 0.6),
      fixedSize: const Size(52, 52),
      shape: const CircleBorder(),
      side: BorderSide(
        color: context.colors.text,
        width: 2,
      ),
    ),
    icon: Text(
      // TODO: Localize
      'Aa',
      style: context.textStyles.settingsFont.copyWith(
        fontFamily: fontFamily,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
