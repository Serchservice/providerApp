import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class FreeTrialActivatedScreen extends StatefulWidget {
  const FreeTrialActivatedScreen({super.key});

  @override
  State<FreeTrialActivatedScreen> createState() => _FreeTrialActivatedScreenState();
}

class _FreeTrialActivatedScreenState extends State<FreeTrialActivatedScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, callback);
  }

  callback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const BottomNavigator()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.white,
      body: Padding(
        padding: screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(SImages.openGiftBox,),
            const SText.center(
              text: "You have activated your free trial package",
              size: 20,
              weight: FontWeight.bold,
              color: SColors.green,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SText.center(
                text: "This page will automatically lead you to where you are going in seconds.",
                size: 16,
                weight: FontWeight.bold,
                color: SColors.black,
              ),
            ),
          ],
        )
      ),
    );
  }
}



class SignupActivatedScreen extends StatefulWidget {
  const SignupActivatedScreen({super.key});

  @override
  State<SignupActivatedScreen> createState() => _SignupActivatedScreenState();
}

class _SignupActivatedScreenState extends State<SignupActivatedScreen> {
  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 10);
    Timer(duration, () => Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const BottomNavigator()
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SText(
              text: "Yay!",
              size: 32,
              weight: FontWeight.bold,
              color: SColors.green,
            ),
            const SizedBox(height: 10),
            const SText.center(
              text: "You have successfully created a Serch Account",
              size: 20,
              weight: FontWeight.bold,
              color: SColors.green,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SText.center(
                text: "This page will automatically lead you to where you are going in seconds.",
                size: 16,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        )
      ),
    );
  }
}