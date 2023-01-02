import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SUNoReferral extends StatelessWidget {
  const SUNoReferral({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.tree,
            size: 150,
            color: Theme.of(context).disabledColor
          ),
          const SizedBox(height: 10),
          SText(
            text: "You have no referral family",
            weight: FontWeight.bold,
            size: 18,
            color: Theme.of(context).disabledColor
          )
        ],
      ),
    );
  }
}