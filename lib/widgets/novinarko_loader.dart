import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/theme.dart';

class NovinarkoLoader extends StatelessWidget {
  final String? text;

  const NovinarkoLoader({
    this.text,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.fourRotatingDots(
              color: context.colors.text,
              size: 44,
            ),
            if (text != null) ...[
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: context.textStyles.loading,
                ),
              ),
            ],
          ],
        ),
      );
}
