import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../constants.dart';
import '../../../main.dart';
import '../../../models/feed_search_model.dart';
import '../../../routing.dart';
import '../../../services/active_feed_service.dart';
import '../../../services/hive_service.dart';
import '../../../services/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/parsing.dart';
import '../../../util/snackbars.dart';
import '../../../widgets/novinarko_network_image.dart';
import '../../search/search_screen.dart';
import 'news_feed_info_dialog.dart';

class NewsAppBar extends WatchingWidget implements PreferredSizeWidget {
  /// Opens [SearchScreen] or shows [SnackBar], depending on `feedsLength`
  Future<void> openSearchOrShowSnackBar(
    BuildContext context, {
    required int feedsLength,
  }) async {
    /// User has less than feed limit, open [SearchScreen]
    if (feedsLength < feedLimit) {
      openSearch(context);
    }

    /// User has more than feed limit, show [SnackBar]
    else {
      showRemoveSomeFeedsSnackbar(
        context,
        onPressed: () => openFeeds(context),
      );
    }
  }

  /// Opens [NewsFeedInfoDialog] showing data about the active feed
  void openFeedInfoDialog(
    BuildContext context, {
    required FeedSearchModel feed,
  }) =>
      showDialog(
        context: context,
        builder: (context) => NewsFeedInfoDialog(
          feed: feed,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final activeFeed = watchIt<ActiveFeedService>().value;
    final feedsLength = watchIt<HiveService>().value.length;
    final isDark = watchIt<ThemeService>().value == NovinarkoTheme.dark;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.infinite,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NewsAppBarAvatar(
                favicon: getFeedIcon(activeFeed),
                feedTitle: getFeedTitle(activeFeed)?.substring(0, 2) ?? 'newsAllFeedsTitle'.tr().substring(0, 2),
                hasActiveFeed: activeFeed != null,
                onPressed: activeFeed != null
                    ? () => openFeedInfoDialog(
                          context,
                          feed: activeFeed,
                        )
                    : () {},
              ),
              const SizedBox(width: 40),
              Expanded(
                child: NewsAppBarActiveFeed(
                  feedTitle: getFeedTitle(activeFeed) ?? 'newsAllFeedsTitle'.tr(),
                  onPressed: () => openFeeds(context),
                ),
              ),
              const SizedBox(width: 40),
              NewsAppBarSearch(
                noSearch: feedsLength >= feedLimit,
                onPressed: () => openSearchOrShowSnackBar(
                  context,
                  feedsLength: feedsLength,
                ),
              ),
            ],
          ),
        ),
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16,
            sigmaY: 16,
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);
}

class NewsAppBarAvatar extends StatelessWidget {
  final String? favicon;
  final String feedTitle;
  final Function() onPressed;
  final bool hasActiveFeed;

  const NewsAppBarAvatar({
    required this.feedTitle,
    required this.onPressed,
    required this.hasActiveFeed,
    this.favicon,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          highlightColor: context.colors.primary.withOpacity(0.6),
          fixedSize: const Size(48, 48),
          shape: const CircleBorder(),
          side: BorderSide(
            color: context.colors.text,
            width: 2,
          ),
        ),
        icon: Center(
          child: !hasActiveFeed
              ? ClipOval(
                  child: Image.asset(
                    NovinarkoIcons.all,
                    fit: BoxFit.cover,
                    color: context.colors.text,
                  ),
                )
              : favicon != null
                  ? ClipOval(
                      child: NovinarkoNetworkImage(
                        imageUrl: favicon!,
                        placeholderWidget: Text(
                          feedTitle,
                          style: context.textStyles.twoLettersAppBar,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        errorWidget: Text(
                          feedTitle,
                          style: context.textStyles.twoLettersAppBar,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  : Text(
                      feedTitle,
                      style: context.textStyles.twoLettersAppBar,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
        ),
      );
}

class NewsAppBarActiveFeed extends StatelessWidget {
  final String feedTitle;
  final Function() onPressed;

  const NewsAppBarActiveFeed({
    required this.feedTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        splashColor: context.colors.primary.withOpacity(0.6),
        highlightColor: context.colors.primary.withOpacity(0.6),
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: context.colors.text,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 16,
                width: 16,
              ),
              Expanded(
                child: Text(
                  feedTitle,
                  style: context.textStyles.newsAppBar,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_downward_rounded,
                color: context.colors.text,
                size: 24,
              ),
            ],
          ),
        ),
      );
}

class NewsAppBarSearch extends StatelessWidget {
  final Function() onPressed;
  final bool noSearch;

  const NewsAppBarSearch({
    required this.onPressed,
    required this.noSearch,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          highlightColor: context.colors.primary.withOpacity(0.6),
          fixedSize: const Size(48, 48),
          shape: const CircleBorder(),
          side: BorderSide(
            color: context.colors.text,
            width: 2,
          ),
        ),
        icon: Center(
          child: Image.asset(
            noSearch ? NovinarkoIcons.noSearch : NovinarkoIcons.search,
            fit: BoxFit.cover,
            color: context.colors.text,
            height: 20,
            width: 20,
          ),
        ),
      );
}
