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
  final Function(
    InAppWebViewController controller,
    int progress,
  )? onProgressChanged;

  const ReadItem({
    this.initialUrl,
    this.headlessWebView,
    this.onWebViewCreated,
    this.onProgressChanged,
  });

  @override
  Widget build(BuildContext context) => initialUrl != null
      ? InAppWebView(
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
          onProgressChanged: (controller, progress) {
            if (onProgressChanged != null) {
              onProgressChanged!(controller, progress);
            }
          },
        )
      : NovinarkoIconTextWidget(
          icon: NovinarkoIcons.errorNews,
          title: 'readStateErrorTitle'.tr(),
          subtitle: 'readStateErrorSubtitle'.tr(),
        );
}
