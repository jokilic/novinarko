import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../../widgets/novinarko_loader.dart';
import '../news_state.dart';
import 'news_result.dart';

class NewsContent extends StatelessWidget {
  final NewsState newsState;

  const NewsContent({
    required this.newsState,
  });

  @override
  Widget build(BuildContext context) => switch (newsState) {
        NewsStateInitial() => const SizedBox.shrink(),
        NewsStateLoading() => NovinarkoLoader(
            text: (newsState as NewsStateLoading).loadingStatus,
          ),
        NewsStateEmpty() => NovinarkoIconTextWidget(
            icon: NovinarkoIcons.noNews,
            title: 'newsStateEmptyTitle'.tr(),
            subtitle: 'newsStateEmptySubtitle'.tr(),
          ),
        NewsStateError() => NovinarkoIconTextWidget(
            icon: NovinarkoIcons.errorNews,
            title: 'newsStateErrorTitle'.tr(),
            subtitle: (newsState as NewsStateError).error,
          ),
        NewsStateSingleSuccess() => NewsResult(
            result: (newsState as NewsStateSingleSuccess).result,
            showTrailingIcon: false,
          ),
        NewsStateAllSuccess() => NewsResult(
            result: (newsState as NewsStateAllSuccess).result,
            showTrailingIcon: true,
          ),
      };
}
