import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:rss_dart/dart_rss.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:xml/xml.dart';

import '../models/feed_model.dart';

String? getRSSImageUrl({
  required RssItem item,
  required String? rawContent,
}) =>
    item.media?.thumbnails.firstOrNull?.url ??
    item.media?.contents.firstOrNull?.url ??
    item.media?.group?.thumbnails.firstOrNull?.url ??
    item.media?.group?.contents.firstOrNull?.url ??
    item.content?.images.firstOrNull ??
    item.enclosure?.url ??
    parseImageSourceHtml(item.content?.value) ??
    parseImageSourceHtml(item.description) ??
    parseImageSourceHtml(rawContent);

String? getAtomImageUrl({
  required AtomItem item,
}) {
  String? imgUrl;

  try {
    imgUrl =
        item.media?.thumbnails.firstOrNull?.url ??
        item.media?.contents.firstOrNull?.url ??
        item.media?.group?.thumbnails.firstOrNull?.url ??
        item.media?.group?.contents.firstOrNull?.url;

    if (imgUrl != null) {
      return imgUrl;
    }

    for (final link in item.links) {
      if (link.type?.contains('image') ?? false) {
        imgUrl = link.href;
        break;
      }
    }

    if (imgUrl != null) {
      return imgUrl;
    }

    imgUrl = parseImageSourceHtml(item.content);

    if (imgUrl != null) {
      return imgUrl;
    }

    imgUrl = parseImageSourceHtml(item.summary);

    if (imgUrl != null) {
      return imgUrl;
    }
  } catch (e) {
    return null;
  }

  return null;
}

String? getAtomLink(AtomItem item) {
  for (final link in item.links) {
    if (link.rel == 'alternate' || link.rel == null) {
      if (link.href != null) {
        return link.href;
      }
    }
  }
  return null;
}

String? parseImageSourceHtml(String? htmlContent) {
  try {
    final htmlDocument = html_parser.parse(htmlContent);
    final imgElement = htmlDocument.querySelector('img');

    if (imgElement != null) {
      return imgElement.attributes['src'];
    }

    return null;
  } catch (e) {
    return null;
  }
}

String? parseDescriptionHtml(String? htmlContent) {
  try {
    final htmlDocument = html_parser.parse(htmlContent);
    final text = htmlDocument.body?.text.trim();

    return text;
  } catch (e) {
    return null;
  }
}

DateTime? parsePubDate(String? pubDate) {
  if (pubDate == null) {
    return null;
  }

  try {
    /// Parse `String` into a `DateTime`
    final dateTime = DateFormat('EEE, dd MMM yyyy HH:mm:ss Z', 'en').tryParse(pubDate) ?? DateTime.tryParse(pubDate);

    if (dateTime != null) {
      /// Extract the timezone offset in minutes from the parsed date string
      final timeZoneOffsetInMinutes = Duration(
        hours: int.tryParse(pubDate.substring(pubDate.length - 4, pubDate.length - 2)) ?? 0,
        minutes: int.tryParse(pubDate.substring(pubDate.length - 2)) ?? 0,
      ).inMinutes;

      /// See if timezone offset should have a negative value
      final timeZoneOffsetIsNegative = pubDate[pubDate.length - 5] == '-';

      /// Get the timezone offset of the device in minutes
      final deviceTimeZoneOffsetInMinutes = DateTime.now().timeZoneOffset.inMinutes;

      /// Calculate the offset
      final calculatedOffsetInMinutes = deviceTimeZoneOffsetInMinutes - (timeZoneOffsetIsNegative ? (-timeZoneOffsetInMinutes) : timeZoneOffsetInMinutes);

      return dateTime.add(Duration(minutes: calculatedOffsetInMinutes));
    }

    return null;
  } catch (e) {
    return null;
  }
}

String? parseDateTimeago(DateTime? dateTime, {required BuildContext context}) {
  if (dateTime == null) {
    return null;
  }

  try {
    /// Format `DateTime` using `timeago` package
    final timeagoDateTime = timeago.format(
      dateTime,
      locale: context.locale.toLanguageTag(),
    );

    return timeagoDateTime;
  } catch (e) {
    return null;
  }
}

String? getFeedTitle(FeedModel? feed) {
  try {
    if (feed != null) {
      if (feed.siteName != null) {
        return feed.siteName;
      }

      if (feed.title != null) {
        return feed.title;
      }

      if (feed.siteUrl != null || feed.url != null) {
        final uri = Uri.tryParse(feed.siteUrl ?? feed.url ?? '');

        if (uri != null) {
          final host = uri.host.startsWith('www.') ? uri.host.substring(4) : uri.host;
          return host;
        }
      }
    }

    return null;
  } catch (e) {
    return null;
  }
}

String? getFeedIcon(FeedModel? feed) {
  try {
    if (feed != null) {
      if (feed.favicon != null) {
        return feed.favicon;
      }
    }

    return null;
  } catch (e) {
    return null;
  }
}

List<String> parseContentsFromXml(String xmlContent) {
  try {
    final document = XmlDocument.parse(xmlContent);

    /// Find all item elements
    final items = document.findAllElements('item');

    return items.map((node) {
      final contentNode = node.findElements('content').firstOrNull;

      if (contentNode != null) {
        return contentNode.children.map(
          (child) {
            if (child is XmlText) {
              return child.value;
            } else if (child is XmlCDATA) {
              return child.value;
            } else if (child is XmlElement) {
              return child.toXmlString();
            }

            return child.value;
          },
        ).join();
      }
      return '';
    }).toList();
  } catch (e) {
    return [];
  }
}
