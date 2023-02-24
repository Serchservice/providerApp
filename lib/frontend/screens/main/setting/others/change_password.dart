import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showP = true, loading = false;

  void verify() async {
    if(!_formKey.currentState!.validate()) return;
    try {
      _formKey.currentState!.save();
      setState(() => loading = true);
      await supabase.auth.signInWithPassword(email: email.text.trim(), password: password.text.trim());
      setState(() => loading = false);
      Get.to(() => CreateNewPasswordScreen(email: email.text.trim()));
    } on AuthException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
        title: SText.center(
          text: "Change your password",
          size: 20,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              SImages.logo,
              width: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ]
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    SText(
                      text: "Authenticate yourself before getting started",
                      weight: FontWeight.w900,
                      size: 22,
                      align: TextAlign.center,
                      color: Theme.of(context).primaryColor
                    ),
                    const SizedBox(height: 70),
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
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                    SFormField.password(
                      labelText: "Enter your strong password",
                      formName: "Password",
                      controller: password,
                      obscureText: showP,
                      validate: (value) {
                        if(value!.isEmpty){
                          return "Password field is empty";
                        } else {
                          return null;
                        }
                      },
                      icon: showP ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                      onPressed: () => setState(() => showP = !showP),
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                      suffixColor: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(height: 40),
                    SButton(
                      text: "Verify",
                      width: width,
                      onClick: () => verify(),
                      loading: loading,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      textWeight: FontWeight.bold,
                      textSize: 18
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                    )
                  ],
                )
              ),
            ),
          )
        )
      )
    );
  }
}

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;
  const CreateNewPasswordScreen({super.key, required this.email});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final confirm = TextEditingController();
  final password = TextEditingController();
  bool showP = true, showC = true, loading = false;

  void changePassword() async {
    if(!_formKey.currentState!.validate()) return;
    try {
      _formKey.currentState!.save();
      setState(() => loading = true);
      await supabase.auth.updateUser(UserAttributes(password: password.text.trim()));
      setState(() => loading = false);
      showGetSnackbar(message: "You have changed your password for ${widget.email}", type: Popup.success);
      Get.offAll(() => const BottomNavigator());
    } on AuthException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
        title: SText.center(
          text: "Create a new password",
          size: 20,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              SImages.logo,
              width: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ]
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    SText(
                      text: "Create a strong password only you can remember",
                      weight: FontWeight.w900,
                      size: 22,
                      align: TextAlign.center,
                      color: Theme.of(context).primaryColor
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const SText(
                        text: "Tips on Creating a strong password: Make use of capital and small alphabets, numbers, characters like @#\$%*&, etc.",
                        color: SColors.hint,
                        weight: FontWeight.bold,
                        size: 12
                      )
                    ),
                    const SizedBox(height: 70),
                    SFormField.password(
                      labelText: "Create a personal strong password",
                      formName: "Create Password",
                      controller: password,
                      obscureText: showP,
                      validate: Validators.password,
                      icon: showP ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                      onPressed: () => setState(() => showP = !showP),
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                      suffixColor: Theme.of(context).primaryColorLight,
                    ),
                    SFormField.password(
                      labelText: "Confirm your personal strong password",
                      formName: "Confirm Password",
                      controller: confirm,
                      obscureText: showC,
                      validate: (value) {
                        if(value != password.text){
                          return "Password does not match";
                        } else {
                          return null;
                        }
                      },
                      icon: showC ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                      onPressed: () => setState(() => showC = !showC),
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                      suffixColor: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(height: 40),
                    SButton(
                      text: "Change my password",
                      width: width,
                      onClick: () => changePassword(),
                      loading: loading,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      textWeight: FontWeight.bold,
                      textSize: 18
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                    )
                  ],
                )
              ),
            ),
          )
        )
      )
    );
  }
}