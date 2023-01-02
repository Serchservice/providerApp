import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

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

