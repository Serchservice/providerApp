import 'package:carousel_slider/carousel_slider.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provide/lib.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int current = 0;
  List<OnboardModel> onboardList = [
    OnboardModel(image: SImages.logo, text: "text"),
    OnboardModel(image: SImages.logo, text: "text"),
  ];
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ConcentricPageView(
                colors: pages.map((p) => p.bgColor).toList(),
                radius: width * 0.1,
                // curve: Curves.ease,
                nextButtonBuilder: (context) => Padding(
                  padding: const EdgeInsets.only(left: 3), // visual center
                  child: Icon(
                    Icons.navigate_next,
                    size: width * 0.08,
                  ),
                ),
                // itemCount: pages.length,
                // duration: const Duration(milliseconds: 1500),
                // opacityFactor: 2.0,
                // scaleFactor: 0.2,
                // verticalPosition: 0.7,
                // direction: Axis.vertical,
                // itemCount: pages.length,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (index) {
                  final page = pages[index % pages.length];
                  return SafeArea(
                    child: _Page(page: page),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSmoothIndicator(
              activeIndex: current,
              count: onboardList.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SButton(
                text: "Let's get you started",
                width: width,
                textSize: 18,
                textColor: Theme.of(context).scaffoldBackgroundColor,
                buttonColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 10),
                textWeight: FontWeight.bold,
                onClick: () => Get.to(() => const SignupScreen()),
              )
            )
          ],
        ),
      ),
    );
  }
}


class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

final pages = [
  const PageData(
    icon: Icons.bubble_chart,
    title: "Local news\nstories",
    bgColor: Color(0xFF0043D0),
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.format_size,
    title: "Choose your\ninterests",
    textColor: Colors.white,
    bgColor: Color(0xFFFDBFDD),
  ),
  const PageData(
    icon: Icons.hdr_weak,
    title: "Drag and\ndrop to move",
    bgColor: Color(0xFFFFFFFF),
  ),
];

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        space(10),
        _Image(
          page: page,
          size: 190,
          iconSize: 170,
        ),
        space(8),
        _Text(
          page: page,
          style: TextStyle(
            fontSize: screenHeight * 0.046,
          ),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.page,
    this.style,
  }) : super(key: key);

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: TextStyle(
        color: page.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Helvetica',
        letterSpacing: 0.0,
        fontSize: 18,
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.page,
    required this.size,
    required this.iconSize,
  }) : super(key: key);

  final PageData page;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bgColor = page.bgColor
        // .withBlue(page.bgColor.blue - 40)
        .withGreen(page.bgColor.green + 20)
        .withRed(page.bgColor.red - 100)
        .withAlpha(90);

    final icon1Color =
        page.bgColor.withBlue(page.bgColor.blue - 10).withGreen(220);
    final icon2Color = page.bgColor.withGreen(66).withRed(77);
    final icon3Color = page.bgColor.withRed(111).withGreen(220);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        color: bgColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 2,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: icon1Color,
              ),
            ),
            right: -5,
            bottom: -5,
          ),
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 5,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: icon2Color,
              ),
            ),
          ),
          Icon(
            page.icon,
            size: iconSize,
            color: icon3Color,
          ),
        ],
      ),
    );
  }
}