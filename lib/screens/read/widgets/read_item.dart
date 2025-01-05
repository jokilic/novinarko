import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../constants.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../news/controllers/news_read_controller.dart';

class ReadItem extends StatelessWidget {
  final String? initialUrl;
  final HeadlessInAppWebView? headlessWebView;
  final Function(InAppWebViewController controller)? onWebViewCreated;
  final Function(int progress)? onProgressChanged;
  final Function(WebUri? uri)? updateUri;
  final Function(ConsoleMessage consoleMessage)? onConsoleMessage;

  const ReadItem({
    this.initialUrl,
    this.headlessWebView,
    this.onWebViewCreated,
    this.onProgressChanged,
    this.updateUri,
    this.onConsoleMessage,
  });

  @override
  Widget build(BuildContext context) => initialUrl != null
      ? InAppWebView(
          key: ValueKey(initialUrl),
          headlessWebView: headlessWebView,
          initialUrlRequest: URLRequest(
            url: WebUri(initialUrl!),
          ),
          initialSettings: getIt.get<NewsReadController>().webViewSettings,
          onWebViewCreated: (controller) {
            if (onWebViewCreated != null) {
              onWebViewCreated!(controller);
            }
          },
          onLoadStart: (_, url) {
            if (updateUri != null) {
              updateUri!(url);
            }
          },
          onLoadStop: (_, url) {
            if (updateUri != null) {
              updateUri!(url);
            }
          },
          onUpdateVisitedHistory: (_, url, __) {
            if (updateUri != null) {
              updateUri!(url);
            }
          },
          onProgressChanged: (_, progress) {
            if (onProgressChanged != null) {
              onProgressChanged!(progress);
            }
          },
          onConsoleMessage: (controller, consoleMessage) {
            if (onConsoleMessage != null) {
              onConsoleMessage!(consoleMessage);
            }
          },
        )
      : NovinarkoIconTextWidget(
          icon: NovinarkoIcons.errorNews,
          title: 'readStateErrorTitle'.tr(),
          subtitle: 'readStateErrorSubtitle'.tr(),
        );
}
