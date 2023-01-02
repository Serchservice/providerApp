import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

List<Widget> rating = const [
  SummaryRatingScreen(),
  GoodRatingScreen(),
  BadRatingScreen()
];

int ratingCount = rating.length;

List<Widget> files = const [
  AllFilesScreen(),
  DocFilesScreen(),
  ImageFilesScreen(),
  VideoFilesScreen()
];

int filesCount = files.length;