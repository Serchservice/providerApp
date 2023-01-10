import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class HistoryT2FCallScreen extends StatelessWidget {
  const HistoryT2FCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CallModel> allCallsList = [
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", t2fVC: true),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        ((context, index) {
          return SCallBox(call: allCallsList[index]);
        }),
        childCount: allCallsList.length,
      ),
    );
  }
}