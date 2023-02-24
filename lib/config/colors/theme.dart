import 'package:flutter/material.dart';
import 'package:provide/lib.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class STheme{
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  static ThemeData light() => ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    visualDensity: visualDensity,
    textTheme: GoogleFonts.ubuntuTextTheme().apply(bodyColor: SColors.black),
    scaffoldBackgroundColor: SColors.lightTheme,
    iconTheme: const IconThemeData(color: SColors.light),
    bottomAppBarColor: SColors.lightColor,
    appBarTheme: const AppBarTheme(color: SColors.lightColor),
    primaryColor: SColors.darkTheme,
    hoverColor: SColors.dark,
    canvasColor: SColors.black,
    focusColor: SColors.darkTheme1,
    secondaryHeaderColor: SColors.darkTheme2,
    shadowColor: SColors.darkTheme3,
    primaryColorLight: SColors.darkTheme4,

    primaryColorDark: SColors.lightPurple,
    cardColor: SColors.darker,
    backgroundColor: SColors.lightTheme2,
    disabledColor: SColors.disabledLight,
    indicatorColor: SColors.blue
  );

  static ThemeData dark() => ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    visualDensity: visualDensity,
    textTheme: GoogleFonts.dmSansTextTheme().apply(bodyColor: SColors.white),
    scaffoldBackgroundColor: SColors.darkTheme1,
    iconTheme: const IconThemeData(color: SColors.dark),
    bottomAppBarColor: SColors.darked,
    appBarTheme: const AppBarTheme(color: SColors.darked),
    primaryColor: SColors.lightTheme,
    hoverColor: SColors.light,
    canvasColor: SColors.white,
    focusColor: SColors.lightTheme1,
    secondaryHeaderColor: SColors.lightTheme2,
    shadowColor: SColors.lightTheme3,
    primaryColorLight: SColors.lightTheme4,

    primaryColorDark: SColors.lightPurp,
    cardColor: SColors.enabledBorderDark,
    backgroundColor: SColors.darkTheme2,
    disabledColor: SColors.disabledDark,
    indicatorColor: SColors.aqua
  );
}