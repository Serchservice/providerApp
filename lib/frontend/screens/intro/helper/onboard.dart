import 'package:carousel_slider/carousel_slider.dart';
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
  final onboardList = onBoardingLists;
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: onboardList,
                      carouselController: controller,
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16/9,
                        viewportFraction: 0.8,
                        enableInfiniteScroll: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 50),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                        },
                      )
                    )
                  ],
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
        )
      ),
    );
  }
}
