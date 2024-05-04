import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_color.dart';
import 'constants/textstyles/dark_text_styles.dart';
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: kprimaryBlack,
    onPrimary: kprimaryBlack,
    secondary: ksecodaryBlue,
    onSecondary: ksecodaryBlue,
    error: Colors.red,
    onError: Colors.red,
    background: kBlackColor,
    onBackground: kBlackColor,
    surface: kWhiteColor,
    onSurface: kWhiteColor,
  ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: kDarkDisplayLarge,
        headlineLarge: kDarkHeadingLarge,
        titleLarge: kDarkTitleLarge,
        labelLarge: kDarkLabelLarge,
        bodyLarge: kDarkBodyLarge,
    )
);
