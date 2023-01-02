import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class OutgoingCallHistoryScreen extends StatelessWidget {
  const OutgoingCallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CallModel> allCallsList = [
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Evaristus Adimonyemma", callTime: "2:00am", outgoing: true),
      CallModel(callerName: "Francis Adimonyemma", callTime: "2:00am", outgoing: true),
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