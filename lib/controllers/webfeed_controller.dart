import 'package:get/get.dart';
import 'package:webfeed/webfeed.dart';

import 'dio_controller.dart';
import 'logger_controller.dart';

class WebFeedController extends GetxController with StateMixin<RssFeed> {
  /// ------------------------
  /// DEPENDENCIES
  /// ------------------------

  final loggerController = Get.find<LoggerController>();

  /// ------------------------
  /// VARIABLES
  /// ------------------------

  final Rx<RssFeed> _rssFeed = RssFeed().obs;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  RssFeed get rssFeed => _rssFeed.value;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set rssFeed(RssFeed value) => _rssFeed.value = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  Future<void> onInit() async {
    super.onInit();
    // final xmlFeed = await getRSSFeed('https://www.24sata.hr/feeds/aktualno.xml');
    final xmlFeed = await getRSSFeed('https://www.index.hr/rss');
    await parseRSSFeed(xmlFeed);
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Fetches the RSS Feed data
  Future<dynamic> getRSSFeed(String feedURL) async {
    final dioController = Get.find<DioController>();

    try {
      final data = await dioController.getURL(feedURL);
      return data;
    } catch (e) {
      loggerController.logger.e('FeedsearchResults Error: $e');
      return null;
    }
  }

  /// Parses the XML data
  Future<void> parseRSSFeed(String xmlFeed) async {
    rssFeed = RssFeed.parse(xmlFeed);
    change(rssFeed, status: RxStatus.success());
  }
}
