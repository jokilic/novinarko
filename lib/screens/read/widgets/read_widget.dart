import 'dart:io';

import 'package:dough/dough.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../constants.dart';
import '../../../util/snackbars.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import 'read_refresh_button.dart';
import 'read_widget_state.dart';

class ReadWidget extends StatefulWidget {
  final String? url;

  const ReadWidget({
    this.url,
  });

  @override
  State<ReadWidget> createState() => _ReadWidgetState();
}

class _ReadWidgetState extends State<ReadWidget> {
  ReadWidgetState readWidgetState = ReadWidgetStateInitial();
  // TODO: Localize
  String? loaderText = 'Loading article';

  InAppWebViewController? webViewController;

  final settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
  );

  @override
  void initState() {
    super.initState();

    final uri = Uri.tryParse(widget.url ?? '');

    if (uri != null) {
      setState(
        () => readWidgetState = ReadWidgetStateSuccess(),
      );
    } else {
      setState(
        () => readWidgetState = ReadWidgetStateError(
          // TODO: Localize
          error: 'Uri is null',
        ),
      );
    }
  }

  Future<void> refresh() async {
    if (Platform.isAndroid) {
      await webViewController?.reload();
    } else if (Platform.isIOS) {
      await webViewController?.loadUrl(
        urlRequest: URLRequest(
          url: await webViewController?.getUrl(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => switch (readWidgetState) {
        ReadWidgetStateInitial() => const SizedBox.shrink(),
        // TODO: Icon for this, update `verticalPadding`
        ReadWidgetStateError() => NovinarkoIconTextWidget(
            icon: NovinarkoIcons.errorNews,
            // TODO: Localize
            title: 'Error',
            subtitle: (readWidgetState as ReadWidgetStateError).error,
          ),
        ReadWidgetStateSuccess() => Stack(
            children: [
              ///
              /// CONTENT
              ///
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(widget.url!),
                ),
                initialSettings: settings,
                onWebViewCreated: (controller) => webViewController = controller,
                onReceivedError: (_, __, error) => showWebSnackbar(
                  context,
                  text: error.description,
                ),
              ),

              ///
              /// REFRESH
              ///
              Positioned(
                right: 12,
                top: 16,
                child: PressableDough(
                  child: ReadRefreshButton(
                    onPressed: refresh,
                    tag: widget.url ?? '',
                  ),
                ),
              ),
            ],
          ),
      };
}
