import 'dart:io';

import 'package:dough/dough.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'read_refresh_button.dart';

class ReadWidget extends StatefulWidget {
  final String? url;

  const ReadWidget({
    this.url,
  });

  @override
  State<ReadWidget> createState() => _ReadWidgetState();
}

class _ReadWidgetState extends State<ReadWidget> {
  InAppWebViewController? webViewController;
  String? webError;

  final settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
  );

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
  Widget build(BuildContext context) => Stack(
        children: [
          ///
          /// CONTENT
          ///
          if (widget.url != null)
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.url!),
              ),
              initialSettings: settings,
              onWebViewCreated: (controller) => webViewController = controller,
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
      );
}
