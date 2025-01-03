import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/novinarko_network_image.dart';

class SearchListTile extends StatelessWidget {
  final Function() onPressed;
  final String? title;
  final String? siteName;
  final String? description;
  final String? favicon;
  final String? url;
  final bool usingFeed;

  const SearchListTile({
    required this.onPressed,
    required this.title,
    required this.siteName,
    required this.description,
    required this.favicon,
    required this.url,
    required this.usingFeed,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: context.colors.text.withValues(alpha: usingFeed ? 0.2 : 0),
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
                /// Title & favicon
                ///
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Expanded(
                      child: Text(
                        title ?? siteName ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: context.textStyles.searchTitle,
                      ),
                    ),

                    const SizedBox(width: 24),

                    /// Favicon
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
                                    title?.substring(0, 2) ?? siteName?.substring(0, 2) ?? '?',
                                    style: context.textStyles.twoLettersAppBar,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  errorWidget: Text(
                                    title?.substring(0, 2) ?? siteName?.substring(0, 2) ?? '?',
                                    style: context.textStyles.twoLettersAppBar,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            : Text(
                                title?.substring(0, 2) ?? siteName?.substring(0, 2) ?? '?',
                                style: context.textStyles.twoLettersAppBar,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                    ),
                  ],
                ),

                ///
                /// Description, URL & check
                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///
                    /// Description & URL
                    ///
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Description
                          if (description != null)
                            Text(
                              description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textStyles.searchDescription,
                            ),

                          const SizedBox(height: 4),

                          /// URL
                          if (url != null)
                            Text(
                              url!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: context.textStyles.searchUrl,
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 24),

                    /// Check
                    AnimatedOpacity(
                      opacity: usingFeed ? 1 : 0,
                      duration: NovinarkoConstants.animationDuration,
                      curve: Curves.easeIn,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Image.asset(
                          NovinarkoIcons.check,
                          fit: BoxFit.cover,
                          color: context.colors.text,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
