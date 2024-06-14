import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/feed_search_model.dart';
import '../../../theme/theme.dart';
import '../../../util/navigation.dart';
import '../../../util/parsing.dart';
import '../../../widgets/novinarko_divider.dart';
import '../../../widgets/novinarko_network_image.dart';

class NewsFeedInfoDialog extends StatelessWidget {
  final FeedSearchModel feed;

  const NewsFeedInfoDialog({
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    final feedTitle = getFeedTitle(feed);

    return Dialog(
      backgroundColor: context.colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///
              /// FAVICON
              ///
              if (feed.favicon != null)
                ClipOval(
                  child: NovinarkoNetworkImage(
                    imageUrl: feed.favicon!,
                    height: 80,
                    width: 80,
                    placeholderWidget: Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colors.text,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        feedTitle?.substring(0, 2) ?? '?',
                        style: context.textStyles.twoLettersDialog,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    errorWidget: Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colors.text,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        feedTitle?.substring(0, 2) ?? '?',
                        style: context.textStyles.twoLettersDialog,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  height: 80,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colors.text,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    feedTitle?.substring(0, 2) ?? '?',
                    style: context.textStyles.twoLettersDialog,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const SizedBox(height: 12),

              ///
              /// TITLE & DESCRIPTION
              ///
              if (feedTitle != null) ...[
                Text(
                  feedTitle,
                  style: context.textStyles.newsFeedInfoTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],
              if (feed.title != null) ...[
                Text(
                  feed.title!,
                  style: context.textStyles.newsFeedInfoValue,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
              if (feed.description != null)
                Text(
                  feed.description!,
                  style: context.textStyles.newsFeedInfoValue,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16),
              NovinarkoDivider(),
              const SizedBox(height: 12),

              ///
              /// WEBSITE
              ///
              if (feed.siteUrl != null) ...[
                Text(
                  'newsFeedInfoDialogWebsite'.tr(),
                  style: context.textStyles.newsFeedInfoText,
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () => openUrlExternalBrowser(
                    context,
                    url: feed.siteUrl,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      feed.siteUrl!,
                      style: context.textStyles.newsFeedInfoValue,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                NovinarkoDivider(),
                const SizedBox(height: 12),
              ],

              ///
              /// FEED URL
              ///
              if (feed.url != null) ...[
                Text(
                  'newsFeedInfoDialogFeedUrl'.tr(),
                  style: context.textStyles.newsFeedInfoText,
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () => openUrlExternalBrowser(
                    context,
                    url: feed.url,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      feed.url!,
                      style: context.textStyles.newsFeedInfoValue,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
