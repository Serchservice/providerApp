import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provide/lib.dart';

class CHH extends StatelessWidget {
  final String name;
  final String category;
  final double rate;
  const CHH({super.key, this.name = "Evaristus Adimonyemma", this.category = "Electrician", this.rate = 4.5});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Picture(radius: 60,)),
        const SizedBox(height: 15),
        SText.center(text: name, color: Theme.of(context).primaryColorLight, size: 20, weight: FontWeight.bold,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SText.center(
              text: rate.toString(),
              color: rate >= 3.5 ? SColors.green : rate >= 1.5 ? SColors.yellow : SColors.red, size: 16,
              weight: FontWeight.bold,
            ),
            const SizedBox(width: 10),
            RatingBarIndicator(
              rating: rate,
              itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 15.0,
            ),
          ],
        ),
      ],
    );
  }
}