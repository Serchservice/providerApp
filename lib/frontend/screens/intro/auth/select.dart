import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              SText(
                text: "Select the category you want to operate with",
                color: Theme.of(context).primaryColor,
                size: 16,
                weight: FontWeight.bold
              ),
              const SizedBox(height: 60),
              SCategoryButton(
                icon: CupertinoIcons.person_circle_fill,
                text: "Serch for Individual",
                color: Theme.of(context).primaryColor,
                onClick: () => Get.to(() => const SignupScreen()),
                textColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              const SizedBox(height: 30),
              SCategoryButton(
                icon: CupertinoIcons.briefcase_fill,
                text: "Serch for Business",
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              const SizedBox(height: 30),
              SButtonText(
                text: "Already have an account?",
                textButton: "Log Me In",
                textColor: Theme.of(context).primaryColor,
                textButtonColor: SColors.lightPurple,
                onClick: () => Get.to(() => const LoginScreen()),
              ),
            ]
          ),
        )
      )
    );
  }
}