import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provide/lib.dart';

class VerifyPasswordScreen extends StatefulWidget {
  const VerifyPasswordScreen({super.key});

  @override
  State<VerifyPasswordScreen> createState() => _VerifyPasswordScreenState();
}

class _VerifyPasswordScreenState extends State<VerifyPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SRes.isPhone(context)
      ? SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        SImages.logo,
                        width: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: horizontalPadding,
                  child: Lottie.network(
                    repeat: false,
                    "https://assets7.lottiefiles.com/packages/lf20_PAtvr0.json",
                    height: 200,
                  )
                ),
                const SizedBox(height: 10),
                SText(
                  text: "Check Your Email",
                  weight: FontWeight.w900,
                  size: 22,
                  color: Theme.of(context).primaryColor
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: SText.center(
                    text: "We have sent you a reset email with instructions.",
                    weight: FontWeight.w700,
                    size: 16,
                    color: SColors.hint
                  ),
                ),
                const SizedBox(height: 40),
                SButton(
                  text: "Open Email App",
                  width: width,
                  textWeight: FontWeight.bold,
                  textSize: 18,
                  padding: const EdgeInsets.all(15),
                  onClick: () => Get.offAll(() => const ResetPasswordScreen()),
                ),
                const SizedBox(height: 40),
                SButtonText(
                  text: "Didn't get an email?",
                  textButton: "Click for a resend",
                  textColor: Theme.of(context).primaryColor,
                  textButtonColor: SColors.lightPurple,
                  onClick: () => Get.offAll(() => const ForgotPasswordScreen()),
                ),
              ]
            ),
          )
        )
      )
      : Column()
    );
  }
}