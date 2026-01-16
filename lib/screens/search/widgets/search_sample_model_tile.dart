import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/feed_model.dart';
import '../../../models/sample_feed_model.dart';
import '../../../services/active_feed_folder_service.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/novinarko_divider.dart';
import 'search_list_tile.dart';

class SearchSampleModelTile extends StatefulWidget {
  final SampleFeedModel model;
  final List<FeedModel> hiveFeeds;
  final String fontFamily;

  const SearchSampleModelTile({
    required this.model,
    required this.hiveFeeds,
    required this.fontFamily,
  });

  @override
  State<SearchSampleModelTile> createState() => _SearchSampleModelTileState();
}

class _SearchSampleModelTileState extends State<SearchSampleModelTile> {
  var turns = 0.5;

  List<Widget> getSearchListTiles() {
    final tiles = <Widget>[];

    for (var i = 0; i < widget.model.feeds.length; i++) {
      final result = widget.model.feeds[i];

      tiles.add(
        SearchListTile(
          onPressed: () => getIt.get<ActiveFeedFolderService>().storeOrDeleteFeed(result),
          title: result.title,
          siteName: result.siteName,
          description: result.description,
          favicon: result.favicon,
          url: result.url,
          usingFeed: widget.hiveFeeds.contains(result),
          fontFamily: widget.fontFamily,
        ),
      );

      if (i < widget.model.feeds.length - 1) {
        tiles.add(
          const NovinarkoDivider(),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) => ExpansionTile(
    onExpansionChanged: (value) => setState(
      () => turns = value ? 0.75 : 0.5,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    tilePadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    childrenPadding: const EdgeInsets.only(top: 8, bottom: 16),
    leading: IconButton(
      onPressed: null,
      style: IconButton.styleFrom(
        highlightColor: context.colors.primary.withValues(alpha: 0.6),
        fixedSize: const Size(52, 52),
        shape: const CircleBorder(),
        side: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
      icon: Image.asset(
        widget.model.icon,
        fit: BoxFit.cover,
        color: context.colors.text,
        height: 24,
        width: 24,
      ),
    ),
    title: Text(
      widget.model.name,
      style: context.textStyles.searchSampleTitle.copyWith(
        fontFamily: widget.fontFamily,
      ),
    ),
    trailing: AnimatedRotation(
      turns: turns,
      duration: NovinarkoConstants.animationDuration,
      curve: Curves.easeIn,
      child: Image.asset(
        NovinarkoIcons.back,
        color: context.colors.text,
        height: 24,
        width: 24,
      ),
    ),
    children: getSearchListTiles(),
  );
}
