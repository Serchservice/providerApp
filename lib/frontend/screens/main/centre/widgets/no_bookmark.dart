import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SUYesBookmark extends StatelessWidget {
  const SUYesBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      
    );
  }
}

class SUNoBookmark extends StatelessWidget {
  const SUNoBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.tray_2,
            size: 150,
            color: Theme.of(context).disabledColor
          ),
          const SizedBox(height: 10),
          SText(
            text: "You have no bookmark",
            weight: FontWeight.bold,
            size: 18,
            color: Theme.of(context).disabledColor
          )
        ],
      ),
    );
  }
}