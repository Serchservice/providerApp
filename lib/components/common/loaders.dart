import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      icon: Row(
        children: [
          widget,
          const SizedBox(width: 10),
          SText(text: text ?? "Loading...", size: textSize ?? 14, weight: textWeight ?? FontWeight.normal, color: color,),
        ],
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      iconPadding: const EdgeInsets.all(8),
    );
  }
}

showGetSnackbar({
  required String message,
  required Popup type,
  duration = const Duration(seconds: 5),
}) async {
  Get.snackbar(
    getTitle(type),
    message,
    duration: duration,
    snackStyle: SnackStyle.GROUNDED,
    colorText: SColors.white,
    backgroundColor: getColor(type),
    leftBarIndicatorColor: getSideColor(type),
  );
}

/// Set of extension methods to easily display a snackbar
extension ShowSnackBar on BuildContext {
  /// Displays a basic snackbar
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  /// Displays a red snackbar indicating error
  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

showDialogBox({
  required BuildContext context, required String titleText, required String contentText,
  double titleSize = 14, double contentSize = 14, FontWeight titleWeight = FontWeight.bold,
  FontWeight contentWeight = FontWeight.normal, Color color = SColors.white, void Function()? onClick
}) => showCupertinoDialog(
    context: context,
    builder:(context) => StatefulBuilder(
      builder: (context, setState) => CupertinoAlertDialog(
        title: SText(text: titleText, size: titleSize, weight: titleWeight, color: color),
        content: SText(text: contentText, size: contentSize, weight: contentWeight, color: color),
        actions: <Widget>[
          TextButton(
            onPressed: onClick,
            child: SText(text: "Understood", color: color, weight: titleWeight, size: titleSize),
          )
        ],
    )
  )
);