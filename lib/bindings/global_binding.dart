import 'package:get/get.dart';

import '../controllers/network_controller.dart';
import '../controllers/storage_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() => Get
    ..put(StorageController())
    ..put(NetworkController());
}
