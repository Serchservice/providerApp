import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color buttonColor;
  final Color textColor;
  final double textSize;
  final bool loading;
  final Widget loader;
  final FontWeight textWeight;
  final double borderRadius;
  final BoxBorder? border;
  final VoidCallback? onClick;
  final String text;
  final EdgeInsetsGeometry? padding;
  SButton({
    super.key, this.height, this.width, this.buttonColor = SColors.lightPurple, this.textColor = SColors.white,
    this.textSize = 14, this.loading = false, this.textWeight = FontWeight.normal, this.borderRadius = 8,
    this.border, this.onClick, required this.text, this.padding
  }) : loader = SLoader();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(border: border),
          child: Center(
            child: loading ? loader : SText.center(text: text, color: textColor, size: textSize, weight: textWeight,)
          ),
        )
      ),
    );
  }
}

class SButtonText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color textButtonColor;
  final String textButton;
  final VoidCallback? onClick;
  final double? size;
  final double? spacing;
  final FontWeight? weight;
  const SButtonText({
    super.key, required this.text, this.textColor = SColors.grey, this.textButtonColor = SColors.lightPurple,
    required this.textButton, this.onClick, this.size, this.spacing, this.weight
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 1,
      children: [
        SText(
          text: text,
          size: size ?? 16,
          color: textColor,
          weight: weight ?? FontWeight.w400,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onClick,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing ?? 8.0),
              child: SText(
                text: textButton,
                size: size ?? 16,
                color: textButtonColor,
                weight: FontWeight.w900
              ),
            ),
          ),
        )
      ]
    );
  }
}

class SBtn extends StatelessWidget {
  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final double textSize;
  final bool loading;
  final Widget loader;
  final FontWeight textWeight;
  final double borderRadius;
  final double padH;
  final BoxBorder? border;
  final VoidCallback? onClick;
  final String text;
  SBtn({
    super.key, this.height = 40, this.width = 100, this.buttonColor = SColors.white, this.textColor = SColors.lightPurple,
    this.textSize = 14, this.loading = false, this.textWeight = FontWeight.bold, this.borderRadius = 10,
    this.border, this.onClick, required this.text, this.padH = 10
  }) : loader = SLoader(color: textColor);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: padH),
          decoration: BoxDecoration(
            border: border
          ),
          child: Center(
            child: loading ? loader : SText.center(text: text, color: textColor, size: textSize, weight: textWeight,)
          ),
        )
      ),
    );
  }
}

class SIconTextButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final double radius;
  final void Function()? onClick;
  const SIconTextButton({
    super.key, required this.color, required this.icon, required this.text, this.onClick, this.radius = 30
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: radius,
            child: Icon(
              icon,
              color: SColors.white
            )
          ),
          const SizedBox(height: 5),
          SText(
            text: text,
            size: 14,
            color: Theme.of(context).primaryColor
          )
        ]
      ),
    );
  }
}