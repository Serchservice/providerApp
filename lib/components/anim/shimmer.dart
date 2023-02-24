import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSerch extends StatelessWidget {
  final int amount;
  final double height;
  final double radius;
  const ShimmerSerch({super.key, required this.amount, this.height = 50, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.generate(amount, (index) => Container(
      width: Get.width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    ));

    return SizedBox(
      width: Get.width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: SColors.shimmerBase,
        highlightColor: SColors.shimmerHigh,
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) => widgets[index],
        )
      ),
    );
  }
}