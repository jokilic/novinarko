import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:timeago/timeago.dart' as timeago;

import '../models/feed_search_model.dart';

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
    final dateTime = DateFormat('EEE, dd MMM yyyy HH:mm:ss Z', 'en').tryParse(pubDate);

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

String? getFeedTitle(FeedSearchModel? feed) {
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

String? getFeedIcon(FeedSearchModel? feed) {
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
