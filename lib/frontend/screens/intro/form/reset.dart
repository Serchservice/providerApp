import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: horizontalPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SText(
              text: "Secure Your Serch Account",
              weight: FontWeight.w900,
              size: 22,
              color: Theme.of(context).primaryColor
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: SText.center(
                text: "Your password should contain atleast one capital letter, small letter, number and special",
                weight: FontWeight.w700,
                size: 16,
                color: SColors.hint
              ),
            ),
            const SizedBox(height: 20),
            SFormField.password(
              labelText: "Create a strong password",
              formName: "Password",
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            SFormField.password(
              labelText: "Enter your strong password again",
              formName: "Confirm Password",
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            const SizedBox(height: 40),
            SButton(
              text: "Reset Password",
              width: width,
              textWeight: FontWeight.bold,
              textSize: 18,
              onClick: () => Get.offAll(() => const ResetPasswordSuccessScreen()),
            ),
            const SizedBox(height: 40),
            SButtonText(
              text: "Finding it hard?",
              textButton: "Talk to support",
              textColor: Theme.of(context).primaryColor,
              textButtonColor: SColors.lightPurple,
              onClick: () {},
            ),
            const SizedBox(height: 10),
            SButtonText(
              text: "",
              textButton: "Get Back to Log In",
              textColor: Theme.of(context).primaryColor,
              textButtonColor: SColors.lightPurple,
              onClick: () => Get.offAll(() => const LoginScreen()),
            ),
          ],
        )
      ),
    );
  }
}