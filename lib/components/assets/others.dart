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
  final bool? wrap;
  final TextDecoration? decoration;
  const SText({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal,
    this.align = TextAlign.left, this.color = SColors.white, this.flow, this.style = FontStyle.normal, this.decoration, this.wrap
  });
  const SText.justify({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.color = SColors.white, this.flow,
    this.style = FontStyle.normal, this.decoration, this.wrap
  }) : align = TextAlign.justify;
  const SText.right({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.color = SColors.white, this.flow,
    this.style = FontStyle.normal, this.decoration, this.wrap
  }) : align = TextAlign.right;
  const SText.center({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.color = SColors.white, this.flow,
    this.style = FontStyle.normal, this.decoration, this.wrap
  }) : align = TextAlign.center;
  const SText.theme({
    super.key, required this.text, this.size = 14, this.weight = FontWeight.normal, this.align = TextAlign.center, required this.color,
    this.flow, this.style = FontStyle.normal, this.decoration, this.wrap
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: flow,
      softWrap: wrap,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        decoration: decoration,
      ),
    );
  }
}

class SIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? boxColor;
  final BorderRadiusGeometry? radius;
  final Color iconColor;
  const SIcon({
    super.key, required this.icon, this.size = 26, this.boxColor, this.iconColor = SColors.black, this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: radius
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size
      ),
    );
  }
}

class SIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? boxColor;
  final Color iconColor;
  final VoidCallback? onClick;
  const SIconButton({
    super.key, required this.icon, this.size = 26, this.boxColor = SColors.green,
    this.iconColor = SColors.white, this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size
        ),
      ),
    );
  }
}

class SIB extends StatelessWidget {
  final void Function()? onClick;
  final IconData icon;
  final double size;
  final Color color;
  const SIB({super.key, this.onClick, required this.icon, this.size = 32, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        child: Icon(
          icon,
          size: size,
          color: color
        )
      )
    );
  }
}