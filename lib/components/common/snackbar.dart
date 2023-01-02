import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

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

