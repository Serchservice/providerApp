import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showP = true;

  Future login() async {
    _formKey.currentState!.save();
    // final auth = Provider.of<Auth>(context, listen: false);
    // auth.logIn(password: password.text.trim(), email: email.text.trim());
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
            Consumer<Auth>(
              builder:(context, auth, child) => SButton(
                text: "Log me In",
                width: width,
                loading: auth.isLoading,
                onClick: () => login(),
                padding: const EdgeInsets.symmetric(vertical: 15),
                textWeight: FontWeight.bold,
                textSize: 18
              ),
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