import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class ConnectionProfile extends StatelessWidget {
  final String distance;
  final String tripCount;
  final String name;
  final bool online;
  final bool offline;
  const ConnectionProfile({
    super.key, required this.distance, this.online = true, this.offline = false, required this.tripCount, required this.name
  });

  @override
  Widget build(BuildContext context) {
    const padded = EdgeInsets.only(bottom: 12);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: padded,
            child: Container(
              color: SColors.hint,
              height: 2,
              width: 100,
            ),
          ),
          const Picture(radius: 70),
          const SizedBox(height: 10),
          const SStarRate(),
          const SizedBox(height: 10),
          SText.center(
            text: name,
            size: 16, weight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SIconButton(icon: CupertinoIcons.phone_fill, iconColor: SColors.white, size: 16),
              SizedBox(width: 5),
              SIconButton(icon: CupertinoIcons.video_camera_solid, iconColor: SColors.white, size: 16),
              SizedBox(width: 5),
              SIconButton(icon: CupertinoIcons.bubble_left_bubble_right_fill, iconColor: SColors.white, size: 16),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SText(
                    text: "Status: ",
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                  Icon(
                    online ? CupertinoIcons.bolt_circle_fill : offline ? CupertinoIcons.bolt_slash_fill
                      : CupertinoIcons.bolt_horizontal_circle_fill,
                    color: online ? SColors.green : offline ? SColors.red : SColors.yellow,
                    size: 16
                  ),
                  SText(
                    text: online ? " Online" : offline ? " Offline" : " Busy but Online",
                    size: 16, weight: FontWeight.bold,
                    color: online ? SColors.green : offline ? SColors.red : SColors.yellow,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  SText(
                    text: "Distance: ",
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                  SText(
                    text: distance,
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  SText(
                    text: "Service Trip Count: ",
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                  SText(
                    text: tripCount,
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SText(
                text: "Recent Rating Comments",
                size: 16, weight: FontWeight.bold,
                color: SColors.hint
              ),
              const SizedBox(height: 10),
              RatingTalks(
                comment: "Knows what he is doing and good at his job",
                name: "Evaristus Adimonyemma",
                rate: Row(
                  children: const [
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: 14),
                  ],
                )
              ),
              RatingTalks(
                comment: "Knows what he is doing and good at his job",
                name: "Evaristus Adimonyemma",
                rate: Row(
                  children: const [
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: 14),
                  ],
                )
              ),
              RatingTalks(
                comment: "Knows what he is doing and good at his job",
                name: "Evaristus Adimonyemma",
                rate: Row(
                  children: const [
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: 14),
                  ],
                )
              ),
              RatingTalks(
                comment: "Knows what he is doing and good at his job",
                name: "Evaristus Adimonyemma",
                rate: Row(
                  children: const [
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                    Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: 14),
                  ],
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}