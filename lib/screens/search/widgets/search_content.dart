import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/feed_search_model.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../../widgets/novinarko_loader.dart';
import '../search_state.dart';
import 'search_result.dart';

class SearchContent extends StatelessWidget {
  final SearchState searchState;
  final List<FeedSearchModel> hiveFeeds;

  const SearchContent({
    required this.searchState,
    required this.hiveFeeds,
  });

  @override
  Widget build(BuildContext context) => switch (searchState) {
        SearchStateInitial() => NovinarkoIconTextWidget(
            arrowAlignment: Alignment.center,
            icon: NovinarkoIcons.search,
            title: 'searchStateInitialTitle'.tr(),
            subtitle: 'searchStateInitialSubtitle'.tr(),
          ),
        SearchStateLoading() => NovinarkoLoader(
            text: (searchState as SearchStateLoading).loadingStatus,
          ),
        SearchStateEmpty() => NovinarkoIconTextWidget(
            icon: NovinarkoIcons.noSearch,
            title: 'searchStateEmptyTitle'.tr(),
            subtitle: 'searchStateEmptySubtitle'.tr(),
          ),
        SearchStateError() => NovinarkoIconTextWidget(
            icon: NovinarkoIcons.errorSearch,
            title: 'searchStateErrorTitle'.tr(),
            subtitle: (searchState as SearchStateError).error?.message ?? (searchState as SearchStateError).genericError,
          ),
        SearchStateSuccess() => SearchResult(
            results: (searchState as SearchStateSuccess).results,
            hiveFeeds: hiveFeeds,
          ),
      };
}
