import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SlideCollapsed extends StatefulWidget {
  final bool onTrip;
  const SlideCollapsed({super.key, this.onTrip = false});

  @override
  State<SlideCollapsed> createState() => _SlideCollapsedState();
}

class _SlideCollapsedState extends State<SlideCollapsed> {
  final padded = const EdgeInsets.symmetric(vertical: 1);
  final padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 10);

  final person = "Evaristus Adimonyemma";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: padded,
          child: Container(
            color: SColors.hint,
            height: 4,
            width: 100,
          ),
        ),
        widget.onTrip ? SFadeOutIn<String>(
          initialData: statements(),
          data: "You are on a service trip with $person",
          builder: (data) => Padding(
            padding: padding,
            child: SText.center(text: data, color: Theme.of(context).primaryColor, size: 16),
          ),
          duration: const Duration(milliseconds: 1800),
        )
        : Padding(
          padding: padding,
          child: SText.center(
            text: statements(),
            color: Theme.of(context).primaryColor,
            size: 16,
            weight: FontWeight.w600
          )
        ),
      ],
    );
  }
}