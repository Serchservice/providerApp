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
  final control = PageController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        pageController: control,
        radius: width * 0.1,
        // curve: Curves.ease,
        nextButtonBuilder: (context) => Icon(
          Icons.navigate_next,
          size: width * 0.10,
        ),
        itemCount: pages.length,
        duration: const Duration(milliseconds: 1500),
        opacityFactor: 2.0,
        scaleFactor: 0.2,
        verticalPosition: 0.7,
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return _Page(
            page: page,
            count: pages.length,
            currentIndex: index
          );
        },
      ),
    );
  }
}


class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color indicatorActiveColor;
  final Color indicatorColor;

  const PageData({
    this.title, this.icon, this.bgColor = Colors.white, this.textColor = Colors.black, this.indicatorColor = SColors.hint,
    this.buttonColor = SColors.white, this.buttonTextColor = SColors.black, this.indicatorActiveColor = SColors.white,
  });
}

final pages = [
  const PageData(
    icon: Icons.bubble_chart,
    title: "Earn comfortably with your\nskills and expertise",
    // bgColor: Color(0xFF0043D0),
    bgColor: Color(0xff030001),
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.hdr_weak,
    title: "Work anywhere and anytime\nwith security",
    bgColor: Color(0xFFFAFAFA),
    buttonColor: Color(0xff030001),
    buttonTextColor: Color(0xffFAFAFA),
    indicatorActiveColor: Color(0xff030001)
  ),
  const PageData(
    icon: Icons.format_size,
    title: "Generate a certificate\nof skill with your ratings",
    textColor: Colors.white,
    bgColor: Color(0xFF07070A),
  ),
];

class _Page extends StatelessWidget {
  final PageData page;
  final int count;
  final int currentIndex;

  const _Page({required this.page, required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        space(10),
        _Image(page: page, size: 190, iconSize: 170),
        space(8),
        _Text(page: page, style: TextStyle(fontSize: screenHeight * 0.046)),
        space(8),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: count,
          effect: ExpandingDotsEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: page.indicatorActiveColor,
            dotColor: page.indicatorColor
          ),
        ),
        space(25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SButton(
            text: "Let's get you started",
            width: width,
            textSize: 18,
            textColor: page.buttonTextColor,
            buttonColor: page.buttonColor,
            padding: const EdgeInsets.symmetric(vertical: 10),
            textWeight: FontWeight.bold,
            onClick: () => Get.to(() => const SignupScreen()),
          )
        )
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({required this.page, this.style});

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
  const _Image({required this.page, required this.size, required this.iconSize});

  final PageData page;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bgColor = page.bgColor
      .withBlue(page.bgColor.blue - 40)
      .withGreen(page.bgColor.green + 20)
      .withRed(page.bgColor.red - 100)
      .withAlpha(90);

    final icon1Color = page.bgColor.withBlue(page.bgColor.blue - 10).withGreen(220);
    final icon2Color = page.bgColor.withGreen(66).withRed(77);
    final icon3Color = page.bgColor.withRed(111).withGreen(220);

    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        color: bgColor,
      ),
      child: Stack(
        clipBehavior: Clip.none, fit: StackFit.expand,
        children: [
          Positioned.fill(
            right: -5, bottom: -5,
            child: RotatedBox(
              quarterTurns: 2,
              child: Icon(page.icon, size: iconSize + 20, color: icon1Color),
            ),
          ),
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 5,
              child: Icon(page.icon, size: iconSize + 20, color: icon2Color),
            ),
          ),
          Icon(page.icon, size: iconSize, color: icon3Color,),
        ],
      ),
    );
  }
}