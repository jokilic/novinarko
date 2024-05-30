import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../constants.dart';
import '../../models/error_model.dart';
import '../../models/feed_search_model.dart';
import '../../models/google_search_model.dart';
import '../../services/active_feed_service.dart';
import '../../services/api_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import 'search_state.dart';

class SearchController extends ValueNotifier<SearchState> implements Disposable {
  final LoggerService logger;
  final APIService api;
  final HiveService hive;
  final ActiveFeedService activeFeedService;

  SearchController({
    required this.logger,
    required this.api,
    required this.hive,
    required this.activeFeedService,
  }) : super(SearchStateInitial());

  ///
  /// VARIABLES
  ///

  late final textController = TextEditingController();

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() => textController.dispose();

  ///
  /// METHODS
  ///

  Future<void> searchTriggered(String searchValue) async {
    /// Nothing is typed, exit
    if (searchValue.isEmpty) {
      return;
    }

    /// Check if `searchUrl` is URL
    final isURL = NovinarkoConstants.urlRegExp.hasMatch(searchValue);

    /// Trigger feed search
    if (isURL) {
      /// Loading state
      value = SearchStateLoading(
        loadingStatus: 'searchStateLoadingFeeds'.tr(),
      );

      final feeds = await getFeedsearch(searchValue);

      if (feeds.results != null) {
        /// Update state with response
        value = feeds.results!.isEmpty
            ? SearchStateEmpty()
            : SearchStateSuccess(
                results: feeds.results!,
              );
      }

      if (feeds.error != null || feeds.genericError != null) {
        /// Update state with error
        value = SearchStateError(
          error: feeds.error,
          genericError: feeds.genericError,
        );
      }
    }

    /// Generate URL by searching Google
    /// Then trigger feed search
    else {
      /// Loading state
      value = SearchStateLoading(
        loadingStatus: 'searchStateLoadingFeeds'.tr(),
      );

      final search = await getWebsiteFromGoogleSearch(searchValue);

      /// Search returned URL
      if (search.result != null && search.error == null) {
        final feeds = await getFeedsearch(search.result!.link);

        if (feeds.results != null) {
          /// Update state with response
          value = feeds.results!.isEmpty
              ? SearchStateEmpty()
              : SearchStateSuccess(
                  results: feeds.results!,
                );
        }

        if (feeds.error != null || feeds.genericError != null) {
          /// Update state with error
          value = SearchStateError(
            error: feeds.error,
            genericError: feeds.genericError,
          );
        }
      }

      /// Search didn't find anything
      else {
        final error = 'searchStateErrorGoogle'.tr();

        /// Update state with error
        value = SearchStateError(
          error: null,
          genericError: search.error ?? error,
        );
      }
    }
  }

  Future<({GoogleSearchModel? result, String? error})> getWebsiteFromGoogleSearch(String searchValue) async {
    final response = await api.getGoogleSearch(searchValue: searchValue);
    return response;
  }

  Future<({List<FeedSearchModel>? results, ErrorModel? error, String? genericError})> getFeedsearch(String searchUrl) async {
    final response = await api.getFeedsearch(searchUrl: searchUrl);
    return response;
  }
}
