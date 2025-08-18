import 'package:sentry_flutter/sentry_flutter.dart';

void triggerSentryBreadcrumb({required String message}) {
  /// Add a breadcrumb
  Sentry.addBreadcrumb(
    Breadcrumb(
      timestamp: DateTime.now(),
      message: message,
      level: SentryLevel.info,
    ),
  );

  /// Emit a lightweight event
  Sentry.captureMessage(message);
}
