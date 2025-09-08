import 'package:flutter/material.dart' hide SearchController;

import '../../../models/feed_search_model.dart';
import '../../../services/active_feed_service.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_divider.dart';
import 'search_list_tile.dart';

class SearchInitial extends StatelessWidget {
  final List<FeedSearchModel> omplFeeds;
  final List<FeedSearchModel> hiveFeeds;
  final String fontFamily;

  const SearchInitial({
    required this.omplFeeds,
    required this.hiveFeeds,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemCount: omplFeeds.length,
    itemBuilder: (_, index) {
      final result = omplFeeds[index];

      return SearchListTile(
        onPressed: () => getIt.get<ActiveFeedService>().storeOrDeleteFeed(result),
        title: result.title,
        siteName: result.siteName,
        description: result.description,
        favicon: result.favicon,
        url: result.url,
        usingFeed: hiveFeeds.contains(result),
        fontFamily: fontFamily,
      );
    },
    separatorBuilder: (_, __) => NovinarkoDivider(),
  );
}
