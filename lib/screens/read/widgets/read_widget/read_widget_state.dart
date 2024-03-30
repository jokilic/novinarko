import 'package:webview_flutter/webview_flutter.dart';

sealed class ReadState {}

class ReadStateInitial extends ReadState {}

class ReadStateLoading extends ReadState {
  final int progress;

  ReadStateLoading({
    required this.progress,
  });
}

class ReadStateError extends ReadState {
  final String error;

  ReadStateError({
    required this.error,
  });
}

class ReadStateSuccess extends ReadState {
  final WebViewController controller;

  ReadStateSuccess({
    required this.controller,
  });
}
