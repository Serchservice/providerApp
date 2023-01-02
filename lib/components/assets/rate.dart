import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SStarRate extends StatelessWidget {
  final bool up;
  final bool down;
  const SStarRate({super.key, this.up = false, this.down = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 16),
        SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 16),
        SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 16),
        SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 16),
        SizedBox(width: 2),
        Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: 16),
      ],
    );
  }
}

class RatingTalks extends StatelessWidget {
  final String image;
  final String comment;
  final String name;
  final Widget rate;
  final bool good;
  const RatingTalks({super.key, this.image = "", required this.comment, required this.rate, this.good = false, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          const Picture.medium(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SText(
                      text: name,
                      color: Theme.of(context).primaryColorLight,
                      size: 16
                    ),
                    rate
                  ],
                ),
                const SizedBox(height: 1),
                SText(text: comment, color: SColors.hint, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

