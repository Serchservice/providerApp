import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                ),
                const Expanded(flex: 2, child: SizedBox(height: 25)),
                Column(
                  children: [
                    Image.asset(SImages.logo, height: 50, color: Theme.of(context).primaryColor,),
                    const SizedBox(height: 25),
                    SText(
                      text: "Serch",
                      color: Theme.of(context).primaryColor,
                      size: 48,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 5),
                    SText(
                      text: "Version 1.0.0",
                      color: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(height: 25),
                    SButton(
                      text: "Licenses",
                      width: 150,
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 25),
                    SText(
                      text: '"A provideSharing and requestSharing platform."',
                      style: FontStyle.italic,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ],
                ),
                const Expanded(flex: 2, child: SizedBox(height: 25)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}