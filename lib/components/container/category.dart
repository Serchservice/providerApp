import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SCategoryButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? radius;
  final VoidCallback? onClick;
  final IconData icon;
  final double size;
  final String text;
  final Color textColor;
  const SCategoryButton({
    super.key, this.width, this.height, this.color = SColors.black, this.padding = const EdgeInsets.all(15),
    this.radius = const BorderRadius.all(Radius.circular(5)), required this.icon, this.size = 40, required this.text,
    this.textColor = SColors.white, this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
        ),
        child: Column(
          children: [
            Icon(icon, color: textColor, size: size),
            const SizedBox(height: 20),
            SText(text: text, color: textColor, size: 18)
          ]
        )
      ),
    );
  }
}