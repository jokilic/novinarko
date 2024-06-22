import 'package:flutter/material.dart';

class NovinarkoTextThemesExtension extends ThemeExtension<NovinarkoTextThemesExtension> {
  final TextStyle newsTitle;
  final TextStyle newsFeedTitle;
  final TextStyle newsDescription;
  final TextStyle newsAppBar;
  final TextStyle newsDateTime;
  final TextStyle feedsNovinarko;
  final TextStyle feedsTitle;
  final TextStyle feedsSubtitle;
  final TextStyle feedsUrl;
  final TextStyle searchTextField;
  final TextStyle searchTitle;
  final TextStyle searchDescription;
  final TextStyle searchUrl;
  final TextStyle iconTextTitle;
  final TextStyle iconTextSubtitle;
  final TextStyle twoLettersAppBar;
  final TextStyle twoLettersDialog;
  final TextStyle loading;
  final TextStyle snackbar;
  final TextStyle appBarTitle;
  final TextStyle floatingActionButtonTitle;
  final TextStyle floatingActionButtonNumber;
  final TextStyle newsFeedInfoText;
  final TextStyle newsFeedInfoTitle;
  final TextStyle newsFeedInfoValue;
  final TextStyle settingsNovinarkoTitle;
  final TextStyle settingsNovinarkoVersion;
  final TextStyle searchCustomDialogButton;

  const NovinarkoTextThemesExtension({
    required this.newsTitle,
    required this.newsFeedTitle,
    required this.newsDescription,
    required this.newsAppBar,
    required this.newsDateTime,
    required this.feedsNovinarko,
    required this.feedsTitle,
    required this.feedsSubtitle,
    required this.feedsUrl,
    required this.searchTextField,
    required this.searchTitle,
    required this.searchDescription,
    required this.searchUrl,
    required this.iconTextTitle,
    required this.iconTextSubtitle,
    required this.twoLettersAppBar,
    required this.twoLettersDialog,
    required this.loading,
    required this.snackbar,
    required this.appBarTitle,
    required this.floatingActionButtonTitle,
    required this.floatingActionButtonNumber,
    required this.newsFeedInfoText,
    required this.newsFeedInfoTitle,
    required this.newsFeedInfoValue,
    required this.settingsNovinarkoTitle,
    required this.settingsNovinarkoVersion,
    required this.searchCustomDialogButton,
  });

  @override
  ThemeExtension<NovinarkoTextThemesExtension> copyWith({
    TextStyle? newsTitle,
    TextStyle? newsFeedTitle,
    TextStyle? newsDescription,
    TextStyle? newsAppBar,
    TextStyle? newsDateTime,
    TextStyle? feedsNovinarko,
    TextStyle? feedsTitle,
    TextStyle? feedsSubtitle,
    TextStyle? feedsUrl,
    TextStyle? searchTextField,
    TextStyle? searchTitle,
    TextStyle? searchDescription,
    TextStyle? searchUrl,
    TextStyle? iconTextTitle,
    TextStyle? iconTextSubtitle,
    TextStyle? twoLettersAppBar,
    TextStyle? twoLettersDialog,
    TextStyle? loading,
    TextStyle? snackbar,
    TextStyle? appBarTitle,
    TextStyle? floatingActionButtonTitle,
    TextStyle? floatingActionButtonNumber,
    TextStyle? newsFeedInfoText,
    TextStyle? newsFeedInfoTitle,
    TextStyle? newsFeedInfoValue,
    TextStyle? settingsNovinarkoTitle,
    TextStyle? settingsNovinarkoVersion,
    TextStyle? searchCustomDialogButton,
  }) =>
      NovinarkoTextThemesExtension(
        newsTitle: newsTitle ?? this.newsTitle,
        newsFeedTitle: newsFeedTitle ?? this.newsFeedTitle,
        newsDescription: newsDescription ?? this.newsDescription,
        newsAppBar: newsAppBar ?? this.newsAppBar,
        newsDateTime: newsDateTime ?? this.newsDateTime,
        feedsNovinarko: feedsNovinarko ?? this.feedsNovinarko,
        feedsTitle: feedsTitle ?? this.feedsTitle,
        feedsSubtitle: feedsSubtitle ?? this.feedsSubtitle,
        feedsUrl: feedsUrl ?? this.feedsUrl,
        searchTextField: searchTextField ?? this.searchTextField,
        searchTitle: searchTitle ?? this.searchTitle,
        searchDescription: searchDescription ?? this.searchDescription,
        searchUrl: searchUrl ?? this.searchUrl,
        iconTextTitle: iconTextTitle ?? this.iconTextTitle,
        iconTextSubtitle: iconTextSubtitle ?? this.iconTextSubtitle,
        twoLettersAppBar: twoLettersAppBar ?? this.twoLettersAppBar,
        twoLettersDialog: twoLettersDialog ?? this.twoLettersDialog,
        loading: loading ?? this.loading,
        snackbar: snackbar ?? this.snackbar,
        appBarTitle: appBarTitle ?? this.appBarTitle,
        floatingActionButtonTitle: floatingActionButtonTitle ?? this.floatingActionButtonTitle,
        floatingActionButtonNumber: floatingActionButtonNumber ?? this.floatingActionButtonNumber,
        newsFeedInfoText: newsFeedInfoText ?? this.newsFeedInfoText,
        newsFeedInfoTitle: newsFeedInfoTitle ?? this.newsFeedInfoTitle,
        newsFeedInfoValue: newsFeedInfoValue ?? this.newsFeedInfoValue,
        settingsNovinarkoTitle: settingsNovinarkoTitle ?? this.settingsNovinarkoTitle,
        settingsNovinarkoVersion: settingsNovinarkoVersion ?? this.settingsNovinarkoVersion,
        searchCustomDialogButton: searchCustomDialogButton ?? this.searchCustomDialogButton,
      );

  @override
  ThemeExtension<NovinarkoTextThemesExtension> lerp(
    covariant ThemeExtension<NovinarkoTextThemesExtension>? other,
    double t,
  ) {
    if (other is! NovinarkoTextThemesExtension) {
      return this;
    }

    return NovinarkoTextThemesExtension(
      newsTitle: TextStyle.lerp(newsTitle, other.newsTitle, t)!,
      newsFeedTitle: TextStyle.lerp(newsFeedTitle, other.newsFeedTitle, t)!,
      newsDescription: TextStyle.lerp(newsDescription, other.newsDescription, t)!,
      newsAppBar: TextStyle.lerp(newsAppBar, other.newsAppBar, t)!,
      newsDateTime: TextStyle.lerp(newsDateTime, other.newsDateTime, t)!,
      feedsNovinarko: TextStyle.lerp(feedsNovinarko, other.feedsNovinarko, t)!,
      feedsTitle: TextStyle.lerp(feedsTitle, other.feedsTitle, t)!,
      feedsSubtitle: TextStyle.lerp(feedsSubtitle, other.feedsSubtitle, t)!,
      feedsUrl: TextStyle.lerp(feedsUrl, other.feedsUrl, t)!,
      searchTextField: TextStyle.lerp(searchTextField, other.searchTextField, t)!,
      searchTitle: TextStyle.lerp(searchTitle, other.searchTitle, t)!,
      searchDescription: TextStyle.lerp(searchDescription, other.searchDescription, t)!,
      searchUrl: TextStyle.lerp(searchUrl, other.searchUrl, t)!,
      iconTextTitle: TextStyle.lerp(iconTextTitle, other.iconTextTitle, t)!,
      iconTextSubtitle: TextStyle.lerp(iconTextSubtitle, other.iconTextSubtitle, t)!,
      twoLettersAppBar: TextStyle.lerp(twoLettersAppBar, other.twoLettersAppBar, t)!,
      twoLettersDialog: TextStyle.lerp(twoLettersDialog, other.twoLettersDialog, t)!,
      loading: TextStyle.lerp(loading, other.loading, t)!,
      snackbar: TextStyle.lerp(snackbar, other.snackbar, t)!,
      appBarTitle: TextStyle.lerp(appBarTitle, other.appBarTitle, t)!,
      floatingActionButtonTitle: TextStyle.lerp(floatingActionButtonTitle, other.floatingActionButtonTitle, t)!,
      floatingActionButtonNumber: TextStyle.lerp(floatingActionButtonNumber, other.floatingActionButtonNumber, t)!,
      newsFeedInfoText: TextStyle.lerp(newsFeedInfoText, other.newsFeedInfoText, t)!,
      newsFeedInfoTitle: TextStyle.lerp(newsFeedInfoTitle, other.newsFeedInfoTitle, t)!,
      newsFeedInfoValue: TextStyle.lerp(newsFeedInfoValue, other.newsFeedInfoValue, t)!,
      settingsNovinarkoTitle: TextStyle.lerp(settingsNovinarkoTitle, other.settingsNovinarkoTitle, t)!,
      settingsNovinarkoVersion: TextStyle.lerp(settingsNovinarkoVersion, other.settingsNovinarkoVersion, t)!,
      searchCustomDialogButton: TextStyle.lerp(searchCustomDialogButton, other.searchCustomDialogButton, t)!,
    );
  }
}
