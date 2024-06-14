import 'util/env.dart';

class NovinarkoConstants {
  static final googleSearchAPIKey = Env.googleSearchApiKey;
  static final programmableSearchEngineID = Env.programmableSearchEngineId;

  static final urlRegExp = RegExp(
    /// Optional protocol part (`http://` or `https://`)
    '^(http(s)?://)?'

    /// Domain name
    r'([a-zA-Z0-9]+\.)*[a-zA-Z0-9-]+(\.[a-z]{2,})+'

    /// Optional port number
    '(:[0-9]+)?'

    /// Optional path
    r"(/([a-zA-Z0-9\-._~:/?#[\]@!$&'()*+,;=]*)?)?"

    /// Optional query parameters
    r"(\?[a-zA-Z0-9\-._~:/?#[\]@!$&'()*+,;=]*)?"

    /// Optional fragment identifier
    r"(#[a-zA-Z0-9\-._~:/?#[\]@!$&'()*+,;=]*)?"
    r'$',
  );

  static const animationDuration = Duration(milliseconds: 300);
  static const shimmerDuration = Duration(milliseconds: 1500);
}

class NovinarkoIcons {
  static const all = 'assets/icons/all.png';
  static const back = 'assets/icons/back.png';
  static const check = 'assets/icons/check.png';
  static const delete = 'assets/icons/delete.png';
  static const errorNews = 'assets/icons/error_news.png';
  static const errorSearch = 'assets/icons/error_search.png';
  static const news = 'assets/icons/news.png';
  static const noNews = 'assets/icons/no_news.png';
  static const yesNews = 'assets/icons/yes_news.png';
  static const noSearch = 'assets/icons/no_search.png';
  static const search = 'assets/icons/search.png';
  static const customSearch = 'assets/icons/custom_search.png';
  static const settings = 'assets/icons/settings.png';
  static const info = 'assets/icons/info.png';
  static const close = 'assets/icons/close.png';
  static const icon = 'assets/icon.png';
}
