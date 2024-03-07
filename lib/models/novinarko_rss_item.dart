class NovinarkoRssItem {
  final String? favicon;
  final String? title;
  final String? feedTitle;
  final String? description;
  final String? link;
  final String? guid;
  final DateTime? pubDate;

  NovinarkoRssItem({
    this.favicon,
    this.title,
    this.feedTitle,
    this.description,
    this.link,
    this.guid,
    this.pubDate,
  });

  NovinarkoRssItem copyWith({
    String? favicon,
    String? siteName,
    String? title,
    String? feedTitle,
    String? description,
    String? link,
    String? guid,
    DateTime? pubDate,
  }) =>
      NovinarkoRssItem(
        favicon: favicon ?? this.favicon,
        title: title ?? this.title,
        feedTitle: feedTitle ?? this.feedTitle,
        description: description ?? this.description,
        link: link ?? this.link,
        guid: guid ?? this.guid,
        pubDate: pubDate ?? this.pubDate,
      );

  @override
  String toString() => 'NovinarkoRssItem(favicon: $favicon, title: $title, feedTitle: $feedTitle, description: $description, link: $link, guid: $guid, pubDate: $pubDate)';

  @override
  bool operator ==(covariant NovinarkoRssItem other) {
    if (identical(this, other)) {
      return true;
    }

    return other.favicon == favicon &&
        other.title == title &&
        other.feedTitle == feedTitle &&
        other.description == description &&
        other.link == link &&
        other.guid == guid &&
        other.pubDate == pubDate;
  }

  @override
  int get hashCode => favicon.hashCode ^ title.hashCode ^ feedTitle.hashCode ^ description.hashCode ^ link.hashCode ^ guid.hashCode ^ pubDate.hashCode;
}
