import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showP = true, loading = false;

  Future login() async {
    if(!_formKey.currentState!.validate()) return;
    try {
      setState(() => loading = true);
      _formKey.currentState!.save();
      await supabase.auth.signInWithPassword(
        password: password.text.trim(),
        email: email.text.trim()
      );
      setState(() => loading = false);
      Get.offAll(() => const BottomNavigator());
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
      padding: screenPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SText(
              text: "It's nice to see you back",
              weight: FontWeight.w900,
              size: 22,
              color: Theme.of(context).primaryColor
            ),
            const SizedBox(height: 5),
            const SText(
              text: "Log into your Serch account",
              weight: FontWeight.w700,
              size: 16,
              color: SColors.hint
            ),
            const SizedBox(height: 20),
            SFormField(
              labelText: "johndoe@gmail.com",
              formName: "Email Address",
              controller: email,
              validate: (value) {
                if(value!.isEmpty){
                  return "Email address field is empty";
                } else {
                  return null;
                }
              },
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            SFormField.password(
              labelText: "Enter your strong password",
              formName: "Password",
              controller: password,
              validate: (value) {
                if(value!.isEmpty){
                  return "Password field is empty";
                } else {
                  return null;
                }
              },
              obscureText: showP,
              icon: showP ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
              onPressed: () => setState(() => showP = !showP),
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
              suffixColor: Theme.of(context).primaryColorLight,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Get.off(() => const ForgotPasswordScreen()),
                  child: const SText(text: "Forgot Password?", color: SColors.lightPurple, size: 16, weight: FontWeight.w800)
                ),
              ],
            ),
            const SizedBox(height: 40),
            SButton(
              text: "Log me In",
              width: width,
              loading: loading,
              onClick: () => login(),
              padding: const EdgeInsets.symmetric(vertical: 15),
              textWeight: FontWeight.bold,
              textSize: 18
            ),
            const SizedBox(height: 20),
            SButtonText(
              text: "Don't have an account?",
              textButton: "Sign Me Up",
              textColor: Theme.of(context).primaryColor,
              textButtonColor: SColors.lightPurple,
              onClick: () => Get.offAll(() => const SignupScreen()),
            ),
          ],
        )
      ),
    );
  }
}