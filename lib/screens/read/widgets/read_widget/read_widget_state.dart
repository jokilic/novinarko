import 'package:webview_flutter/webview_flutter.dart';

sealed class ReadWidgetState {}

final class ReadWidgetStateInitial extends ReadWidgetState {}

final class ReadWidgetStateError extends ReadWidgetState {
  final String error;

  ReadWidgetStateError({
    required this.error,
  });
}

final class ReadWidgetStateSuccess extends ReadWidgetState {
  final WebViewController controller;

  ReadWidgetStateSuccess({
    required this.controller,
  });
}
