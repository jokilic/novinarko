import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../constants.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../read_controller.dart';

class ReadItem extends StatelessWidget {
  final String? url;

  const ReadItem({
    this.url,
  });

  @override
  Widget build(BuildContext context) => url != null
      ? InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(url!),
          ),
          initialSettings: getIt.get<ReadController>().webViewSettings,
        )
      : NovinarkoIconTextWidget(
          icon: NovinarkoIcons.errorNews,
          title: 'readStateErrorTitle'.tr(),
          subtitle: 'readStateErrorSubtitle'.tr(),
        );
}
