import 'package:flutter/material.dart' hide SearchController;

import '../../../models/feed_model.dart';
import '../../../services/active_feed_folder_service.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_divider.dart';
import 'search_list_tile.dart';

class SearchResult extends StatelessWidget {
  final List<FeedModel> results;
  final List<FeedModel> hiveFeeds;
  final String fontFamily;

  const SearchResult({
    required this.results,
    required this.hiveFeeds,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemCount: results.length,
    itemBuilder: (_, index) {
      final result = results[index];

      return SearchListTile(
        onPressed: () => getIt.get<ActiveFeedFolderService>().storeOrDeleteFeed(result),
        title: result.title,
        siteName: result.siteName,
        description: result.description,
        favicon: result.favicon,
        url: result.url,
        usingFeed: hiveFeeds.contains(result),
        fontFamily: fontFamily,
      );
    },
    separatorBuilder: (_, __) => const NovinarkoDivider(),
  );
}
