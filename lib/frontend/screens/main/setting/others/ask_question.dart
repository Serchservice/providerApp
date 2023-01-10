import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class AskQuestionScreen extends StatefulWidget {
  const AskQuestionScreen({super.key});

  @override
  State<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  TextEditingController text = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void sendQuestion() {
    if(!formKey.currentState!.validate()){
      return;
    } else {}
  }

  Future<bool> getBackBool() async {
    if(text.value.text.isNotEmpty){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Theme.of(context).bottomAppBarColor,
                elevation: 0,
                title: SText(
                  text: "Are you sure you want to discard this issue?",
                  color: Theme.of(context).primaryColor, size: 16
                ),
                actions: [
                  SBtn(
                    text: "Discard", textSize: 14,
                    buttonColor: Theme.of(context).bottomAppBarColor,
                    textColor: SColors.lightPurple,
                    onClick: () => Get.offUntil(GetPageRoute(page: () => const FAQSettingScreen()), (route) => false)
                  ),
                  SBtn(
                    text: "Back to editing", textSize: 14,
                    onClick: () => Navigator.of(context).pop(false),
                    buttonColor: Theme.of(context).bottomAppBarColor,
                    textColor: SColors.lightPurple,
                  )
                ],
              );
            }
          );
        }
      );
      return false;
    } else {
      Navigator.of(context).pop(true);
      return true;
    }
  }

  void getBack() {
    if(text.value.text.isNotEmpty){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Theme.of(context).bottomAppBarColor,
                elevation: 0,
                title: SText(
                  text: "Are you sure you want to discard this issue?",
                  color: Theme.of(context).primaryColor, size: 16
                ),
                actions: [
                  SBtn(
                    text: "Discard", textSize: 14,
                    buttonColor: Theme.of(context).bottomAppBarColor,
                    textColor: SColors.lightPurple,
                    onClick: () => Get.offUntil(GetPageRoute(page: () => const FAQSettingScreen()), (route) => false)
                  ),
                  SBtn(
                    text: "Back to editing", textSize: 14,
                    onClick: () => Navigator.of(context).pop(false),
                    buttonColor: Theme.of(context).bottomAppBarColor,
                    textColor: SColors.lightPurple,
                  )
                ],
              );
            }
          );
        }
      );
    } else {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => getBackBool(),
      child: Scaffold(
        appBar: AppBar(
          title: SText.center(
            text: "Talk to us",
            size: 24,
            weight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight
          ),
          leading: IconButton(
            onPressed: () => getBack(),
            icon: Icon(
              CupertinoIcons.chevron_back,
              color: Theme.of(context).primaryColorLight,
              size: 28
            )
          ),
        ),
        body: Padding(
          padding: screenPadding,
          child: Form(
            key: formKey,
            child: SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                      cursorColor: Theme.of(context).primaryColor,
                      controller: text,
                      maxLines: 10,
                      minLines: 5,
                      textAlignVertical: TextAlignVertical.center,
                      textCapitalization: TextCapitalization.sentences,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.multiline,
                      validator: (val) {
                        if(text.value.text.length < 10){
                          return "Give a detailed description of your problem";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Tell us your issue, we will always help you out",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: SColors.hint,
                        ),
                        isDense: true,
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            width: 1.8,
                            color: Theme.of(context).disabledColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            width: 1.8,
                            color: SColors.red,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            width: 1.8,
                            color: Scolors.error,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark,
                            width: 1.8,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                  SButton(
                    text: "We will respond via email",
                    width: Get.width,
                    onClick: () => sendQuestion(),
                    padding: const EdgeInsets.all(10),
                    textWeight: FontWeight.bold,
                    textSize: 18,
                  ),
                ],
              ),
            )
          ),
        )
      ),
    );
  }
}