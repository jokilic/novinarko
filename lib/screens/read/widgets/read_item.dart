import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../constants.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../news/controllers/news_read_controller.dart';

class ReadItem extends StatefulWidget {
  final String? initialUrl;
  final HeadlessInAppWebView? headlessWebView;

  const ReadItem({
    this.initialUrl,
    this.headlessWebView,
  });

  @override
  State<ReadItem> createState() => _ReadItemState();
}

class _ReadItemState extends State<ReadItem> {
  InAppWebViewController? webViewController;

  var url = '';
  var progress = 0.0;

  Future<void> loadUrl(String url) async {
    final webUri = WebUri(url);

    await webViewController?.loadUrl(
      urlRequest: URLRequest(url: webUri),
    );
  }

  @override
  Widget build(BuildContext context) => widget.initialUrl != null
      ? InAppWebView(
          headlessWebView: widget.headlessWebView,
          initialUrlRequest: URLRequest(
            url: WebUri(widget.initialUrl!),
          ),
          initialSettings: getIt.get<NewsReadController>().webViewSettings,
        )
      : NovinarkoIconTextWidget(
          icon: NovinarkoIcons.errorNews,
          title: 'readStateErrorTitle'.tr(),
          subtitle: 'readStateErrorSubtitle'.tr(),
        );
}
