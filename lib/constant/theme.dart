import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solbombas/constant/color.dart';

getLightTheme(BuildContext context) => ThemeData(
    scaffoldBackgroundColor: ColorPalette.whiteGray,
    backgroundColor: ColorPalette.white,
    dividerColor: ColorPalette.blackGray.withOpacity(0.5),
    textTheme: GoogleFonts.sourceCodeProTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: ColorPalette.black),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    primaryColor: ColorPalette.primary,
    primaryColorDark: ColorPalette.mainDark,
    errorColor: ColorPalette.red,
    cardColor: ColorPalette.white,
    shadowColor: ColorPalette.blackGray.withOpacity(0.5),
    iconTheme: IconThemeData(color: ColorPalette.black));

getDarkTheme(BuildContext context) => ThemeData(
    scaffoldBackgroundColor: ColorPalette.black,
    backgroundColor: ColorPalette.blackGray,
    dividerColor: ColorPalette.whiteGray.withOpacity(0.5),
    textTheme: GoogleFonts.sourceCodeProTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: ColorPalette.white),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    primaryColor: ColorPalette.primary,
    primaryColorDark: ColorPalette.mainDark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: ColorPalette.primary,
      onPrimary: ColorPalette.white,
      secondary: ColorPalette.secundary,
      onSecondary: ColorPalette.black,
      error: ColorPalette.red,
      onError: ColorPalette.black,
      background: ColorPalette.blackGray,
      onBackground: ColorPalette.white,
      surface: ColorPalette.black,
      onSurface: ColorPalette.white,
    ),
    errorColor: ColorPalette.red,
    cardColor: ColorPalette.blackGray,
    shadowColor: ColorPalette.whiteGray.withOpacity(0.5),
    iconTheme: IconThemeData(color: ColorPalette.white));