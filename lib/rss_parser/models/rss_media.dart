import 'package:xml/xml.dart';

class RssMedia {
  final String? url;

  RssMedia({
    this.url,
  });

  static RssMedia? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssMedia(
      url: element.getAttribute('url'),
    );
  }
}
