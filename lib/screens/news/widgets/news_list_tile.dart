import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/novinarko_network_image.dart';

class NewsListTile extends StatelessWidget {
  final Function() onPressed;
  final String? imageUrl;
  final String title;
  final String? favicon;
  final String? feedTitle;
  final String? cleanDescription;
  final String? cleanDate;
  final bool showFavicon;
  final bool showImages;
  final bool isItemForReading;

  const NewsListTile({
    required this.onPressed,
    required this.imageUrl,
    required this.title,
    required this.favicon,
    required this.feedTitle,
    required this.cleanDescription,
    required this.cleanDate,
    required this.showFavicon,
    required this.showImages,
    required this.isItemForReading,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: context.colors.text.withValues(alpha: isItemForReading ? 0.2 : 0),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          highlightColor: context.colors.primary.withValues(alpha: 0.6),
          splashColor: context.colors.primary.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// Image
                ///
                if (imageUrl != null && showImages) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: NovinarkoNetworkImage(
                      imageUrl: imageUrl!,
                      height: 120,
                      width: double.infinity,
                      placeholderWidget: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.colors.text,
                            width: 2,
                          ),
                        ),
                      ),
                      errorWidget: Container(
                        alignment: Alignment.center,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.colors.text,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          NovinarkoIcons.errorNews,
                          fit: BoxFit.cover,
                          color: context.colors.text,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                ///
                /// Title, date & time
                ///
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: context.textStyles.newsTitle,
                      ),
                    ),

                    const SizedBox(width: 24),

                    /// Date & time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 8),

                        /// Date
                        if (cleanDate != null)
                          Text(
                            cleanDate!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: context.textStyles.newsDateTime,
                          ),

                        /// Favicon
                        if (showFavicon) ...[
                          const SizedBox(height: 8),
                          IconButton(
                            onPressed: onPressed,
                            style: IconButton.styleFrom(
                              padding: const EdgeInsets.all(4),
                              highlightColor: context.colors.primary.withValues(alpha: 0.6),
                              fixedSize: const Size(40, 40),
                              shape: const CircleBorder(),
                              side: BorderSide(
                                color: context.colors.text,
                                width: 2,
                              ),
                            ),
                            icon: Center(
                              child: favicon != null
                                  ? ClipOval(
                                      child: NovinarkoNetworkImage(
                                        imageUrl: favicon!,
                                        placeholderWidget: Text(
                                          feedTitle?.substring(0, 2) ?? '?',
                                          style: context.textStyles.twoLettersAppBar,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        errorWidget: Text(
                                          feedTitle?.substring(0, 2) ?? '?',
                                          style: context.textStyles.twoLettersAppBar,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      feedTitle?.substring(0, 2) ?? '?',
                                      style: context.textStyles.twoLettersAppBar,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                ///
                /// Description
                ///
                if (cleanDescription != null)
                  Text(
                    cleanDescription!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: context.textStyles.newsDescription,
                  ),
              ],
            ),
          ),
        ),
      );
}
