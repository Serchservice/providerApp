import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Initializers().initializeSerchUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.white,
      body: Center(
        child: Image.asset(SImages.logoGif, width: 70)
      ),
    );
  }
}