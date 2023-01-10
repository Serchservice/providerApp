import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provide/lib.dart';

class SLoader extends StatelessWidget {
  final Widget widget;
  final Color color;
  final double size;
  SLoader({
    super.key, this.color = SColors.white, this.size = 24}) : widget = LoadingAnimationWidget.inkDrop(color: color, size: size);
  SLoader.beat({
    super.key, this.color = SColors.white, this.size = 24}) : widget = LoadingAnimationWidget.beat(color: color, size: size);
  SLoader.fallingDot({
    super.key, this.color = SColors.white, this.size = 24}) : widget = LoadingAnimationWidget.fallingDot(color: color, size: size);

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}

class AlertLoader extends StatelessWidget {
  final Widget widget;
  final String? text;
  final double? textSize;
  final FontWeight? textWeight;
  final Color color;
  final Color? backgroundColor;
  final double size;
  AlertLoader({
    super.key, this.color = SColors.white, this.size = 24, this.text, this.textSize, this.textWeight, this.backgroundColor
  }) : widget = LoadingAnimationWidget.inkDrop(color: color, size: size);
  AlertLoader.beat({
    super.key, this.color = SColors.white, this.size = 24, this.text, this.textSize, this.textWeight, this.backgroundColor
  }) : widget = LoadingAnimationWidget.beat(color: color, size: size);
  AlertLoader.fallingDot({
    super.key, this.color = SColors.white, this.size = 24, this.text, this.textSize, this.textWeight, this.backgroundColor
  }) : widget = LoadingAnimationWidget.fallingDot(color: color, size: size);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: widget,
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      title: SText(text: text ?? "Loading...", size: textSize ?? 14, weight: textWeight ?? FontWeight.normal,),
    );
  }
}