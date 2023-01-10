import 'package:flutter/cupertino.dart';
import 'package:provide/lib.dart';

class BadRatingScreen extends StatefulWidget {
  const BadRatingScreen({super.key});

  @override
  State<BadRatingScreen> createState() => _BadRatingScreenState();
}

class _BadRatingScreenState extends State<BadRatingScreen> {
  List<RatingTalkModel> ratingList = [
    RatingTalkModel(image: SImages.barberAvatar, name: "Evaristus Adimonyemma", rate: 4, good: true)
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if(ratingList.isEmpty)
        const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 200),
          sliver: SliverToBoxAdapter(child: SText.center(text: "You have no rating", color: SColors.hint, size: 24)),
        )
        else
        SliverList(
          delegate: SliverChildBuilderDelegate(((context, index) {
            return RatingTalks(model: ratingList[index]);
          }), childCount: ratingList.length)
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20))
      ],
    );
  }
}