import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../constants.dart';
import '../../../../widgets/novinarko_icon_text_widget.dart';
import 'read_widget_state.dart';

// TODO: Localize
class ReadWidget extends StatefulWidget {
  final String? url;
  final Color backgroundColor;
  final int index;

  const ReadWidget({
    required this.url,
    required this.backgroundColor,
    required this.index,
  });

  @override
  State<ReadWidget> createState() => _ReadWidgetState();
}

class _ReadWidgetState extends State<ReadWidget> {
  ReadWidgetState readWidgetState = ReadWidgetStateInitial();

  @override
  void initState() {
    super.initState();

    log('Hey -> ${widget.index}');

    final uri = Uri.tryParse(widget.url ?? '');

    if (uri != null) {
      initializeWebView(uri);
    } else {
      setState(
        () => readWidgetState = ReadWidgetStateError(error: 'Uri is null'),
      );
    }
  }

  @override
  void dispose() {
    log('Bye -> ${widget.index}');
    super.dispose();
  }

  Future<void> initializeWebView(Uri uri) async {
    try {
      final controller = WebViewController();

      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      await controller.setBackgroundColor(widget.backgroundColor);
      await controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (_) {},
          onPageStarted: (_) {},
          onPageFinished: (_) {},
          onWebResourceError: (error) => setState(
            () => readWidgetState = ReadWidgetStateError(
              error: error.description,
            ),
          ),
          onNavigationRequest: (_) => NavigationDecision.navigate,
        ),
      );
      await controller.loadRequest(uri);

      setState(
        () => readWidgetState = ReadWidgetStateSuccess(
          controller: controller,
        ),
      );
    } catch (e) {
      setState(
        () => readWidgetState = ReadWidgetStateError(error: '$e'),
      );
    }
  }

  @override
  Widget build(BuildContext context) => switch (readWidgetState) {
        ReadWidgetStateInitial() => const SizedBox.shrink(),
        ReadWidgetStateError() => NovinarkoIconTextWidget(
            icon: NovinarkoIcons.errorNews,
            title: 'Error',
            subtitle: (readWidgetState as ReadWidgetStateError).error,
          ),
        ReadWidgetStateSuccess() => WebViewWidget(
            controller: (readWidgetState as ReadWidgetStateSuccess).controller,
          ),
      };
}
