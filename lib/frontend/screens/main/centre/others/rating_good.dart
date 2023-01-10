import 'package:flutter/cupertino.dart';
import 'package:provide/lib.dart';

class GoodRatingScreen extends StatefulWidget {
  const GoodRatingScreen({super.key});

  @override
  State<GoodRatingScreen> createState() => _GoodRatingScreenState();
}

class _GoodRatingScreenState extends State<GoodRatingScreen> {
  List<RatingTalkModel> ratingList = [];
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