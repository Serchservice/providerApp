import 'package:flutter/cupertino.dart';
import 'package:provide/lib.dart';

enum MediaExtensions{
  mp4,
  mp3,
  gif,
  zip,
  jpg,
  png,
  mkv,
  mpeg,
  pdf,
  doc,
}

Color getExtensionColor(extension){
  switch (extension) {
    case MediaExtensions.doc:
      return SColors.blue;
    case MediaExtensions.gif:
      return SColors.aries;
    case MediaExtensions.jpg:
      return SColors.yellow;
    case MediaExtensions.zip:
      return SColors.virgo;
    case MediaExtensions.mp3:
      return SColors.aqua;
    case MediaExtensions.mp4:
      return SColors.libra;
    case MediaExtensions.png:
      return Scolors.info2;
    case MediaExtensions.mkv:
      return Scolors.error;
    case MediaExtensions.mpeg:
      return Scolors.info3;
    case MediaExtensions.pdf:
      return Scolors.gold;
    default:
    return SColors.lightPurple;
  }
}