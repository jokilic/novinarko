import 'package:flutter/material.dart';

import 'screens/feeds/feeds_screen.dart';
import 'screens/search/search_screen.dart';
import 'util/navigation.dart';

/// Opens [FeedsScreen]
void openFeeds(BuildContext context) => pushScreen(
      FeedsScreen(),
      context: context,
      isCircularTransition: true,
    );

/// Opens [SearchScreen]
void openSearch(BuildContext context) => pushScreen(
      SearchScreen(),
      context: context,
    );
