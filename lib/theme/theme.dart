import 'package:flutter/material.dart';

import 'colors/colors.dart';
import 'colors/extension.dart';
import 'text_styles/extension.dart';
import 'text_styles/text_styles.dart';

class NovinarkoTheme {
  ///
  /// LIGHT
  ///

  static ThemeData get light {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: lightAppColors.background,
      extensions: [
        lightAppColors,
        lightTextTheme,
      ],
    );
  }

  static final lightAppColors = NovinarkoColorsExtension(
    background: NovinarkoColors.white,
    text: NovinarkoColors.dark,
    primary: NovinarkoColors.sepia,
  );

  static final lightTextTheme = NovinarkoTextThemesExtension(
    newsTitle: NovinarkoTextStyles.newsTitle.copyWith(
      color: lightAppColors.text,
    ),
    newsFeedTitle: NovinarkoTextStyles.newsFeedTitle.copyWith(
      color: lightAppColors.text,
    ),
    newsDescription: NovinarkoTextStyles.newsDescription.copyWith(
      color: lightAppColors.text,
    ),
    newsAppBar: NovinarkoTextStyles.newsAppBar.copyWith(
      color: lightAppColors.text,
    ),
    newsDateTime: NovinarkoTextStyles.newsDateTime.copyWith(
      color: lightAppColors.text,
    ),
    feedsNovinarko: NovinarkoTextStyles.feedsNovinarko.copyWith(
      color: lightAppColors.background,
    ),
    feedsTitle: NovinarkoTextStyles.feedsTitle.copyWith(
      color: lightAppColors.background,
    ),
    feedsSubtitle: NovinarkoTextStyles.feedsSubtitle.copyWith(
      color: lightAppColors.background,
    ),
    feedsUrl: NovinarkoTextStyles.feedsUrl.copyWith(
      color: lightAppColors.background,
    ),
    searchTextField: NovinarkoTextStyles.searchTextField.copyWith(
      color: lightAppColors.text,
    ),
    searchTitle: NovinarkoTextStyles.searchTitle.copyWith(
      color: lightAppColors.text,
    ),
    searchDescription: NovinarkoTextStyles.searchDescription.copyWith(
      color: lightAppColors.text,
    ),
    searchUrl: NovinarkoTextStyles.searchUrl.copyWith(
      color: lightAppColors.text,
    ),
    iconTextTitle: NovinarkoTextStyles.iconTextTitle.copyWith(
      color: lightAppColors.text,
    ),
    iconTextSubtitle: NovinarkoTextStyles.iconTextSubtitle.copyWith(
      color: lightAppColors.text,
    ),
    twoLettersAppBar: NovinarkoTextStyles.twoLettersAppBar.copyWith(
      color: lightAppColors.text,
    ),
    twoLettersDialog: NovinarkoTextStyles.twoLettersDialog.copyWith(
      color: lightAppColors.text,
    ),
    loading: NovinarkoTextStyles.loading.copyWith(
      color: lightAppColors.text,
    ),
    snackbar: NovinarkoTextStyles.snackbar.copyWith(
      color: lightAppColors.text,
    ),
    appBarTitle: NovinarkoTextStyles.appBarTitle.copyWith(
      color: lightAppColors.text,
    ),
    floatingActionButtonTitle: NovinarkoTextStyles.floatingActionButtonTitle.copyWith(
      color: lightAppColors.text,
    ),
    floatingActionButtonNumber: NovinarkoTextStyles.floatingActionButtonNumber.copyWith(
      color: lightAppColors.text,
    ),
    newsFeedInfoText: NovinarkoTextStyles.newsFeedInfoText.copyWith(
      color: lightAppColors.text,
    ),
    newsFeedInfoTitle: NovinarkoTextStyles.newsFeedInfoTitle.copyWith(
      color: lightAppColors.text,
    ),
    newsFeedInfoValue: NovinarkoTextStyles.newsFeedInfoValue.copyWith(
      color: lightAppColors.text,
    ),
    settingsNovinarkoTitle: NovinarkoTextStyles.settingsNovinarkoTitle.copyWith(
      color: lightAppColors.text,
    ),
    settingsNovinarkoVersion: NovinarkoTextStyles.settingsNovinarkoVersion.copyWith(
      color: lightAppColors.text,
    ),
  );

  ///
  /// DARK
  ///

  static ThemeData get dark {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: darkAppColors.background,
      extensions: [
        darkAppColors,
        darkTextTheme,
      ],
    );
  }

  static final darkAppColors = NovinarkoColorsExtension(
    background: NovinarkoColors.dark,
    text: NovinarkoColors.white,
    primary: NovinarkoColors.sepia,
  );

  static final darkTextTheme = NovinarkoTextThemesExtension(
    newsTitle: NovinarkoTextStyles.newsTitle.copyWith(
      color: darkAppColors.text,
    ),
    newsFeedTitle: NovinarkoTextStyles.newsFeedTitle.copyWith(
      color: darkAppColors.text,
    ),
    newsDescription: NovinarkoTextStyles.newsDescription.copyWith(
      color: darkAppColors.text,
    ),
    newsAppBar: NovinarkoTextStyles.newsAppBar.copyWith(
      color: darkAppColors.text,
    ),
    newsDateTime: NovinarkoTextStyles.newsDateTime.copyWith(
      color: darkAppColors.text,
    ),
    feedsNovinarko: NovinarkoTextStyles.feedsNovinarko.copyWith(
      color: darkAppColors.background,
    ),
    feedsTitle: NovinarkoTextStyles.feedsTitle.copyWith(
      color: darkAppColors.background,
    ),
    feedsSubtitle: NovinarkoTextStyles.feedsSubtitle.copyWith(
      color: darkAppColors.background,
    ),
    feedsUrl: NovinarkoTextStyles.feedsUrl.copyWith(
      color: darkAppColors.background,
    ),
    searchTextField: NovinarkoTextStyles.searchTextField.copyWith(
      color: darkAppColors.text,
    ),
    searchTitle: NovinarkoTextStyles.searchTitle.copyWith(
      color: darkAppColors.text,
    ),
    searchDescription: NovinarkoTextStyles.searchDescription.copyWith(
      color: darkAppColors.text,
    ),
    searchUrl: NovinarkoTextStyles.searchUrl.copyWith(
      color: darkAppColors.text,
    ),
    iconTextTitle: NovinarkoTextStyles.iconTextTitle.copyWith(
      color: darkAppColors.text,
    ),
    iconTextSubtitle: NovinarkoTextStyles.iconTextSubtitle.copyWith(
      color: darkAppColors.text,
    ),
    twoLettersAppBar: NovinarkoTextStyles.twoLettersAppBar.copyWith(
      color: darkAppColors.text,
    ),
    twoLettersDialog: NovinarkoTextStyles.twoLettersDialog.copyWith(
      color: darkAppColors.text,
    ),
    loading: NovinarkoTextStyles.loading.copyWith(
      color: darkAppColors.text,
    ),
    snackbar: NovinarkoTextStyles.snackbar.copyWith(
      color: darkAppColors.text,
    ),
    appBarTitle: NovinarkoTextStyles.appBarTitle.copyWith(
      color: darkAppColors.text,
    ),
    floatingActionButtonTitle: NovinarkoTextStyles.floatingActionButtonTitle.copyWith(
      color: darkAppColors.text,
    ),
    floatingActionButtonNumber: NovinarkoTextStyles.floatingActionButtonNumber.copyWith(
      color: darkAppColors.text,
    ),
    newsFeedInfoText: NovinarkoTextStyles.newsFeedInfoText.copyWith(
      color: darkAppColors.text,
    ),
    newsFeedInfoTitle: NovinarkoTextStyles.newsFeedInfoTitle.copyWith(
      color: darkAppColors.text,
    ),
    newsFeedInfoValue: NovinarkoTextStyles.newsFeedInfoValue.copyWith(
      color: darkAppColors.text,
    ),
    settingsNovinarkoTitle: NovinarkoTextStyles.settingsNovinarkoTitle.copyWith(
      color: darkAppColors.text,
    ),
    settingsNovinarkoVersion: NovinarkoTextStyles.settingsNovinarkoVersion.copyWith(
      color: darkAppColors.text,
    ),
  );

  ///
  /// SEPIA
  ///

  static ThemeData get sepia {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: sepiaAppColors.background,
      extensions: [
        sepiaAppColors,
        sepiaTextTheme,
      ],
    );
  }

  static final sepiaAppColors = NovinarkoColorsExtension(
    background: NovinarkoColors.sepia,
    text: NovinarkoColors.dark,
    primary: NovinarkoColors.white,
  );

  static final sepiaTextTheme = NovinarkoTextThemesExtension(
    newsTitle: NovinarkoTextStyles.newsTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    newsFeedTitle: NovinarkoTextStyles.newsFeedTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    newsDescription: NovinarkoTextStyles.newsDescription.copyWith(
      color: sepiaAppColors.text,
    ),
    newsAppBar: NovinarkoTextStyles.newsAppBar.copyWith(
      color: sepiaAppColors.text,
    ),
    newsDateTime: NovinarkoTextStyles.newsDateTime.copyWith(
      color: sepiaAppColors.text,
    ),
    feedsNovinarko: NovinarkoTextStyles.feedsNovinarko.copyWith(
      color: sepiaAppColors.background,
    ),
    feedsTitle: NovinarkoTextStyles.feedsTitle.copyWith(
      color: sepiaAppColors.background,
    ),
    feedsSubtitle: NovinarkoTextStyles.feedsSubtitle.copyWith(
      color: sepiaAppColors.background,
    ),
    feedsUrl: NovinarkoTextStyles.feedsUrl.copyWith(
      color: sepiaAppColors.background,
    ),
    searchTextField: NovinarkoTextStyles.searchTextField.copyWith(
      color: sepiaAppColors.text,
    ),
    searchTitle: NovinarkoTextStyles.searchTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    searchDescription: NovinarkoTextStyles.searchDescription.copyWith(
      color: sepiaAppColors.text,
    ),
    searchUrl: NovinarkoTextStyles.searchUrl.copyWith(
      color: sepiaAppColors.text,
    ),
    iconTextTitle: NovinarkoTextStyles.iconTextTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    iconTextSubtitle: NovinarkoTextStyles.iconTextSubtitle.copyWith(
      color: sepiaAppColors.text,
    ),
    twoLettersAppBar: NovinarkoTextStyles.twoLettersAppBar.copyWith(
      color: sepiaAppColors.text,
    ),
    twoLettersDialog: NovinarkoTextStyles.twoLettersDialog.copyWith(
      color: sepiaAppColors.text,
    ),
    loading: NovinarkoTextStyles.loading.copyWith(
      color: sepiaAppColors.text,
    ),
    snackbar: NovinarkoTextStyles.snackbar.copyWith(
      color: sepiaAppColors.text,
    ),
    appBarTitle: NovinarkoTextStyles.appBarTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    floatingActionButtonTitle: NovinarkoTextStyles.floatingActionButtonTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    floatingActionButtonNumber: NovinarkoTextStyles.floatingActionButtonNumber.copyWith(
      color: sepiaAppColors.text,
    ),
    newsFeedInfoText: NovinarkoTextStyles.newsFeedInfoText.copyWith(
      color: sepiaAppColors.text,
    ),
    newsFeedInfoTitle: NovinarkoTextStyles.newsFeedInfoTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    newsFeedInfoValue: NovinarkoTextStyles.newsFeedInfoValue.copyWith(
      color: sepiaAppColors.text,
    ),
    settingsNovinarkoTitle: NovinarkoTextStyles.settingsNovinarkoTitle.copyWith(
      color: sepiaAppColors.text,
    ),
    settingsNovinarkoVersion: NovinarkoTextStyles.settingsNovinarkoVersion.copyWith(
      color: sepiaAppColors.text,
    ),
  );
}

extension NovinarkoThemeExtension on ThemeData {
  NovinarkoColorsExtension get novinarkoColors => extension<NovinarkoColorsExtension>() ?? NovinarkoTheme.lightAppColors;
  NovinarkoTextThemesExtension get novinarkoTextStyles => extension<NovinarkoTextThemesExtension>() ?? NovinarkoTheme.lightTextTheme;
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  NovinarkoColorsExtension get colors => theme.novinarkoColors;
  NovinarkoTextThemesExtension get textStyles => theme.novinarkoTextStyles;
}
