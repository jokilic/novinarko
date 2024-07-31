import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/novinarko_rss_feed.dart';
import '../../../models/novinarko_rss_item.dart';
import '../../../services/active_feed_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../util/navigation.dart';
import '../../../util/parsing.dart';
import '../../../widgets/novinarko_divider.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../controllers/news_controller.dart';
import '../controllers/news_read_controller.dart';
import 'news_list_tile.dart';

class NewsResult extends StatelessWidget {
  final ({NovinarkoRssFeed? rssFeed, String? error}) result;
  final List<NovinarkoRssItem> readItems;
  final bool showFavicon;
  final bool showImages;
  final bool inAppBrowser;

  const NewsResult({
    required this.result,
    required this.readItems,
    required this.showFavicon,
    required this.showImages,
    required this.inAppBrowser,
  });

  @override
  Widget build(BuildContext context) {
    /// `rssFeed` is successfully fetched
    if (result.rssFeed != null && result.error == null) {
      final feed = result.rssFeed!;

      return RefreshIndicator(
        onRefresh: () => getIt.get<NewsController>().pullToRefresh(
              getIt.get<ActiveFeedService>().value,
            ),
        color: context.colors.background,
        backgroundColor: context.colors.text,
        edgeOffset: kToolbarHeight + 32 + 80,
        strokeWidth: 3,
        child:

            /// Result items
            (feed.items?.isNotEmpty ?? false)
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: feed.items?.length ?? 0,
                    itemBuilder: (_, index) {
                      final item = feed.items![index];

                      final cleanDescription = parseDescriptionHtml(
                        item.description,
                      );
                      final cleanDate = parseDateTimeago(
                        item.pubDate,
                        context: context,
                      );

                      return NewsListTile(
                        onPressed: inAppBrowser
                            ? () => getIt.get<NewsReadController>().itemPressed(item)
                            : () => openUrlExternalBrowser(
                                  context,
                                  url: item.link ?? item.guid,
                                ),
                        imageUrl: item.imageUrl,
                        title: item.title ?? '',
                        favicon: item.favicon,
                        feedTitle: item.feedTitle,
                        cleanDescription: cleanDescription,
                        cleanDate: cleanDate,
                        showFavicon: showFavicon,
                        showImages: showImages,
                        isItemForReading: readItems.contains(item),
                      );
                    },
                    separatorBuilder: (_, __) => NovinarkoDivider(),
                  )

                /// No results
                : NovinarkoIconTextWidget(
                    icon: NovinarkoIcons.noNews,
                    title: 'newsNoResultsTitle'.tr(),
                    subtitle: 'newsNoResultsSubtitle'.tr(),
                  ),
      );
    }

    /// `rssFeed` has an error
    if (result.rssFeed == null && result.error != null) {
      return NovinarkoIconTextWidget(
        icon: NovinarkoIcons.errorNews,
        title: 'newsStateErrorTitle'.tr(),
        subtitle: result.error,
      );
    }

    /// Some weird error
    return NovinarkoIconTextWidget(
      icon: NovinarkoIcons.errorNews,
      title: 'newsStateErrorTitle'.tr(),
      subtitle: 'newsStateErrorSubtitle'.tr(),
    );
  }
}
