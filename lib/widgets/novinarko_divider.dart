import 'package:flutter/material.dart';

import '../theme/theme.dart';

class NovinarkoDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Divider(
        color: context.colors.text,
        thickness: 1,
        height: 8,
        indent: 16,
        endIndent: 16,
      );
}
