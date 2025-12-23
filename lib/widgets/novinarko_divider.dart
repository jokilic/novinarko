import 'package:flutter/material.dart';

import '../theme/theme.dart';

class NovinarkoDivider extends StatelessWidget {
  final Color? color;

  const NovinarkoDivider({
    this.color,
  });

  @override
  Widget build(BuildContext context) => Divider(
    color: color ?? context.colors.text,
    thickness: 1,
    height: 8,
    indent: 16,
    endIndent: 16,
  );
}
