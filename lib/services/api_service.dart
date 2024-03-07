import 'package:dio/dio.dart';

import '../constants.dart';
import '../models/error_model.dart';
import '../models/feed_search_model.dart';
import '../models/google_search_model.dart';
import '../util/env.dart';
import '../util/isolates.dart';
import 'logger_service.dart';

class APIService {
  final LoggerService logger;
  final Dio dio;

  APIService({
    required this.logger,
    required this.dio,
  });

  ///
  /// `feedsearch.dev`
  ///
  Future<({List<FeedSearchModel>? results, ErrorModel? error, String? genericError})> getFeedsearch({required String searchUrl}) async {
    try {
      final response = await dio.get(
        Env.feedSearchUrl,
        queryParameters: {
          'url': searchUrl,
          'favicon': true,
        },
      );

      /// Status code is `200`, response is successful
      if (response.statusCode == 200) {
        try {
          final parsedResults = await computeFeedsearch(response.data);
          return (results: parsedResults, error: null, genericError: null);
        } catch (e) {
          return (results: <FeedSearchModel>[], error: null, genericError: null);
        }
      }

      /// Status code starts with a `4`, response is successful but has an error
      if ((response.statusCode ?? 0) ~/ 100 == 4) {
        final parsedError = await computeError(response.data);
        logger.e(parsedError);
        return (results: null, error: parsedError, genericError: null);
      }

      /// Response is not successful
      else {
        final error = 'API -> getFeedsearch -> StatusCode ${response.statusCode} -> Generic error';
        logger.e(error);
        return (results: null, error: null, genericError: error);
      }
    } catch (e) {
      final error = 'API -> getFeedsearch -> catch -> $e';
      logger.e(error);
      return (results: null, error: null, genericError: error);
    }
  }

  ///
  /// `Google Search`
  ///
  Future<({GoogleSearchModel? result, String? error})> getGoogleSearch({required String searchValue}) async {
    try {
      final response = await dio.get(
        Env.googleSearchUrl,
        queryParameters: {
          'key': NovinarkoConstants.googleSearchAPIKey,
          'cx': NovinarkoConstants.programmableSearchEngineID,
          'q': searchValue,
        },
      );

      /// Status code is `200`, response is successful
      if (response.statusCode == 200) {
        final parsedResults = await computeGoogleSearch(response.data);
        return (result: parsedResults.items.first, error: null);
      }

      /// Response is not successful
      else {
        final error = 'API -> getGoogleSearch -> StatusCode ${response.statusCode} -> Generic error';
        logger.e(error);
        return (result: null, error: error);
      }
    } catch (e) {
      final error = 'API -> getGoogleSearch -> catch -> $e';
      logger.e(error);
      return (result: null, error: error);
    }
  }

  ///
  /// RSS feed
  ///
  Future<({dynamic data, String? error})> getRSSFeed({required String url}) async {
    try {
      final response = await dio.get(url);

      /// Status code is `200`, response is successful
      if (response.statusCode == 200) {
        return (data: response.data, error: null);
      }

      /// Response is not successful
      else {
        final error = 'API -> getRSSFeed -> StatusCode ${response.statusCode} -> Generic error';
        logger.e(error);
        return (data: null, error: error);
      }
    } catch (e) {
      final error = 'API -> getRSSFeed -> catch -> $e';
      logger.e(error);
      return (data: null, error: error);
    }
  }
}
