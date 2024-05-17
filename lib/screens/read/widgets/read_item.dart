import 'dart:io';

import 'package:dough/dough.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../constants.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import 'read_refresh_button.dart';

class ReadItem extends StatefulWidget {
  final List<ContentBlocker> contentBlockers;
  final String? url;

  const ReadItem({
    required this.contentBlockers,
    this.url,
  });

  @override
  State<ReadItem> createState() => _ReadItemState();
}

class _ReadItemState extends State<ReadItem> {
  InAppWebViewController? webViewController;
  late final InAppWebViewSettings settings;

  @override
  void initState() {
    super.initState();

    settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true,
      contentBlockers: widget.contentBlockers,
    );
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
            )
          else
            const NovinarkoIconTextWidget(
              icon: NovinarkoIcons.errorNews,
              // TODO: Localize
              title: 'No URL',
              subtitle: 'URL is not passed',
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
