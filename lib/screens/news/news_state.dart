import '../../models/novinarko_rss_feed.dart';

sealed class NewsState {}

class NewsStateInitial extends NewsState {}

class NewsStateLoading extends NewsState {
  final String? loadingStatus;

  NewsStateLoading({
    this.loadingStatus,
  });
}

class NewsStateEmpty extends NewsState {}

class NewsStateError extends NewsState {
  final String error;

  NewsStateError({
    required this.error,
  });
}

class NewsStateSingleSuccess extends NewsState {
  final ({NovinarkoRssFeed? rssFeed, String? error}) result;

  NewsStateSingleSuccess({
    required this.result,
  });
}

class NewsStateAllSuccess extends NewsState {
  final ({NovinarkoRssFeed? rssFeed, String? error}) result;

  NewsStateAllSuccess({
    required this.result,
  });
}
