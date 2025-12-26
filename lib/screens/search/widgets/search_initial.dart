import 'package:flutter/material.dart' hide SearchController;

import '../../../constants.dart';
import '../../../models/feed_model.dart';
import 'search_sample_model_tile.dart';

class SearchInitial extends StatefulWidget {
  final List<FeedModel> hiveFeeds;
  final String fontFamily;

  const SearchInitial({
    required this.hiveFeeds,
    required this.fontFamily,
  });

  @override
  State<SearchInitial> createState() => _SearchInitialState();
}

class _SearchInitialState extends State<SearchInitial> {
  late final sampleModels = NovinarkoSampleFeeds.feeds;

  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemCount: sampleModels.length,
    itemBuilder: (_, index) => SearchSampleModelTile(
      model: sampleModels[index],
      hiveFeeds: widget.hiveFeeds,
      fontFamily: widget.fontFamily,
    ),
    separatorBuilder: (_, __) => const SizedBox(height: 24),
  );
}
