import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/novinarko_rss_item.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../../widgets/novinarko_loader.dart';
import '../news_state.dart';
import 'news_loading.dart';
import 'news_result.dart';

class NewsContent extends StatelessWidget {
  final NewsState newsState;
  final List<NovinarkoRssItem> readItems;
  final bool showImages;
  final bool inAppBrowser;
  final bool useShimmerLoader;

  const NewsContent({
    required this.newsState,
    required this.readItems,
    required this.showImages,
    required this.inAppBrowser,
    required this.useShimmerLoader,
  });

  @override
  Widget build(BuildContext context) => switch (newsState) {
        NewsStateInitial() => const SizedBox.shrink(),
        NewsStateLoading() => useShimmerLoader
            ? NewsLoading(
                showImages: showImages,
              )
            : NovinarkoLoader(
                text: (newsState as NewsStateLoading).loadingStatus,
              ),
        NewsStateEmpty() => NovinarkoIconTextWidget(
            arrowAlignment: Alignment.centerRight,
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
            readItems: readItems,
            showFavicon: false,
            showImages: showImages,
            inAppBrowser: inAppBrowser,
          ),
        NewsStateAllSuccess() => NewsResult(
            result: (newsState as NewsStateAllSuccess).result,
            readItems: readItems,
            showFavicon: true,
            showImages: showImages,
            inAppBrowser: inAppBrowser,
          ),
      };
}
