import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showP = true;

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
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                    SFormField.password(
                      labelText: "Enter your strong password",
                      formName: "Password",
                      controller: password,
                      obscureText: showP,
                      icon: showP ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                      onPressed: () => setState(() => showP = !showP),
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
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
                        text: "Verify",
                        width: width,
                        loading: auth.isLoading,
                        onClick: () => Get.to(() => const CreateNewPasswordScreen()),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textWeight: FontWeight.bold,
                        textSize: 18
                      ),
                    ),
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
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showP = true, showC = true;

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
                      icon: showP ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                      onPressed: () => setState(() => showP = !showP),
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                      suffixColor: Theme.of(context).primaryColorLight,
                    ),
                    SFormField.password(
                      labelText: "Confirm your personal strong password",
                      formName: "Confirm Password",
                      controller: password,
                      obscureText: showC,
                      icon: showC ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                      onPressed: () => setState(() => showC = !showC),
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                      suffixColor: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(height: 40),
                    Consumer<Auth>(
                      builder:(context, auth, child) => SButton(
                        text: "Change my password",
                        width: width,
                        loading: auth.isLoading,
                        onClick: () => Get.offAll(() => const BottomNavigator()),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textWeight: FontWeight.bold,
                        textSize: 18
                      ),
                    ),
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