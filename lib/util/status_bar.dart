import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle novinarkoSystemUiOverlayStyle(bool isDark) => SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
  statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
);

SystemUiOverlayStyle novinarkoFeedsSystemUiOverlayStyle(bool isDark) => SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
  statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
);
