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