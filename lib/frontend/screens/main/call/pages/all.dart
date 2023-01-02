import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class AllCallHistoryScreen extends StatelessWidget {
  const AllCallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CallModel> allCallsList = [
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", videoCall: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am",),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am",),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am",),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am"),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", missed: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", t2fVC: true),
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