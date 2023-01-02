import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class MissedCallHistoryScreen extends StatelessWidget {
  const MissedCallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CallModel> allCallsList = [
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true, videoCall: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true, videoCall: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true, videoCall: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true, videoCall: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", missed: true, videoCall: true),
    ];

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            ((context, index) {
              return SCallBox(call: allCallsList[index]);
            }),
            childCount: allCallsList.length,
          ),
        ),
      ],
    );
  }
}