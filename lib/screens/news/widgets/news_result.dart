import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../constants.dart';
import '../../../models/novinarko_rss_feed.dart';
import '../../../services/active_feed_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../util/parsing.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../news_controller.dart';
import 'news_list_tile.dart';

class NewsResult extends StatelessWidget {
  final ({NovinarkoRssFeed? rssFeed, String? error}) result;
  final bool showTrailingIcon;

  const NewsResult({
    required this.result,
    required this.showTrailingIcon,
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),

            /// Result title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                feed.siteName ?? feed.title ?? feed.description ?? '',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.newsFeedTitle,
              ),
            ),

            const SizedBox(height: 32),

            /// Divider
            Divider(
              color: context.colors.text,
              thickness: 1,
              height: 8,
              indent: 16,
              endIndent: 16,
            ),

            /// Result items
            if (feed.items?.isNotEmpty ?? false)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: feed.items?.length ?? 0,
                itemBuilder: (_, index) {
                  final item = feed.items![index];

                  final cleanDescription = parseDescriptionHtml(item.description);
                  final cleanDate = parseDateTimeago(item.pubDate);

                  return Animate(
                    key: ValueKey(item),
                    delay: (const Duration(milliseconds: 150).inMilliseconds * index).milliseconds,
                    effects: const [
                      FadeEffect(
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 450),
                      ),
                    ],
                    child: NewsListTile(
                      onPressed: () {
                        final url = item.link ?? item.guid;

                        if (url != null) {
                          FlutterWebBrowser.openWebPage(
                            url: url,
                            customTabsOptions: CustomTabsOptions(
                              defaultColorSchemeParams: CustomTabsColorSchemeParams(
                                toolbarColor: context.colors.background,
                                navigationBarColor: context.colors.background,
                                secondaryToolbarColor: context.colors.background,
                                navigationBarDividerColor: context.colors.background,
                              ),
                              showTitle: true,
                              urlBarHidingEnabled: true,
                            ),
                            safariVCOptions: SafariViewControllerOptions(
                              barCollapsingEnabled: true,
                              preferredBarTintColor: context.colors.background,
                              preferredControlTintColor: context.colors.text,
                              dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
                              modalPresentationCapturesStatusBarAppearance: true,
                            ),
                          );
                        }
                      },
                      title: item.title ?? '',
                      favicon: item.favicon,
                      feedTitle: item.feedTitle,
                      cleanDescription: cleanDescription,
                      cleanDate: cleanDate,
                      showTrailingIcon: showTrailingIcon,
                    ),
                  );
                },
                separatorBuilder: (_, __) => Divider(
                  color: context.colors.text,
                  thickness: 1,
                  height: 8,
                  indent: 16,
                  endIndent: 16,
                ),
              )

            /// No results
            else
              NovinarkoIconTextWidget(
                icon: NovinarkoIcons.noNews,
                title: 'newsNoResultsTitle'.tr(),
                subtitle: 'newsNoResultsSubtitle'.tr(),
              ),

            /// End of items
            const NovinarkoIconTextWidget(
              icon: NovinarkoIcons.yesNews,
              title: 'Finished reading',
              subtitle: 'Open another or refresh current feed',
              verticalPadding: 16,
            ),
            const SizedBox(height: 24),
          ],
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
