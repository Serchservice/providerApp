import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provide/lib.dart';

class SummaryRatingScreen extends StatefulWidget {
  const SummaryRatingScreen({super.key});

  @override
  State<SummaryRatingScreen> createState() => _SummaryRatingScreenState();
}

class _SummaryRatingScreenState extends State<SummaryRatingScreen> {
  double rate = 3;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: SColors.yellow,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: const SText(text: "NOTE: Ratings are summarized on a three-month basis. Be advised.",)
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: rate,
                itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_up_arrow_down,
                    size: 16,
                    color: rate >= 3.5 ? SColors.green : rate >= 1.5 ? SColors.yellow : SColors.red
                  ),
                  const SizedBox(width: 10),
                  SText(
                    text: rate.toString(),
                    size: 16,
                    weight: FontWeight.bold,
                    color: rate >= 3.5 ? SColors.green : rate >= 1.5 ? SColors.yellow : SColors.red
                  )
                ],
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SummaryRateChart(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: rate >= 3.5 ? SColors.green : rate >= 1.5 ? SColors.yellow : SColors.red,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: rate >= 3.5 ? Wrap(
                  runSpacing: 5.0,
                  children: const [
                    SText(text: "You are doing great so far, and we commend you for that. ", color: SColors.white, size: 16),
                    SText(text: "Never stop in these good reviews, that is a sign that people love what you do. ", color: SColors.white, size: 16),
                    SText(text: "It's also a sign that you love what Serch does for you. ", color: SColors.white, size: 16),
                    Center(child: Icon(FontAwesomeIcons.solidFaceGrinHearts, size: 24, color: SColors.rate))
                  ],
                )
                : rate >= 1.5 ? Wrap(
                  runSpacing: 5.0,
                  children: const [
                    SText(text: "We see your efforts and we commend that very well. More to your elbow!.", color: SColors.white, size: 16),
                    SText(text: "Looking forward to seeing you grow in these good ratings. We are so thrilled.", color: SColors.white, size: 16),
                    SText(text: "Serch's got your back by providing you details on how far you have gone.", color: SColors.white, size: 16),
                    Center(child: Icon(FontAwesomeIcons.solidFaceGrinWink, size: 24, color: SColors.rate))
                  ],
                )
                : Wrap(
                  runSpacing: 5.0,
                  children: const [
                    SText(text: "This is not what we encourage in Serch family. We don't know what is wrong!. ", color: SColors.white, size: 16),
                    SText(text: "You need to do more than this, and you really can, if you want. ", color: SColors.white, size: 16),
                    SText(text: "Note: Serch reserves the right to suspend your account if this persists!. ", color: SColors.rate, size: 18),
                    Center(child: Icon(FontAwesomeIcons.solidFaceAngry, size: 24, color: SColors.rate))
                  ],
                )
              )
            ],
          )
        )
      ],
    );
  }
}