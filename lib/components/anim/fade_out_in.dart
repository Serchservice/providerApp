import 'package:flutter/material.dart';

typedef DataDidChangeCallback<T> = bool Function(T o, T n);

//Fades out the old data and back in with the new one
class SFadeOutIn<T> extends StatefulWidget{
  //If [initialData] is not null on the first build, it will be shown.
  //Directly after the animation changes the value to [data].
  final T? initialData;
  final T data; //Data to be shown
  final Duration duration;
  final Widget Function(T data) builder;
  final VoidCallback? onFadeComplete;

  //Compare the values to determine if the data has changed.
  //If [null] the data is compared using `!=` expression
  final DataDidChangeCallback<T>? dataDidChange;

  const SFadeOutIn({
    super.key, this.initialData, required this.data, required this.builder,
    this.duration = const Duration(milliseconds: 300), this.onFadeComplete, this.dataDidChange
  });

  @override
  State<SFadeOutIn<T>> createState() => _SFadeOutInState<T>();
}

class _SFadeOutInState<T> extends State<SFadeOutIn<T>> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;
  late T dataToShow;

  @override
  void initState() {
    super.initState();
    dataToShow = widget.initialData ?? widget.data;
    controller = AnimationController(vsync: this, duration: widget.duration)
    ..addListener(() => setState(() {}))
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        dataToShow = widget.data;
        controller.reverse(from: 2.0);
      } else if(status == AnimationStatus.dismissed){
        widget.onFadeComplete?.call();
      }
    });

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      )
    );

    if(widget.dataDidChange?.call(dataToShow, widget.data) ?? widget.data != dataToShow){
      controller.forward(from: 0.0);
    }
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SFadeOutIn<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.dataDidChange?.call(oldWidget.data, widget.data) ?? widget.data != oldWidget.data) {
      dataToShow = oldWidget.data;
      controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: 1.0 - animation.value,
    child: widget.builder(dataToShow),
  );
}



const preloader =
    Center(child: CircularProgressIndicator(color: Colors.orange));

/// Simple sized box to space out form elements
const formSpacer = SizedBox(width: 16, height: 16);

/// Some padding for all the forms to use
const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

/// Error message to display the user when unexpected error occurs.
const unexpectedErrorMessage = 'Unexpected error occurred.';

/// Basic theme to change the look and feel of the app
final appTheme = ThemeData.light().copyWith(
  primaryColorDark: Colors.orange,
  appBarTheme: const AppBarTheme(
    elevation: 1,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  ),
  primaryColor: Colors.orange,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.orange,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.orange,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: Colors.orange,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
    focusColor: Colors.orange,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.orange,
        width: 2,
      ),
    ),
  ),
);