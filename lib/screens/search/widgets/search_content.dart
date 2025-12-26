import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/feed_model.dart';
import '../../../widgets/novinarko_icon_text_widget.dart';
import '../../../widgets/novinarko_loader.dart';
import '../search_state.dart';
import 'search_initial.dart';
import 'search_loading.dart';
import 'search_result.dart';

class SearchContent extends StatelessWidget {
  final SearchState searchState;
  final List<FeedModel> hiveFeeds;
  final bool shimmerLoader;
  final String fontFamily;

  const SearchContent({
    required this.searchState,
    required this.hiveFeeds,
    required this.shimmerLoader,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) => switch (searchState) {
    SearchStateInitial() => SearchInitial(
      hiveFeeds: hiveFeeds,
      fontFamily: fontFamily,
    ),
    SearchStateLoading() =>
      shimmerLoader
          ? SearchLoading()
          : NovinarkoLoader(
              text: (searchState as SearchStateLoading).loadingStatus,
            ),
    SearchStateEmpty() => NovinarkoIconTextWidget(
      icon: NovinarkoIcons.noSearch,
      title: 'searchStateEmptyTitle'.tr(),
      subtitle: 'searchStateEmptySubtitle'.tr(),
      fontFamily: fontFamily,
    ),
    SearchStateError() => NovinarkoIconTextWidget(
      icon: NovinarkoIcons.errorSearch,
      title: 'searchStateErrorTitle'.tr(),
      subtitle: (searchState as SearchStateError).error?.message ?? (searchState as SearchStateError).genericError,
      fontFamily: fontFamily,
    ),
    SearchStateSuccess() => SearchResult(
      results: (searchState as SearchStateSuccess).results,
      hiveFeeds: hiveFeeds,
      fontFamily: fontFamily,
    ),
  };
}
