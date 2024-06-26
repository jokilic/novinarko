import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../theme/theme.dart';
import 'circular_transition_clipper.dart';

void openUrlExternalBrowser(
  BuildContext context, {
  required String? url,
}) {
  if (url != null) {
    /// Use `url_launcher` if on web and not Android / iOS
    if (kIsWeb || (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS)) {
      final uri = Uri.tryParse(url);

      if (uri != null) {
        launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }

      return;
    }

    /// Use external browser
    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        defaultColorSchemeParams: CustomTabsColorSchemeParams(
          toolbarColor: context.colors.background,
          navigationBarColor: context.colors.background,
          secondaryToolbarColor: context.colors.background,
          navigationBarDividerColor: context.colors.background,
        ),
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: context.colors.background,
        preferredControlTintColor: context.colors.text,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }
}

Future<T?> pushScreen<T>(
  Widget screen, {
  required BuildContext context,
  bool isCircularTransition = false,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) =>
    Navigator.of(context).push<T>(
      isCircularTransition
          ? circularPageTransition(
              screen,
              transitionDuration: transitionDuration,
              reverseTransitionDuration: reverseTransitionDuration,
            )
          : fadePageTransition(
              screen,
              transitionDuration: transitionDuration,
              reverseTransitionDuration: reverseTransitionDuration,
            ),
    );

Route<T> fadePageTransition<T>(
  Widget screen, {
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) =>
    PageRouteBuilder<T>(
      transitionDuration: transitionDuration ?? NovinarkoConstants.animationDuration,
      reverseTransitionDuration: reverseTransitionDuration ?? NovinarkoConstants.animationDuration,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

Route<T> circularPageTransition<T>(
  Widget screen, {
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) =>
    PageRouteBuilder<T>(
      transitionDuration: transitionDuration ?? NovinarkoConstants.animationDuration,
      reverseTransitionDuration: reverseTransitionDuration ?? NovinarkoConstants.animationDuration,
      opaque: false,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (context, animation, _, child) {
        final screenSize = MediaQuery.sizeOf(context);

        final center = Offset(
          screenSize.width / 2,
          kToolbarHeight + 40,
        );

        const beginRadius = 0.0;
        final endRadius = screenSize.height * 1.2;

        final tween = Tween<double>(begin: beginRadius, end: endRadius);
        final radiusTweenAnimation = animation.drive(tween);

        return ClipPath(
          clipper: CircularTransitionClipper(
            radius: radiusTweenAnimation.value,
            center: center,
          ),
          child: child,
        );
      },
    );
