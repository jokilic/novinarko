import 'package:xml/xml.dart';

import '../util/helpers.dart';
import 'rss_content.dart';
import 'rss_enclosure.dart';

class RssItem {
  final String? title;
  final String? description;
  final String? link;
  final String? guid;
  final String? pubDate;
  final RssContent? content;
  final RssEnclosure? enclosure;

  const RssItem({
    this.title,
    this.description,
    this.link,
    this.guid,
    this.pubDate,
    this.content,
    this.enclosure,
  });

  factory RssItem.parse(XmlElement element) => RssItem(
        title: findElementOrNull(element, 'title')?.innerText,
        description: findElementOrNull(element, 'description')?.innerText,
        link: findElementOrNull(element, 'link')?.innerText,
        guid: findElementOrNull(element, 'guid')?.innerText,
        pubDate: findElementOrNull(element, 'pubDate')?.innerText,
        content: RssContent.parse(findElementOrNull(element, 'content')),
        enclosure: RssEnclosure.parse(findElementOrNull(element, 'enclosure')),
      );

  @override
  String toString() => 'RssItem(title: $title, description: $description, link: $link, guid: $guid, pubDate: $pubDate, content: $content, enclosure: $enclosure)';
}
