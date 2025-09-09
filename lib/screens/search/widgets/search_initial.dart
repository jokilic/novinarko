import 'package:flutter/material.dart' hide SearchController;

import '../../../models/feed_search_model.dart';
import '../../../models/sample_feed_model.dart';
import 'search_sample_model_tile.dart';

class SearchInitial extends StatelessWidget {
  final List<SampleFeedModel> sampleModels;
  final List<FeedSearchModel> hiveFeeds;
  final String fontFamily;

  const SearchInitial({
    required this.sampleModels,
    required this.hiveFeeds,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemCount: sampleModels.length,
    itemBuilder: (_, index) => SearchSampleModelTile(
      model: sampleModels[index],
      hiveFeeds: hiveFeeds,
      fontFamily: fontFamily,
    ),
    separatorBuilder: (_, __) => const SizedBox(height: 24),
  );
}
