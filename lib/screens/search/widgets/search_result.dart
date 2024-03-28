import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_animate/flutter_animate.dart';

import '../../../models/feed_search_model.dart';
import '../../../services/active_feed_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import 'search_list_tile.dart';

class SearchResult extends StatelessWidget {
  final List<FeedSearchModel> results;
  final List<FeedSearchModel> hiveFeeds;

  const SearchResult({
    required this.results,
    required this.hiveFeeds,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (_, index) {
          final result = results[index];

          return Animate(
            key: ValueKey(result),
            delay: (const Duration(milliseconds: 150).inMilliseconds * index).milliseconds,
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 450),
              ),
            ],
            child: SearchListTile(
              onPressed: () => getIt.get<ActiveFeedService>().storeOrDeleteFeed(
                    result,
                    deleteFeed: hiveFeeds.contains(result),
                  ),
              title: result.title,
              siteName: result.siteName,
              description: result.description,
              favicon: result.favicon,
              url: result.url,
              usingFeed: hiveFeeds.contains(result),
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
      );
}
