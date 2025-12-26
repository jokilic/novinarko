import 'package:flutter/foundation.dart';

import 'feed_model.dart';

class SampleFeedModel {
  final String name;
  final String icon;
  final List<FeedModel> feeds;

  SampleFeedModel({
    required this.name,
    required this.icon,
    required this.feeds,
  });

  @override
  String toString() => 'SampleFeedModel(name: $name, icon: $icon, feeds: $feeds)';

  @override
  bool operator ==(covariant SampleFeedModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.name == name && other.icon == icon && listEquals(other.feeds, feeds);
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ feeds.hashCode;
}
