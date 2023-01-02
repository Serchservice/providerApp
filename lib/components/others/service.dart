// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SServiceContainer extends StatelessWidget {
  final String text;
  final int index;
  final ValueChanged<int> onTap;
  final bool selected;
  const SServiceContainer({
    super.key, required this.text, this.selected = false, required this.onTap, required this.index
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? SColors.blue : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(3),
        ),
        child: SText.center(
          text: text,
          size: 16,
          weight: FontWeight.bold,
          color: selected ? SColors.white : Theme.of(context).primaryColor
        ),
      ),
    );
  }
}

class Stepping extends StatelessWidget {
  final double circleH;
  final double circleW;
  final double lineH;
  final double lineW;
  const Stepping({super.key, this.circleH = 5, this.circleW = 5, this.lineH = 12, this.lineW = 2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: circleH,
          width: circleW,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: SColors.hint
          ),
        ),
        const SizedBox(height: 2),
        Container(
          height: lineH,
          width: lineW,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: SColors.hint
          ),
        ),
        const SizedBox(height: 2),
        Container(
          height: circleH,
          width: circleW,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: SColors.hint
          ),
        ),
      ],
    );
  }
}

