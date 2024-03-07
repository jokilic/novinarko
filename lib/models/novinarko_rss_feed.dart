import 'package:flutter/foundation.dart';

import 'novinarko_rss_item.dart';

class NovinarkoRssFeed {
  final String? siteName;
  final String? title;
  final String? description;
  final List<NovinarkoRssItem>? items;

  NovinarkoRssFeed({
    this.siteName,
    this.title,
    this.description,
    this.items,
  });

  NovinarkoRssFeed copyWith({
    String? siteName,
    String? title,
    String? feedTitle,
    String? description,
    List<NovinarkoRssItem>? items,
  }) =>
      NovinarkoRssFeed(
        siteName: siteName ?? this.siteName,
        title: title ?? this.title,
        description: description ?? this.description,
        items: items ?? this.items,
      );

  @override
  String toString() => 'NovinarkoRssFeed(siteName: $siteName, title: $title, description: $description, items: $items)';

  @override
  bool operator ==(covariant NovinarkoRssFeed other) {
    if (identical(this, other)) {
      return true;
    }

    return other.siteName == siteName && other.title == title && other.description == description && listEquals(other.items, items);
  }

  @override
  int get hashCode => siteName.hashCode ^ title.hashCode ^ description.hashCode ^ items.hashCode;
}
