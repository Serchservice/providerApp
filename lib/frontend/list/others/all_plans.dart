import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SerchPlan {
  final String planName;
  final String planImage;
  final List<String> content;
  final String duration;
  final String price;
  final SerchPlans value;
  final Color bgColor;

  SerchPlan({
    required this.planName,
    required this.planImage,
    required this.content,
    required this.duration,
    required this.price,
    required this.value,
    required this.bgColor
  });
}

enum SerchPlans{
  serchFree,
  serchAllDay,
  serchPremium,
}

final serchFree = [
  "Profile check",
  "Tip2fix",
  "RequestShare",
  "SWM security",
  "Service scheduling",
];

final serchAllDay = [
  "Everything in free trial plan",
  "Rating summary",
  "Account report download",
];

final serchPremium = [
  "Everything in all day plan",
  "See who bookmarked you",
  "See who rated you and rate comment",
  "Certificate Generation/Download"
];

final serchPlans = [
  SerchPlan(
    planName: "Free Trial",
    planImage: SImages.serchFree,
    content: serchFree,
    duration: "14 days free",
    price: "No fees, no charge",
    value: SerchPlans.serchFree,
    bgColor: SColors.aries
  ),
  SerchPlan(
    planName: "All Day",
    planImage: SImages.serchAllDay,
    content: serchAllDay,
    duration: "1 month recurring billing",
    price: "3000",
    value: SerchPlans.serchAllDay,
    bgColor: SColors.aqua
  ),
  SerchPlan(
    planName: "Premium",
    planImage: SImages.serchPremium,
    content: serchPremium,
    duration: "1 month recurring billing",
    price: "15000",
    value: SerchPlans.serchPremium,
    bgColor: SColors.libra
  ),
];


