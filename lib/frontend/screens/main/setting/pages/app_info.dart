import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SText(
                text: "Serch",
                color: Theme.of(context).primaryColor,
                size: 32,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              SText(
                text: "Version 0.1.0",
                color: Theme.of(context).primaryColorLight,
              ),
              const SizedBox(height: 25),
              Image.asset(SImages.logo, height: 70, color: Theme.of(context).primaryColor,),
              const SizedBox(height: 5),
              SText(
                text: "Service made easy",
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
        ),
      ),
    );
  }
}