import 'package:get/get.dart';

import '../models/feedsearch_response.dart';
import 'dio_controller.dart';
import 'logger_controller.dart';

class FeedsearchController extends GetxController with StateMixin<List<FeedsearchResponse>> {
  /// ------------------------
  /// DEPENDENCIES
  /// ------------------------

  final loggerController = Get.find<LoggerController>();

  /// ------------------------
  /// VARIABLES
  /// ------------------------

  final String feedsearchURL = 'https://feedsearch.dev/api/v1/search';
  final RxList<FeedsearchResponse> _feedsearchList = <FeedsearchResponse>[].obs;
  final RxString _chosenURL = ''.obs;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  String get feedsearchEndpoint => '$feedsearchURL?url=$chosenURL';
  String get chosenURL => _chosenURL.value;
  List<FeedsearchResponse> get feedsearchList => _feedsearchList;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set chosenURL(String value) => _chosenURL.value = value;
  set feedsearchList(List<FeedsearchResponse> value) => _feedsearchList.assignAll(value);

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Fetches data from Feedsearch
  Future<void> getFeedsearchResults() async {
    final dioController = Get.find<DioController>();

    try {
      change(null, status: RxStatus.loading());

      final data = await dioController.getURL(feedsearchEndpoint) as List<dynamic>;
      feedsearchList = data.map((element) => FeedsearchResponse.fromJson(element)).toList();
      loggerController.logger.wtf(feedsearchList);

      change(feedsearchList, status: RxStatus.success());
    } catch (e) {
      loggerController.logger.e('FeedsearchResults Error: $e');
      change(null, status: RxStatus.error('$e'));
    }
  }
}
