import 'package:flutter/material.dart';

import 'screens/feeds/feeds_screen.dart';
import 'screens/info/info_screen.dart';
import 'screens/read/read_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'util/navigation.dart';

/// Opens [FeedsScreen]
void openFeeds(BuildContext context) => pushScreen(
      FeedsScreen(),
      context: context,
      isCircularTransition: true,
    );

/// Opens [ReadScreen]
void openRead(
  BuildContext context, {
  required String? url,
  required Color backgroundColor,
}) =>
    pushScreen(
      ReadScreen(
        url: url,
        backgroundColor: backgroundColor,
      ),
      context: context,
    );

/// Opens [SearchScreen]
void openSearch(BuildContext context) => pushScreen(
      SearchScreen(),
      context: context,
    );

/// Opens [SettingsScreen]
void openSettings(BuildContext context) => pushScreen(
      SettingsScreen(),
      context: context,
    );

/// Opens [InfoScreen]
void openInfo(BuildContext context) => pushScreen(
      InfoScreen(),
      context: context,
    );
