import 'package:animated_splash_screen/animated_splash_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SplashScreen extends StatelessWidget {
  ///This widget is the introductory widget of Serch app. It shows the Serch logo gif while the database checks the auth session.
  ///
  ///It will navigate to the UserStateListener widget
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(SImages.logoGif,),
      duration: 5000,
      nextScreen: const UserStateListener(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}