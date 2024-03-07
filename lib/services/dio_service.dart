import 'package:dio/dio.dart';

import 'logger_service.dart';

///
/// Service which holds an instance of `Dio`
/// Used for networking
/// Contains methods that ease our networking logic
///

class DioService {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService loggerService;

  DioService(this.loggerService)

  ///
  /// INIT
  ///

  {
    dio = Dio(
      BaseOptions(
        validateStatus: (_) => true,
      ),
    );

    // ..interceptors.add(
    //     DioLoggerInterceptor(loggerService),
    //   );
  }

  ///
  /// VARIABLES
  ///

  late final Dio dio;
}
