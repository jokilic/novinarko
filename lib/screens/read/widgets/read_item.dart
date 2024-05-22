import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../constants.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../news/news_read_controller.dart';

class ReadItem extends StatelessWidget {
  final String? url;
  final HeadlessInAppWebView? headlessWebView;

  const ReadItem({
    this.url,
    this.headlessWebView,
  });

  @override
  Widget build(BuildContext context) => url != null
      ? InAppWebView(
          headlessWebView: headlessWebView,
          initialUrlRequest: URLRequest(
            url: WebUri(url!),
          ),
          initialSettings: getIt.get<NewsReadController>().webViewSettings,
        )
      : NovinarkoIconTextWidget(
          icon: NovinarkoIcons.errorNews,
          title: 'readStateErrorTitle'.tr(),
          subtitle: 'readStateErrorSubtitle'.tr(),
        );
}
