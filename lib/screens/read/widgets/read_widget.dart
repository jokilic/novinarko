import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../../widgets/novinarko_loader.dart';
import 'read_widget_state.dart';

class ReadWidget extends StatefulWidget {
  final String? url;
  final Color backgroundColor;

  const ReadWidget({
    required this.url,
    required this.backgroundColor,
  });

  @override
  State<ReadWidget> createState() => _ReadWidgetState();
}

class _ReadWidgetState extends State<ReadWidget> {
  ReadWidgetState readWidgetState = ReadWidgetStateInitial();
  // TODO: Localize
  String? loaderText = 'Loading article';

  @override
  void initState() {
    super.initState();

    final uri = Uri.tryParse(widget.url ?? '');

    if (uri != null) {
      initializeWebView(uri);
    } else {
      setState(
        () => readWidgetState = ReadWidgetStateError(
          // TODO: Localize
          error: 'Uri is null',
        ),
      );
    }
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
          onPageFinished: (_) => setState(
            () => loaderText = null,
          ),
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
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          ///
          /// LOADER
          ///
          if (loaderText != null)
            NovinarkoLoader(
              text: loaderText,
            ),

          ///
          /// CONTENT
          ///
          switch (readWidgetState) {
            ReadWidgetStateInitial() => const SizedBox.shrink(),
            // TODO: Icon for this, update `verticalPadding`
            ReadWidgetStateError() => NovinarkoIconTextWidget(
                icon: NovinarkoIcons.errorNews,
                // TODO: Localize
                title: 'Error',
                subtitle: (readWidgetState as ReadWidgetStateError).error,
              ),
            ReadWidgetStateSuccess() => WebViewWidget(
                controller: (readWidgetState as ReadWidgetStateSuccess).controller,
              ),
          },
        ],
      );
}
