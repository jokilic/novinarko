import 'package:easy_localization/easy_localization.dart';

import 'models/feed_search_model.dart';
import 'models/sample_feed_model.dart';
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
  static const restoreReadingDuration = Duration(milliseconds: 150);
  static const restoreReadingSnackbarDuration = Duration(milliseconds: 4500);
  static const snowflakeDuration = Duration(milliseconds: 300);
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
  // TODO: Thicker icon here
  static const addFolder = 'assets/icons/add_folder.png';
  static const settings = 'assets/icons/settings.png';
  static const info = 'assets/icons/info.png';
  static const close = 'assets/icons/close.png';
  static const browserBack = 'assets/icons/browser_back.png';
  static const share = 'assets/icons/share.png';
  static const refresh = 'assets/icons/refresh.png';
  static const rss = 'assets/icons/rss.png';
  static const android = 'assets/icons/android.png';
  static const apple = 'assets/icons/apple.png';
  static const business = 'assets/icons/business.png';
  static const cars = 'assets/icons/cars.png';
  static const fashion = 'assets/icons/fashion.png';
  static const food = 'assets/icons/food.png';
  static const gaming = 'assets/icons/gaming.png';
  static const history = 'assets/icons/history.png';
  static const movies = 'assets/icons/movies.png';
  static const music = 'assets/icons/music.png';
  static const programming = 'assets/icons/programming.png';
  static const sports = 'assets/icons/sports.png';
  static const icon = 'assets/icon.png';
  static const splashIcon = 'assets/splash_icon.png';
}

class NovinarkoSampleFeeds {
  static final feeds = [
    android,
    apple,
    businessEconomy,
    cars,
    fashion,
    food,
    gaming,
    history,
    movies,
    music,
    news,
    programming,
    sports,
  ];

  ///
  /// ANDROID
  ///

  static final android = SampleFeedModel(
    name: 'searchSampleAndroid'.tr(),
    icon: NovinarkoIcons.android,
    feeds: [
      FeedSearchModel(
        title: 'Android Authority',
        siteName: 'Android Authority',
        description: 'Android News, Reviews, How To',
        url: 'https://www.androidauthority.com/feed',
      ),
      FeedSearchModel(
        title: 'Android news, reviews, apps, games, phones, tablets',
        siteName: 'Android Police',
        description: 'Looking after everything Android',
        url: 'http://feeds.feedburner.com/AndroidPolice',
      ),
      FeedSearchModel(
        title: 'Droid Life',
        siteName: 'Droid Life',
        description: 'Opinionated Android news.',
        url: 'https://www.droid-life.com/feed',
      ),
    ],
  );

  ///
  /// APPLE
  ///

  static final apple = SampleFeedModel(
    name: 'searchSampleApple'.tr(),
    icon: NovinarkoIcons.apple,
    feeds: [
      FeedSearchModel(
        title: '9to5Mac',
        siteName: '9to5Mac',
        description: 'Apple News & Mac Rumors Breaking All Day',
        url: 'https://9to5mac.com/feed',
      ),
      FeedSearchModel(
        title: 'Cult of Mac',
        siteName: 'Cult of Mac',
        description: 'Tech and culture through an Apple lens',
        url: 'https://www.cultofmac.com/feed',
      ),
      FeedSearchModel(
        title: 'Macworld.com',
        siteName: 'Macworld.com',
        description: "Macworld is your best source for all things Apple. We give you the scoop on what's new, what's best and how to make the most out of the products you love.",
        url: 'https://www.macworld.com/index.rss',
      ),
    ],
  );

  ///
  /// BUSINESS & ECONOMY
  ///

  static final businessEconomy = SampleFeedModel(
    name: 'searchSampleBusiness'.tr(),
    icon: NovinarkoIcons.business,
    feeds: [
      FeedSearchModel(
        title: 'Forbes - Business',
        siteName: 'Forbes - Business',
        url: 'https://www.forbes.com/business/feed',
      ),
      FeedSearchModel(
        title: 'Fortune',
        siteName: 'Fortune',
        description: 'Fortune 500 Daily & Breaking Business News',
        url: 'https://fortune.com/feed',
      ),
      FeedSearchModel(
        title: 'Yahoo Finance',
        siteName: 'Yahoo Finance',
        description:
            'At Yahoo Finance, you get free stock quotes, up-to-date news, portfolio management resources, international market data, social interaction and mortgage rates that help you manage your financial life.',
        url: 'https://finance.yahoo.com/news/rssindex',
      ),
    ],
  );

  ///
  /// CARS
  ///

  static final cars = SampleFeedModel(
    name: 'searchSampleCars'.tr(),
    icon: NovinarkoIcons.cars,
    feeds: [
      FeedSearchModel(
        title: 'Autoblog',
        siteName: 'Autoblog',
        url: 'https://www.autoblog.com/rss.xml',
      ),
      FeedSearchModel(
        title: 'Autocar RSS Feed',
        siteName: 'Autocar RSS Feed',
        description:
            "Welcome to nirvana for car enthusiasts. You have just entered the online home of the world's oldest car magazine, and the only place on the internet where you can find Autocar's unique mix of up-to-the-minute news, red hot car reviews, conclusive road test verdicts, and a lot more besides.",
        url: 'https://www.autocar.co.uk/rss',
      ),
      FeedSearchModel(
        title: 'Carscoops',
        siteName: 'Carscoops',
        description: 'Breaking Car News, Scoops & Reviews',
        url: 'https://www.carscoops.com/feed',
      ),
    ],
  );

  ///
  /// FASHION
  ///

  static final fashion = SampleFeedModel(
    name: 'searchSampleFashion'.tr(),
    icon: NovinarkoIcons.fashion,
    feeds: [
      FeedSearchModel(
        title: 'Fashion - ELLE',
        siteName: 'Fashion - ELLE',
        url: 'https://www.elle.com/rss/fashion.xml',
      ),
      FeedSearchModel(
        title: 'Fashionista',
        siteName: 'Fashionista',
        url: 'https://fashionista.com/.rss/excerpt',
      ),
      FeedSearchModel(
        title: 'Refinery29',
        siteName: 'Refinery29',
        description: 'Breaking Car News, Scoops & Reviews',
        url: 'https://www.refinery29.com/fashion/rss.xml',
      ),
    ],
  );

  ///
  /// FOOD
  ///

  static final food = SampleFeedModel(
    name: 'searchSampleFood'.tr(),
    icon: NovinarkoIcons.food,
    feeds: [
      FeedSearchModel(
        title: '101 Cookbooks',
        siteName: '101 Cookbooks',
        description: 'When you own over 100 cookbooks, it is time to stop buying, and start cooking. This site chronicles a cookbook collection, one recipe at a time',
        url: 'https://www.101cookbooks.com/feed',
      ),
      FeedSearchModel(
        title: 'Food52',
        siteName: 'Food52',
        description: 'Eat thoughtfully, live joyfully.',
        url: 'http://feeds.feedburner.com/food52-TheAandMBlog',
      ),
      FeedSearchModel(
        title: 'Love and Olive Oil',
        siteName: 'Love and Olive Oil',
        description: 'Eat to Live. Cook to Love.',
        url: 'https://www.loveandoliveoil.com/feed',
      ),
    ],
  );

  ///
  /// GAMING
  ///

  static final gaming = SampleFeedModel(
    name: 'searchSampleGaming'.tr(),
    icon: NovinarkoIcons.gaming,
    feeds: [
      FeedSearchModel(
        title: 'GameSpot - All Content',
        siteName: 'GameSpot - All Content',
        description: "GameSpot's Everything Feed! All the latest from GameSpot",
        url: 'https://www.gamespot.com/feeds/mashup',
      ),
      FeedSearchModel(
        title: 'IGN All',
        siteName: 'IGN All',
        description: 'The latest IGN news, reviews and videos about video games, movies, TV, tech and comics',
        url: 'http://feeds.ign.com/ign/all',
      ),
      FeedSearchModel(
        title: 'PlayStation.Blog',
        siteName: 'PlayStation.Blog',
        description: 'Official PlayStation Blog for news and video updates on PlayStation, PS5, PS4, PS VR, PlayStation Plus and more.',
        url: 'http://feeds.feedburner.com/psblog',
      ),
    ],
  );

  ///
  /// HISTORY
  ///

  static final history = SampleFeedModel(
    name: 'searchSampleHistory'.tr(),
    icon: NovinarkoIcons.history,
    feeds: [
      FeedSearchModel(
        title: 'The History Reader',
        siteName: 'The History Reader',
        description: "A History Blog from St. Martin's Press",
        url: 'https://www.thehistoryreader.com/feed',
      ),
      FeedSearchModel(
        title: 'Throughline',
        siteName: 'Throughline',
        description:
            'The past is never past. Every headline has a history. Join us every week as we go back in time to understand the present. These are stories you can feel and sounds you can see from the moments that shaped our world.',
        url: 'https://feeds.npr.org/510333/podcast.xml',
      ),
      FeedSearchModel(
        title: 'You Must Remember This',
        siteName: 'You Must Remember This',
        description:
            "You Must Remember This is a storytelling podcast exploring the secret and/or forgotten histories of Hollywood's first century. It's the brainchild and passion project of Karina Longworth (founder of Cinematical.com, former film critic for LA Weekly), who writes, narrates, records and edits each episode. It is a heavily-researched work of creative nonfiction: navigating through conflicting reports, mythology, and institutionalized spin, Karina tries to sort out what really happened behind the films, stars and scandals of the 20th century.",
        url: 'https://feeds.megaphone.fm/YMRT7068253588',
      ),
    ],
  );

  ///
  /// MOVIES
  ///

  static final movies = SampleFeedModel(
    name: 'searchSampleMovies'.tr(),
    icon: NovinarkoIcons.movies,
    feeds: [
      FeedSearchModel(
        title: 'ComingSoon.net',
        siteName: 'ComingSoon.net',
        description: 'New Movies, Movie Trailers, TV, Streaming, Anime & Video Game News',
        url: 'https://www.comingsoon.net/feed',
      ),
      FeedSearchModel(
        title: 'FirstShowing.net',
        siteName: 'FirstShowing.net',
        description: 'Connecting Hollywood with its Audience',
        url: 'https://www.firstshowing.net/feed',
      ),
      FeedSearchModel(
        title: 'Movie News and Discussion',
        siteName: 'Movie News and Discussion',
        description: 'News & Discussion about Major Motion Pictures',
        url: 'https://reddit.com/r/movies/.rss',
      ),
    ],
  );

  ///
  /// MUSIC
  ///

  static final music = SampleFeedModel(
    name: 'searchSampleMusic'.tr(),
    icon: NovinarkoIcons.music,
    feeds: [
      FeedSearchModel(
        title: 'Consequence',
        siteName: 'Consequence',
        description: 'Music, Film, TV and Pop Culture News for the Mainstream and Underground',
        url: 'http://consequenceofsound.net/feed',
      ),
      FeedSearchModel(
        title: 'Music Business Worldwide',
        siteName: 'Music Business Worldwide',
        description: 'News, jobs and analysis for the global music industry',
        url: 'https://www.musicbusinessworldwide.com/feed',
      ),
      FeedSearchModel(
        title: 'Song Exploder',
        siteName: 'Song Exploder',
        description: 'A podcast where musicians take apart their songs, and piece by piece, tell the story of how they were made.',
        url: 'http://songexploder.net/feed',
      ),
    ],
  );

  ///
  /// NEWS
  ///

  static final news = SampleFeedModel(
    name: 'searchSampleNews'.tr(),
    icon: NovinarkoIcons.news,
    feeds: [
      FeedSearchModel(
        title: 'BBC News - World',
        siteName: 'BBC News - World',
        url: 'http://feeds.bbci.co.uk/news/world/rss.xml',
      ),
      FeedSearchModel(
        title: 'NYT > World News',
        siteName: 'NYT > World News',
        url: 'https://rss.nytimes.com/services/xml/rss/nyt/World.xml',
      ),
      FeedSearchModel(
        title: 'World news | The Guardian',
        siteName: 'World news | The Guardian',
        description: "Latest World news news, comment and analysis from the Guardian, the world's leading liberal voice",
        url: 'https://www.theguardian.com/world/rss',
      ),
    ],
  );

  ///
  /// PROGRAMMING
  ///

  static final programming = SampleFeedModel(
    name: 'searchSampleProgramming'.tr(),
    icon: NovinarkoIcons.programming,
    feeds: [
      FeedSearchModel(
        title: 'CodeNewbie',
        siteName: 'CodeNewbie',
        description: 'Stories and interviews from people on their coding journey.',
        url: 'http://feeds.codenewbie.org/cnpodcast.xml',
      ),
      FeedSearchModel(
        title: 'Google Developers Blog',
        siteName: 'Google Developers Blog',
        description: 'Blog of our latest news, updates, and stories for developers',
        url: 'http://feeds.feedburner.com/GDBcode',
      ),
      FeedSearchModel(
        title: 'Programming – The Crazy Programmer',
        siteName: 'Programming – The Crazy Programmer',
        description: 'Programming, Design and Development',
        url: 'https://www.thecrazyprogrammer.com/category/programming/feed',
      ),
    ],
  );

  ///
  /// SPORTS
  ///

  static final sports = SampleFeedModel(
    name: 'searchSampleSports'.tr(),
    icon: NovinarkoIcons.sports,
    feeds: [
      FeedSearchModel(
        title: 'BBC Sport - Sport',
        siteName: 'BBC Sport - Sport',
        url: 'http://feeds.bbci.co.uk/sport/rss.xml',
      ),
      FeedSearchModel(
        title: 'Sports News - Latest Sports and Football News | Sky News',
        siteName: 'Sports News - Latest Sports and Football News | Sky News',
        description: 'The best sports coverage from around the world, covering: Football, Cricket, Golf, Rugby, WWE, Boxing, Tennis and much more.',
        url: 'http://feeds.skynews.com/feeds/rss/sports.xml',
      ),
      FeedSearchModel(
        title: 'www.espn.com - TOP',
        siteName: 'www.espn.com - TOP',
        description: 'Latest TOP news from www.espn.com',
        url: 'https://www.espn.com/espn/rss/news',
      ),
    ],
  );
}
