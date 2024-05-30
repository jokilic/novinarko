import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class NewsReadButton extends StatelessWidget {
  final Function() onPressed;
  final int readNumber;
  final double loaderValue;

  const NewsReadButton({
    required this.onPressed,
    required this.readNumber,
    required this.loaderValue,
  });

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        onPressed: onPressed,
        label: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'newsReadButton'.tr().toUpperCase(),
            style: context.textStyles.floatingActionButtonTitle,
          ),
        ),
        icon: Stack(
          alignment: Alignment.center,
          children: [
            if (loaderValue > 0.1)
              SizedBox(
                height: 28,
                width: 28,
                child: TweenAnimationBuilder<double>(
                  duration: NovinarkoConstants.animationDuration,
                  curve: Curves.easeIn,
                  tween: Tween<double>(begin: 0, end: loaderValue),
                  builder: (_, value, __) => CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: context.colors.text,
                    value: value,
                  ),
                ),
              ),
            Container(
              height: 28,
              width: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$readNumber',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.floatingActionButtonNumber,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
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
            width: 2,
          ),
        ),
      );
}
