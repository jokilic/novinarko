import 'package:flutter/material.dart';

import 'models/novinarko_rss_item.dart';
import 'screens/feeds/feeds_screen.dart';
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

/// Opens [ReadWebView]
void openRead(
  BuildContext context, {
  required List<NovinarkoRssItem> items,
}) =>
    pushScreen(
      ReadScreen(
        items: items,
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
