import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SText extends StatelessWidget {
  final double size;
  final String text;
  final FontWeight weight;
  final TextAlign align;
  final FontStyle style;
  final TextOverflow? flow;
  final Color color;
  const SText({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal,
    this.align = TextAlign.left, this.color = SColors.white, this.flow, this.style = FontStyle.normal
  });
  const SText.justify({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.color = SColors.white, this.flow,
    this.style = FontStyle.normal
  }) : align = TextAlign.justify;
  const SText.right({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.color = SColors.white, this.flow,
    this.style = FontStyle.normal
  }) : align = TextAlign.right;
  const SText.center({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.color = SColors.white, this.flow,
    this.style = FontStyle.normal
  }) : align = TextAlign.center;
  const SText.theme({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.align = TextAlign.center, required this.color,
    this.flow, this.style = FontStyle.normal
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: flow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
      ),
    );
  }
}