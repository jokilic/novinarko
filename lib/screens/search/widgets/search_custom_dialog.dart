import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SearchCustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: context.colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: context.colors.text,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.red,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      );
}
