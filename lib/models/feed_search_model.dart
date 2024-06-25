import 'package:hive_ce/hive.dart';

part 'feed_search_model.g.dart';

@HiveType(typeId: 0)
class FeedSearchModel {
  @HiveField(0)
  final String? description;
  @HiveField(1)
  final String? favicon;
  @HiveField(2)
  final String? siteName;
  @HiveField(3)
  final String? siteUrl;
  @HiveField(4)
  final String? title;
  @HiveField(5)
  final String? url;

  FeedSearchModel({
    this.description,
    this.favicon,
    this.siteName,
    this.siteUrl,
    this.title,
    this.url,
  });

  factory FeedSearchModel.fromMap(Map<String, dynamic> map) => FeedSearchModel(
        description: map['description'] != null ? map['description'] as String : null,
        favicon: map['favicon'] != null ? map['favicon'] as String : null,
        siteName: map['site_name'] != null ? map['site_name'] as String : null,
        siteUrl: map['site_url'] != null ? map['site_url'] as String : null,
        title: map['title'] != null ? map['title'] as String : null,
        url: map['url'] != null ? map['url'] as String : null,
      );

  @override
  String toString() => 'FeedSearch(description: $description, favicon: $favicon, siteName: $siteName, siteUrl: $siteUrl, title: $title, url: $url)';

  @override
  bool operator ==(covariant FeedSearchModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.description == description && other.favicon == favicon && other.siteName == siteName && other.siteUrl == siteUrl && other.title == title && other.url == url;
  }

  @override
  int get hashCode => description.hashCode ^ favicon.hashCode ^ siteName.hashCode ^ siteUrl.hashCode ^ title.hashCode ^ url.hashCode;
}
