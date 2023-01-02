import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provide/lib.dart';

class SummaryRatingScreen extends StatefulWidget {
  const SummaryRatingScreen({super.key});

  @override
  State<SummaryRatingScreen> createState() => _SummaryRatingScreenState();
}

class _SummaryRatingScreenState extends State<SummaryRatingScreen> {
  bool up = true;
  bool down = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: SColors.yellow,
            borderRadius: BorderRadius.circular(8)
          ),
          child: const SText(text: "NOTE: Ratings are summarized on a three-month basis. Be advised.",)
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SStarRate(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.arrow_up_arrow_down,
                  size: 16,
                  color: up ? SColors.green : down ? SColors.red : SColors.yellow
                ),
                const SizedBox(width: 10),
                SText(
                  text: "4.5",
                  size: 16,
                  weight: FontWeight.bold,
                  color: up ? SColors.green : down ? SColors.red : SColors.yellow
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        const SummaryRateChart(),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: up ? SColors.green : down ? SColors.red : SColors.yellow,
            borderRadius: BorderRadius.circular(8)
          ),
          child: up ? Wrap(
            runSpacing: 5.0,
            children: const [
              SText(text: "You are doing great so far, and we commend you for that. ", color: SColors.white, size: 16),
              SText(text: "Never stop in these good reviews, that is a sign that people love what you do. ", color: SColors.white, size: 16),
              SText(text: "It's also a sign that you love what Serch does for you. ", color: SColors.white, size: 16),
              Center(child: Icon(FontAwesomeIcons.solidFaceGrinHearts, size: 24, color: SColors.rate))
            ],
          )
          : down ? Wrap(
            runSpacing: 5.0,
            children: const [
              SText(text: "This is not what we encourage in Serch family. We don't know what is wrong!. ", color: SColors.white, size: 16),
              SText(text: "You need to do more than this, and you really can, if you want. ", color: SColors.white, size: 16),
              SText(text: "Note: Serch reserves the right to suspend your account if this persists!. ", color: SColors.rate, size: 18),
              Center(child: Icon(FontAwesomeIcons.solidFaceAngry, size: 24, color: SColors.rate))
            ],
          )
          : Wrap(
            runSpacing: 5.0,
            children: const [
              SText(text: "We see your efforts and we commend that very well. More to your elbow!.", color: SColors.white, size: 16),
              SText(text: "Looking forward to seeing you grow in these good ratings. We are so thrilled.", color: SColors.white, size: 16),
              SText(text: "Serch's got your back by providing you details on how far you have gone.", color: SColors.white, size: 16),
              Center(child: Icon(FontAwesomeIcons.solidFaceGrinWink, size: 24, color: SColors.rate))
            ],
          )
        )
      ],
    );
  }
}