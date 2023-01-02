import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class OnboardSlider extends StatelessWidget {
  final String image;
  final String text;
  const OnboardSlider({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, height: 30),
        SText(text: text)
      ],
    );
  }
}

List<Widget> onBoardingLists = const [
  OnboardSlider(image: SImages.logo, text: "text"),
  OnboardSlider(image: SImages.logo, text: "text"),
  OnboardSlider(image: SImages.logo, text: "text"),
  OnboardSlider(image: SImages.logo, text: "text")
];