import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class ScheduledBox extends StatelessWidget{
  final UserScheduledListModel user;
  const ScheduledBox({ super.key, required this.user});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 6.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: SColors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight,
            foregroundImage: AssetImage(user.scheduledImage)
          ),
          SText(text: user.scheduledTime, color: SColors.white, size: 14, weight: FontWeight.normal)
        ]
      )
    );
  }
}