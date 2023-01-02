import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/lib.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ReferTree extends StatefulWidget {
  const ReferTree({super.key});

  @override
  State<ReferTree> createState() => _ReferTreeState();
}

class _ReferTreeState extends State<ReferTree> {
  //TimeLine Package
  List<ReferStep>? steps;

  @override
  void initState() {
    super.initState();
    steps = referGenerate();
  }

  List<ReferStep> referGenerate() {
    return <ReferStep>[
      ReferStep(step: 1, referredName: "Evaristus Adims", referredPicture: SImages.barb),
      ReferStep(step: 2, referredName: "Evaristus Adims", referredPicture: SImages.barb),
      ReferStep(step: 3, referredName: "Evaristus Adims", referredPicture: SImages.barb),
      ReferStep(step: 4, referredName: "Evaristus Adims", referredPicture: SImages.barb),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffCCCCA9),
            Color(0xffFFA578),
          ],
        )
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Header(),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    TimelineSteps(steps: steps!)
                  ],
                )
              )
            ],
          )
        ),
      )
    );
  }
}

class TimelineSteps extends StatelessWidget {
  final List<ReferStep> steps;
  const TimelineSteps({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if(index.isOdd){
            return TimelineDivider(
              color: Theme.of(context).primaryColorDark,
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );
          }
          final int itemIndex = index ~/ 2;
          final ReferStep step = steps[itemIndex];
          final bool isLeftAlign = itemIndex.isEven;
          final child = TimelineStepsChild(
            name: step.referredName,
            picture: step.referredPicture,
            isLeftAlign: isLeftAlign,
          );
          final isFirst = itemIndex == 0;
          final isLast = itemIndex == steps.length - 1;
          double indicatorY;
          if(isFirst){
            indicatorY = 0.2;
          } else if(isLast){
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }
          return TimelineTile(
            alignment: TimelineAlign.manual,
            endChild: isLeftAlign ? child : null,
            startChild: isLeftAlign ? null : child,
            lineXY: isLeftAlign ? 0.5 : 0.5,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicatorXY: indicatorY,
              indicator: TimelineStepIndicator(step: '${step.step}'),
            ),
            beforeLineStyle: LineStyle(color: Theme.of(context).primaryColorDark, thickness: 5),
          );
        },
        childCount: max(0, steps.length * 2 - 1),
      )
    );
  }
}

class TimelineStepIndicator extends StatelessWidget {
  final String step;
  const TimelineStepIndicator({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColorDark
        // color: Color(0xffCB8421)
      ),
      child: Center(
        child: SText(text: step, color: SColors.white, size: 18, weight: FontWeight.bold,)
      ),
    );
  }
}

class TimelineStepsChild extends StatelessWidget {
  final String name;
  final String picture;
  final bool isLeftAlign;
  const TimelineStepsChild({super.key, required this.name, required this.picture, required this.isLeftAlign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftAlign ? const EdgeInsets.only(right: 32, top: 6, bottom: 6, left: 10)
      : const EdgeInsets.only(left: 32, top: 6, bottom: 6, right: 10),
      child: Column(
        crossAxisAlignment: isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(picture, width: 30),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: GoogleFonts.acme(
              fontSize: 22, color: const Color(0xffB96320), fontWeight: FontWeight.bold,
            )
          ),
        ]
      )
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Your Referred",
              textAlign: TextAlign.center,
              style: GoogleFonts.architectsDaughter(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ]
      )
    );
  }
}