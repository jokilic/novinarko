import 'package:flutter/foundation.dart';

class GoogleSearchItems {
  final List<GoogleSearchModel> items;

  GoogleSearchItems({
    required this.items,
  });

  factory GoogleSearchItems.fromMap(Map<String, dynamic> map) => GoogleSearchItems(
        items: List<GoogleSearchModel>.from(
          (map['items'] as List<dynamic>).map<GoogleSearchModel>(
            (x) => GoogleSearchModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );

  @override
  String toString() => 'GoogleSearchItems(items: $items)';

  @override
  bool operator ==(covariant GoogleSearchItems other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

class GoogleSearchModel {
  final String link;

  GoogleSearchModel({
    required this.link,
  });

  factory GoogleSearchModel.fromMap(Map<String, dynamic> map) => GoogleSearchModel(
        link: map['link'] as String,
      );

  @override
  String toString() => 'GoogleSearch(link: $link)';

  @override
  bool operator ==(covariant GoogleSearchModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.link == link;
  }

  @override
  int get hashCode => link.hashCode;
}
