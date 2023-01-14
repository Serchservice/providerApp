import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class OnboardSlider extends StatelessWidget {
  final OnboardModel model;
  const OnboardSlider({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(model.image, height: 30),
        SText(text: model.text)
      ],
    );
  }
}

class OnboardModel{
  final String image;
  final String text;

  OnboardModel({required this.image, required this.text});
}