import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class ReadBottomBar extends StatelessWidget {
  final double progress;
  final TextEditingController controller;

  const ReadBottomBar({
    required this.progress,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => TextField(
        autocorrect: false,
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.go,
        controller: controller,
        cursorColor: context.colors.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.colors.text,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.colors.text,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.colors.text,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          label: Center(
            child: Text(
              'Hello',
              style: context.textStyles.searchTextField,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
        ),
        style: context.textStyles.searchTextField,
        textAlign: TextAlign.center,
      );
}
