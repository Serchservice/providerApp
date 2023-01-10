import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class DeleteMyAccountScreen extends StatefulWidget {
  const DeleteMyAccountScreen({super.key});

  @override
  State<DeleteMyAccountScreen> createState() => _DeleteMyAccountScreenState();
}

class _DeleteMyAccountScreenState extends State<DeleteMyAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showP = true;

  delete() {
    openDeleteAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
          ),
          title: SText(text: "Delete my account", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Scolors.info3,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.warning_rounded, color: SColors.red, size: 35),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          const SText(
                            text: "Deleting your account from Serch will:",
                            color: SColors.black,
                            weight: FontWeight.bold,
                            size: 14
                          ),
                          const SizedBox(height: 10),
                          SText(
                            text: "* Delete your account from Serch",
                            color: Theme.of(context).backgroundColor,
                            size: 14
                          ),
                          const SizedBox(height: 5),
                          SText(
                            text: "* Delete your account from Serch",
                            color: Theme.of(context).backgroundColor,
                            size: 14
                          ),
                          const SizedBox(height: 5),
                          SText(
                            text: "* Delete your account from Serch",
                            color: Theme.of(context).backgroundColor,
                            size: 14
                          ),
                          const SizedBox(height: 5),
                          SText(
                            text: "* Delete your account from Serch",
                            color: Theme.of(context).backgroundColor,
                            size: 14
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.mail, color: Theme.of(context).primaryColorLight, size: 30),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SText(
                                text: "Change your email instead?",
                                color: Theme.of(context).primaryColorLight,
                                size: 16
                              ),
                              const SizedBox(height: 5),
                              SButton(
                                text: "Change my email address",
                                padding: const EdgeInsets.all(10),
                                onClick: () => Get.offAll(() => const EditProfileScreen()),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.password, color: Theme.of(context).primaryColorLight, size: 30),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SText(
                                text: "Change your password rather?",
                                color: Theme.of(context).primaryColorLight,
                                size: 16
                              ),
                              const SizedBox(height: 5),
                              SButton(
                                text: "Change my password", padding: const EdgeInsets.all(10),
                                onClick: () => Get.to(() => const ChangePasswordScreen()),
                              )
                            ],
                          )
                        ],
                      ),
                    ]
                  )
                ),
                const SizedBox(height: 15),
                SText(
                  text: "To delete your account, confirm your email address and your password.",
                  color: Theme.of(context).primaryColorLight,
                  size: 16
                ),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      const SizedBox(height: 30),
                      Consumer<Auth>(
                        builder:(context, auth, child) => SButton(
                          text: "Delete my account",
                          loading: auth.isLoading,
                          onClick: () => delete(),
                          padding: const EdgeInsets.all(10),
                          textWeight: FontWeight.bold,
                          textSize: 18,
                          buttonColor: SColors.red,
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}