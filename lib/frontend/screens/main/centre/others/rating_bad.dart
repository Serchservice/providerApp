import 'package:flutter/cupertino.dart';
import 'package:provide/lib.dart';

class BadRatingScreen extends StatefulWidget {
  const BadRatingScreen({super.key});

  @override
  State<BadRatingScreen> createState() => _BadRatingScreenState();
}

class _BadRatingScreenState extends State<BadRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ]
    );
  }
}