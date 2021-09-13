import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/colors.dart';

final theme = ThemeData(
  primaryColor: MyColors.white,
  scaffoldBackgroundColor: MyColors.white,
  textTheme: GoogleFonts.martelTextTheme().copyWith(
    headline1: GoogleFonts.martel(
      fontSize: 28,
      color: MyColors.black,
      fontWeight: FontWeight.w900,
    ),
    bodyText1: GoogleFonts.martel(
      fontSize: 20,
      color: MyColors.black,
      fontWeight: FontWeight.w900,
      height: 1.8,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
