import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';

import 'feed_search_model.dart';

part 'feeds_folder_model.g.dart';

@HiveType(typeId: 3)
class FeedsFolderModel {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<FeedSearchModel> feeds;

  FeedsFolderModel({
    required this.name,
    this.feeds = const [],
  });

  @override
  String toString() => 'FeedSearch( name: $name, feeds: $feeds)';

  @override
  bool operator ==(covariant FeedsFolderModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.name == name && listEquals(other.feeds, feeds);
  }

  @override
  int get hashCode => name.hashCode ^ feeds.hashCode;
}
