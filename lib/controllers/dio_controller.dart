import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'alice_controller.dart';
import 'logger_controller.dart';

class DioController extends GetxController {
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

  Future<dynamic> getURL(String url) async {
    try {
      final response = await dio.get(url);
      final data = response.data;

      loggerController.logger.i(data);
      return data;
    } catch (e) {
      loggerController.logger.e('$url\nGET\n$e');
      return null;
    }
  }
}
