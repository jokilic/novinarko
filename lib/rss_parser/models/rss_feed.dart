// ignore_for_file: unnecessary_lambdas

import 'dart:core';

import 'package:xml/xml.dart';

import '../util/helpers.dart';
import 'rss_item.dart';

class RssFeed {
  final String? title;
  final String? description;
  final List<RssItem> items;

  const RssFeed({
    this.title,
    this.description,
    this.items = const <RssItem>[],
  });

  factory RssFeed.parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    XmlElement channelElement;

    try {
      channelElement = document.findAllElements('channel').first;
    } catch (e) {
      throw ArgumentError('channel not found');
    }

    return RssFeed(
      title: findElementOrNull(channelElement, 'title')?.innerText,
      description: findElementOrNull(channelElement, 'description')?.innerText,
      items: channelElement.findElements('item').map((element) => RssItem.parse(element)).toList(),
    );
  }

  @override
  String toString() => 'RssFeed(title: $title, description: $description, items: $items)';
}
