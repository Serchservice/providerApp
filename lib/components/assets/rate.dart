import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provide/lib.dart';

class RatingTalks extends StatelessWidget {
  final RatingTalkModel model;
  final Color? backgroundColor;
  const RatingTalks({super.key, required this.model, this.backgroundColor});

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
                    Expanded(
                      child: SText(
                        text: model.name,
                        color: Theme.of(context).primaryColorLight,
                        size: 16
                      ),
                    ),
                    RatingBarIndicator(
                      rating: model.rate,
                      itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 15.0,
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                model.comment != null ? SText(text: model.comment!, color: SColors.hint, size: 16) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

