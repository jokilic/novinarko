import 'package:get/get.dart';

import '../controllers/feedsearch_controller.dart';
import '../controllers/webfeed_controller.dart';
import '../screens/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() => Get
    ..put(HomeController())
    ..put(FeedsearchController())
    ..put(WebFeedController());
}
