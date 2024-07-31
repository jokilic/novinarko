import 'package:xml/xml.dart';

import '../../util/parsing.dart';
import '../util/helpers.dart';
import 'rss_content.dart';
import 'rss_enclosure.dart';
import 'rss_media.dart';

class RssItem {
  final String? title;
  final String? description;
  final String? descriptionImage;
  final String? link;
  final String? guid;
  final String? pubDate;
  final RssContent? content;
  final RssEnclosure? enclosure;
  final RssMedia? media;

  const RssItem({
    this.title,
    this.description,
    this.descriptionImage,
    this.link,
    this.guid,
    this.pubDate,
    this.content,
    this.enclosure,
    this.media,
  });

  factory RssItem.parse(XmlElement element) {
    final description = findElementOrNull(element, 'description');

    return RssItem(
      title: findElementOrNull(element, 'title')?.innerText,
      description: description?.innerText,
      descriptionImage: parseImageSourceHtml(
        description?.children.firstOrNull?.value,
      ),
      link: findElementOrNull(element, 'link')?.innerText,
      guid: findElementOrNull(element, 'guid')?.innerText,
      pubDate: findElementOrNull(element, 'pubDate')?.innerText,
      content: RssContent.parse(findElementOrNull(element, 'content')),
      enclosure: RssEnclosure.parse(findElementOrNull(element, 'enclosure')),
      media: RssMedia.parse(findElementOrNull(element, 'media:content')),
    );
  }

  @override
  String toString() => 'RssItem(title: $title, description: $description, link: $link, guid: $guid, pubDate: $pubDate, content: $content, enclosure: $enclosure)';
}
