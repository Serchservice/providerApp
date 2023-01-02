import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class STexts{
  static TextStyle authForm(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).scaffoldBackgroundColor,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle normalForm(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle hints(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      color: SColors.hint,
      // color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.bold
    );
  }
}

abstract class Money{
  //For Naira "₦"
  static const nairaHex = "&#x20A6";
  static const nairaDec = "&#8358";

  //For Dollar "$"

  //For Euro "€"
  static const euroHex = "&#x20AC";
  static const euroDec = "&#8364";

  //For Yen "¥"

  //For Pound "£"
  static const poundHex = "&#x00A3";
  static const poundDec = "&#163";
}
