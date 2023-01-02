import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class HistoryAllCallScreen extends StatelessWidget {
  const HistoryAllCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CallModel> allCallsList = [
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
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