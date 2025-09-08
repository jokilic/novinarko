import '../../models/error_model.dart';
import '../../models/feed_search_model.dart';

sealed class SearchState {}

class SearchStateInitial extends SearchState {
  final List<FeedSearchModel> omplFeeds;

  SearchStateInitial({
    required this.omplFeeds,
  });
}

class SearchStateLoading extends SearchState {
  final String? loadingStatus;

  SearchStateLoading({
    this.loadingStatus,
  });
}

class SearchStateEmpty extends SearchState {}

class SearchStateError extends SearchState {
  final ErrorModel? error;
  final String? genericError;

  SearchStateError({
    required this.error,
    required this.genericError,
  });
}

class SearchStateSuccess extends SearchState {
  final List<FeedSearchModel> results;

  SearchStateSuccess({
    required this.results,
  });
}
