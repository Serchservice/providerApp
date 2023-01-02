import 'package:flutter/material.dart';

abstract class SColors{
  ///Set of constant colors used for the UI layout of the app.
  ///
  ///It comprises of both colors used in the light and dark theme of the UI
  static const white = Colors.white;
  static const black = Colors.black;

  static const light = Color(0xFFA1A1A1);
  static const dark = Color(0xFF0E0E0E);

  ///Secondary Colors
  static const lightPurp = Color(0xff3B043B);
  static const darkPurp = Color(0xFF740274);

  static const lightPurple = Color(0xff6C0062);
  static const darkPurple = Color(0xff3F0F36);

  ///Dark Colors
  static const darkTheme = Colors.black;
  static const darkTheme1 = Color(0xff0A0A0A);
  static const darkTheme2 = Color(0xff1A1A1A);
  static const darkTheme3 = Color(0xff2E2E2E);
  static const darkTheme4 = Color(0xff424242);

  ///Light Colors
  static const lightTheme = Colors.white;
  static const lightTheme1 = Color(0xffFDFDFD);
  static const lightTheme2 = Color(0xffF0F0F0);
  static const lightTheme3 = Color(0xffD5D5D5);
  static const lightTheme4 = Color(0xffBCBCBC);

  static const disabledLight = Color(0xFFB3B3B3);
  static const disabledDark = Color(0xFF696969);
  static const lightColor = Color(0xFFF6F6F6);
  static const darkColor = Color(0xFF0A0A0A);
  static const lighter = Color(0xFFACACAC);
  static const darker = Color(0xFF0A0A0A);
  static const green = Color(0xff03B800);
  static const red = Color(0xffB80000);
  static const yellow = Color(0xffBC5505);
  static const rate = Color(0xffFDCC0D);
  static const shimmerBase = Color.fromARGB(255, 71, 71, 71);
  static const shimmerHigh = Color.fromARGB(255, 64, 64, 64);
  static const shimmer = Color(0xFF111111);
  static const grey = Color(0xff383838);
  static const enabledBorderLight = Color(0xFFDADADA);
  static const enabledBorderDark = Color.fromARGB(255, 16, 16, 16);
  static const hint = Color(0xFF8C8C8C);
  static const blue = Color(0xFF000870);
  static const aries = Color(0xffb80000);
  static const libra = Color(0xffb8006b);
  static const aqua = Color(0xff0009b8);
  static const virgo = Color(0xff2c0f0c);
}

abstract class Scolors{
  ///Others
  static const blacked = Color(0xff1f2937);
  static const error = Color(0xffff3b3b);
  static const info = Color(0xff0063f7);
  static const info2 = Color(0xffAAAAAA);
  static const info3 = Color(0xff5BC0DE);
  static const warning = Color(0xffffcc00);
  static const success = Color(0xff06c270);

  static const gold = Color(0xffFFD700);
  static const bronze = Color(0xffCD7F32);
  static const silver = Color(0xffC0C0C0);
}