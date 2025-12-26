import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';

import 'feed_model.dart';

part 'folder_model.g.dart';

@HiveType(typeId: 3)
class FolderModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final List<FeedModel>? feeds;

  FolderModel({
    required this.title,
    this.description,
    this.feeds,
  });

  factory FolderModel.fromMap(Map<String, dynamic> map) => FolderModel(
    title: map['title'] as String,
    description: map['description'] != null ? map['description'] as String : null,
    feeds: map['description'] != null
        ? List<FeedModel>.from(
            (map['items'] as List<dynamic>).map<FeedModel>(
              (x) => FeedModel.fromMap(x as Map<String, dynamic>),
            ),
          )
        : null,
  );

  @override
  String toString() => 'FolderModel(title: $title, description: $description, feeds: $feeds)';

  @override
  bool operator ==(covariant FolderModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.title == title && other.description == description && listEquals(other.feeds, feeds);
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ feeds.hashCode;
}
