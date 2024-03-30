import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../constants.dart';
import '../../../../widgets/novinarko_icon_text_widget.dart';
import '../../../../widgets/novinarko_loader.dart';
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
  final readState = ValueNotifier<ReadState>(ReadStateInitial());

  @override
  void initState() {
    super.initState();

    log('Hello -> ${widget.index}');

    final uri = Uri.tryParse(widget.url ?? '');

    if (uri != null) {
      initializeWebView(uri);
    } else {
      readState.value = ReadStateError(error: 'Uri is null');
    }
  }

  Future<void> initializeWebView(Uri uri) async {
    try {
      final controller = WebViewController();

      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      await controller.setBackgroundColor(widget.backgroundColor);
      await controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) => readState.value = ReadStateLoading(
            progress: progress,
          ),
          onPageStarted: (_) => readState.value = ReadStateLoading(progress: 0),
          onPageFinished: (_) => readState.value = ReadStateSuccess(
            controller: controller,
          ),
          onWebResourceError: (error) => readState.value = ReadStateError(
            error: error.description,
          ),
          onNavigationRequest: (_) => NavigationDecision.navigate,
        ),
      );
      await controller.loadRequest(uri);
    } catch (e) {
      readState.value = ReadStateError(error: '$e');
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: readState,
        builder: (_, state, __) => switch (state) {
          ReadStateInitial() => const NovinarkoLoader(),
          ReadStateLoading() => Text(
              'Loading -> ${state.progress}%',
            ),
          ReadStateError() => NovinarkoIconTextWidget(
              icon: NovinarkoIcons.errorNews,
              title: 'Error',
              subtitle: state.error,
            ),
          ReadStateSuccess() => WebViewWidget(
              controller: state.controller,
            ),
        },
      );

  @override
  void dispose() {
    readState.dispose();

    log('Byee -> ${widget.index}');

    super.dispose();
  }
}
