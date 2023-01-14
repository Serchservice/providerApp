import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provide/lib.dart';

class ResetPasswordSuccessScreen extends StatelessWidget {
  const ResetPasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SRes.isPhone(context)
      ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: horizontalPadding,
                child: Lottie.network(
                  repeat: false,
                  "https://assets9.lottiefiles.com/private_files/lf30_dqbik4tt.json",
                  // "https://assets3.lottiefiles.com/private_files/lf30_tdnhii9y.json"
                  height: 200,
                ),
              ),
              const SizedBox(height: 10),
              const SText(
                text: "Successful",
                weight: FontWeight.w900,
                size: 32,
                color: SColors.green
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: SText.center(
                  text: "You have reset your password successfully.",
                  weight: FontWeight.w700,
                  size: 16,
                  color: SColors.hint
                ),
              ),
              const SizedBox(height: 40),
              SButton(
                text: "Head Back to Log In",
                width: width,
                textWeight: FontWeight.bold,
                textSize: 18,
                padding: const EdgeInsets.all(15),
                onClick: () => Get.offAll(() => const LoginScreen()),
              ),
            ]
          ),
        )
      )
      : Column()
    );
  }
}