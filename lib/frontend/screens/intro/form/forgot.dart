import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  bool loading = false;

  void sendPasswordResetInformation() async {
    if(!_formKey.currentState!.validate()) return;
    try {
      setState(() => loading = true);
      _formKey.currentState!.save();
      await supabase.auth.resetPasswordForEmail(email.text.trim());
      showGetSnackbar(
        message: "We have sent you reset instructions in your email address",
        type: Popup.success,
        duration: const Duration(seconds: 3)
      );
      setState(() => loading = false);
      Get.offAll(() => ConfirmPasswordScreen(email: email.text.trim(),));
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
              controller: email,
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              validate: (value) {
                if(value!.isEmpty){
                  return "Email address field is empty";
                } else {
                  return null;
                }
              },
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            const SizedBox(height: 40),
            SButton(
              text: "Send me a reset instruction",
              width: width,
              textWeight: FontWeight.bold,
              textSize: 18,
              loading: loading,
              padding: const EdgeInsets.all(15),
              onClick: () => sendPasswordResetInformation(),
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