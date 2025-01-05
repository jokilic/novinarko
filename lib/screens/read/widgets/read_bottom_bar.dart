import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class ReadBottomBar extends StatelessWidget {
  final double progress;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function() onAddressBarPressed;
  final Function(String value) onAddressBarSubmitted;
  final Function() onBackPressed;
  final Function() onForwardPressed;
  final Function() onSharePressed;
  final Function() onRefreshPressed;

  const ReadBottomBar({
    required this.progress,
    required this.controller,
    required this.focusNode,
    required this.onAddressBarPressed,
    required this.onAddressBarSubmitted,
    required this.onBackPressed,
    required this.onForwardPressed,
    required this.onSharePressed,
    required this.onRefreshPressed,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.colors.text,
              width: 2.5,
            ),
          ),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            /// BACK
            ///
            ReadBottomBarCircularButton(
              onPressed: onBackPressed,
              icon: NovinarkoIcons.browserBack,
            ),

            ///
            /// FORWARD
            ///
            ReadBottomBarCircularButton(
              onPressed: onForwardPressed,
              icon: NovinarkoIcons.browserBack,
              rotateIcon: true,
            ),

            ///
            /// ADDRESS BAR
            ///
            Expanded(
              child: TextField(
                onTap: onAddressBarPressed,
                onSubmitted: onAddressBarSubmitted,
                autocorrect: false,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.go,
                controller: controller,
                focusNode: focusNode,
                cursorColor: context.colors.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                ),
                style: context.textStyles.readAddressBar,
                textAlign: TextAlign.center,
              ),
            ),

            ///
            /// SHARE
            ///
            ReadBottomBarCircularButton(
              onPressed: onSharePressed,
              icon: NovinarkoIcons.share,
              size: 20,
            ),

            ///
            /// REFRESH & LOADER
            ///
            Stack(
              alignment: Alignment.center,
              children: [
                ///
                /// LOADER
                ///
                AnimatedOpacity(
                  opacity: progress > 0.1 && progress < 0.95 ? 1 : 0,
                  duration: NovinarkoConstants.animationDuration,
                  curve: Curves.easeIn,
                  child: SizedBox(
                    height: 34,
                    width: 34,
                    child: TweenAnimationBuilder<double>(
                      duration: NovinarkoConstants.animationDuration,
                      curve: Curves.easeIn,
                      tween: Tween<double>(begin: 0, end: progress),
                      builder: (_, value, __) => CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: context.colors.text,
                        value: value,
                      ),
                    ),
                  ),
                ),

                ///
                /// REFRESH
                ///
                ReadBottomBarCircularButton(
                  onPressed: onRefreshPressed,
                  icon: NovinarkoIcons.refresh,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      );
}

class ReadBottomBarCircularButton extends StatelessWidget {
  final Function() onPressed;
  final String icon;
  final bool rotateIcon;
  final double size;

  const ReadBottomBarCircularButton({
    required this.onPressed,
    required this.icon,
    this.rotateIcon = false,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          highlightColor: context.colors.primary.withValues(alpha: 0.6),
          shape: const CircleBorder(),
        ),
        icon: Center(
          child: Transform.rotate(
            angle: rotateIcon ? pi : 0,
            child: Image.asset(
              icon,
              fit: BoxFit.cover,
              color: context.colors.text,
              height: size,
              width: size,
            ),
          ),
        ),
      );
}
