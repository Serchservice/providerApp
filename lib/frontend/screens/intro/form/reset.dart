import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordForm extends StatefulWidget {
  final PasswordReset model;
  const ResetPasswordForm({super.key, required this.model});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirm = TextEditingController();
  bool loading = false, showP = false, showC = false;

  void changePassword() async {
    if(!_formKey.currentState!.validate()) return;
    try {
      _formKey.currentState!.save();
      setState(() => loading = true);
      await supabase.auth.updateUser(UserAttributes(
        password: password.text.trim()
      ));
      Get.offAll(() => const ResetPasswordSuccessScreen());
    } on AuthException catch (e) {
      showGetSnackbar(
        message: e.message,
        type: Popup.error,
        duration: const Duration(seconds: 3)
      );
      setState(() => loading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
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
              controller: password,
              validate: Validators.password,
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
              icon: showP ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
              suffixColor: SColors.hint,
              onPressed: () => setState(() => showP = !showP),
              obscureText: showP,
            ),
            SFormField.password(
              labelText: "Enter your strong password again",
              formName: "Confirm Password",
              controller: confirm,
              validate: (value) {
                if(value!.isEmpty){
                  return "Password field is empty";
                }else if(value != password.text){
                  return "Password does not match";
                } else {
                  return null;
                }
              },
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
              icon: showC ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
              suffixColor: SColors.hint,
              onPressed: () => setState(() => showC = !showC),
              obscureText: showC,
            ),
            const SizedBox(height: 40),
            SButton(
              text: "Reset Password",
              width: width,
              textWeight: FontWeight.bold,
              textSize: 18,
              padding: const EdgeInsets.all(15),
              onClick: () => changePassword(),
            ),
            const SizedBox(height: 40),
            SButtonText(
              text: "Finding it hard?",
              textButton: "Check our reasons",
              textColor: Theme.of(context).primaryColor,
              textButtonColor: SColors.lightPurple,
              onClick: () => Get.to(() => const WebViewScreen(url: "serchservice.com")),
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