import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'alice_controller.dart';
import 'logger_controller.dart';

class NetworkController extends GetxController {
  /// ------------------------
  /// DEPENDENCIES
  /// ------------------------

  final loggerController = Get.find<LoggerController>();

  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final Dio _dio;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  Dio get dio => _dio;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set dio(Dio value) => _dio = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();

    dio = Dio();
    dio.interceptors.add(
      Get.find<AliceController>().alice.getDioInterceptor(),
    );
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

}
