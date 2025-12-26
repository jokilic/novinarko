// ignore_for_file: unnecessary_lambdas

import 'package:flutter/foundation.dart';

import '../models/error_model.dart';
import '../models/feed_model.dart';
import '../models/google_search_model.dart';

Future<List<FeedModel>> computeFeedModel(List<dynamic> data) async => compute(parseFeedModel, data);
List<FeedModel> parseFeedModel(List<dynamic> data) => data.map((map) => FeedModel.fromMap(map)).toList();

Future<GoogleSearchItems> computeGoogleSearch(data) async => compute(parseGoogleSearch, data);
GoogleSearchItems parseGoogleSearch(data) => GoogleSearchItems.fromMap(data);

Future<ErrorModel> computeError(data) async => compute(parseError, data);
ErrorModel parseError(data) => ErrorModel.fromMap(data);
