import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provide/lib.dart';

class BadRatingScreen extends StatelessWidget {
  const BadRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<UserRateModel> ratingList = HiveUserDatabase().getRateDataList();
    final filteredRatings = List<UserRateModel>.from(ratingList.where((rate) => double.parse(rate.raterRate) >= 2.5));
    return CustomScrollView(
      slivers: [
        if(filteredRatings.isEmpty)
        const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 200),
          sliver: SliverToBoxAdapter(child: SText.center(text: "You have no rating", color: SColors.hint, size: 24)),
        )
        else
        SliverList(
          delegate: SliverChildBuilderDelegate(((context, index) {
            return RateBox(model: filteredRatings[index]);
          }), childCount: filteredRatings.length)
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20))
      ],
    );
  }
}

class RateBox extends StatelessWidget {
  final UserRateModel model;
  final Color? backgroundColor;
  const RateBox({super.key, required this.model, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          UserAvatar.small(image: model.raterImage),
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
                    Expanded(
                      child: SText(
                        text: model.raterName,
                        color: Theme.of(context).primaryColorLight,
                        size: 16
                      ),
                    ),
                    RatingBarIndicator(
                      rating: double.parse(model.raterRate),
                      itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 15.0,
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                model.raterComment.isEmpty ? Container() : SText(text: model.raterComment, color: SColors.hint, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GoodRatingScreen extends StatefulWidget {
  const GoodRatingScreen({super.key});

  @override
  State<GoodRatingScreen> createState() => _GoodRatingScreenState();
}

class _GoodRatingScreenState extends State<GoodRatingScreen> {
  @override
  Widget build(BuildContext context) {
    List<UserRateModel> ratingList = HiveUserDatabase().getRateDataList();
    final filteredRatings = List<UserRateModel>.from(ratingList.where((rate) => double.parse(rate.raterRate) >= 2.6));
    return CustomScrollView(
      slivers: [
        if(filteredRatings.isEmpty)
        const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 200),
          sliver: SliverToBoxAdapter(child: SText.center(text: "You have no rating", color: SColors.hint, size: 24)),
        )
        else
        SliverList(
          delegate: SliverChildBuilderDelegate(((context, index) {
            return RateBox(model: filteredRatings[index]);
          }), childCount: filteredRatings.length)
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20))
      ],
    );
  }
}