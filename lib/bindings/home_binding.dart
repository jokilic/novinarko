import 'package:get/get.dart';

import '../screens/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() => Get.put(HomeController());
}
