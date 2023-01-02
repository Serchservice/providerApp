import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: screenPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SText(
              text: "Forgot Password?",
              weight: FontWeight.w900,
              size: 22,
              color: Theme.of(context).primaryColor
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: SText.center(
                text: "Give us your email and we will send you a reset instruction via email",
                weight: FontWeight.w700,
                size: 16,
                color: SColors.hint
              ),
            ),
            const SizedBox(height: 40),
            SFormField(
              labelText: "johndoe@gmail.com",
              formName: "Email Address",
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            const SizedBox(height: 40),
            SButton(
              text: "Send me a reset instruction",
              width: width,
              textWeight: FontWeight.bold,
              textSize: 18,
              onClick: () => Get.offAll(() => const VerifyPasswordScreen()),
            ),
            const SizedBox(height: 40),
            SButtonText(
              text: "Don't need a reset?",
              textButton: "Get back to Log In",
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