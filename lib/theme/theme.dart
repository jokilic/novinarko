import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: lightAppColors.primary,
        cursorColor: lightAppColors.primary,
        selectionHandleColor: lightAppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
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

  static final lightTextTheme = getTextThemesExtension(
    colorsExtension: lightAppColors,
  );

  ///
  /// DARK
  ///

  static ThemeData get dark {
    final base = ThemeData.dark();

    return base.copyWith(
      scaffoldBackgroundColor: darkAppColors.background,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: darkAppColors.primary,
        cursorColor: darkAppColors.primary,
        selectionHandleColor: darkAppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
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

  static final darkTextTheme = getTextThemesExtension(
    colorsExtension: darkAppColors,
  );

  ///
  /// SEPIA
  ///

  static ThemeData get sepia {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: sepiaAppColors.background,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: sepiaAppColors.primary,
        cursorColor: sepiaAppColors.primary,
        selectionHandleColor: sepiaAppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
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

  static final sepiaTextTheme = getTextThemesExtension(
    colorsExtension: sepiaAppColors,
  );

  ///
  /// GREEN
  ///

  static ThemeData get green {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: greenAppColors.background,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: greenAppColors.primary,
        cursorColor: greenAppColors.primary,
        selectionHandleColor: greenAppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      extensions: [
        greenAppColors,
        greenTextTheme,
      ],
    );
  }

  static final greenAppColors = NovinarkoColorsExtension(
    background: NovinarkoColors.green,
    text: NovinarkoColors.white,
    primary: NovinarkoColors.sepia,
  );

  static final greenTextTheme = getTextThemesExtension(
    colorsExtension: greenAppColors,
  );

  ///
  /// BURGUNDY
  ///

  static ThemeData get burgundy {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: burgundyAppColors.background,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: burgundyAppColors.primary,
        cursorColor: burgundyAppColors.primary,
        selectionHandleColor: burgundyAppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      extensions: [
        burgundyAppColors,
        burgundyTextTheme,
      ],
    );
  }

  static final burgundyAppColors = NovinarkoColorsExtension(
    background: NovinarkoColors.burgundy,
    text: NovinarkoColors.white,
    primary: NovinarkoColors.sepia,
  );

  static final burgundyTextTheme = getTextThemesExtension(
    colorsExtension: burgundyAppColors,
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

NovinarkoTextThemesExtension getTextThemesExtension({
  required NovinarkoColorsExtension colorsExtension,
}) => NovinarkoTextThemesExtension(
  newsTitle: NovinarkoTextStyles.newsTitle.copyWith(
    color: colorsExtension.text,
  ),
  newsDescription: NovinarkoTextStyles.newsDescription.copyWith(
    color: colorsExtension.text,
  ),
  newsAppBar: NovinarkoTextStyles.newsAppBar.copyWith(
    color: colorsExtension.text,
  ),
  newsDateTime: NovinarkoTextStyles.newsDateTime.copyWith(
    color: colorsExtension.text,
  ),
  feedsTitle: NovinarkoTextStyles.feedsTitle.copyWith(
    color: colorsExtension.background,
  ),
  feedsSubtitle: NovinarkoTextStyles.feedsSubtitle.copyWith(
    color: colorsExtension.background,
  ),
  feedsUrl: NovinarkoTextStyles.feedsUrl.copyWith(
    color: colorsExtension.background,
  ),
  searchTextField: NovinarkoTextStyles.searchTextField.copyWith(
    color: colorsExtension.text,
  ),
  searchTitle: NovinarkoTextStyles.searchTitle.copyWith(
    color: colorsExtension.text,
  ),
  searchDescription: NovinarkoTextStyles.searchDescription.copyWith(
    color: colorsExtension.text,
  ),
  searchUrl: NovinarkoTextStyles.searchUrl.copyWith(
    color: colorsExtension.text,
  ),
  searchSampleTitle: NovinarkoTextStyles.searchSampleTitle.copyWith(
    color: colorsExtension.text,
  ),
  iconTextTitle: NovinarkoTextStyles.iconTextTitle.copyWith(
    color: colorsExtension.text,
  ),
  iconTextSubtitle: NovinarkoTextStyles.iconTextSubtitle.copyWith(
    color: colorsExtension.text,
  ),
  twoLettersAppBar: NovinarkoTextStyles.twoLettersAppBar.copyWith(
    color: colorsExtension.text,
  ),
  twoLettersDialog: NovinarkoTextStyles.twoLettersDialog.copyWith(
    color: colorsExtension.text,
  ),
  loading: NovinarkoTextStyles.loading.copyWith(
    color: colorsExtension.text,
  ),
  snackbar: NovinarkoTextStyles.snackbar.copyWith(
    color: colorsExtension.text,
  ),
  appBarTitle: NovinarkoTextStyles.appBarTitle.copyWith(
    color: colorsExtension.text,
  ),
  floatingActionButtonTitle: NovinarkoTextStyles.floatingActionButtonTitle.copyWith(
    color: colorsExtension.text,
  ),
  floatingActionButtonNumber: NovinarkoTextStyles.floatingActionButtonNumber.copyWith(
    color: colorsExtension.text,
  ),
  newsFeedInfoText: NovinarkoTextStyles.newsFeedInfoText.copyWith(
    color: colorsExtension.text,
  ),
  newsFeedInfoTitle: NovinarkoTextStyles.newsFeedInfoTitle.copyWith(
    color: colorsExtension.text,
  ),
  newsFeedInfoValue: NovinarkoTextStyles.newsFeedInfoValue.copyWith(
    color: colorsExtension.text,
  ),
  settingsNovinarkoTitle: NovinarkoTextStyles.settingsNovinarkoTitle.copyWith(
    color: colorsExtension.text,
  ),
  settingsNovinarkoVersion: NovinarkoTextStyles.settingsNovinarkoVersion.copyWith(
    color: colorsExtension.text,
  ),
  searchCustomDialogButton: NovinarkoTextStyles.searchCustomDialogButton.copyWith(
    color: colorsExtension.text,
  ),
  readAddressBar: NovinarkoTextStyles.readAddressBar.copyWith(
    color: colorsExtension.text,
  ),
  settingsFont: NovinarkoTextStyles.settingsFont.copyWith(
    color: colorsExtension.text,
  ),
);
