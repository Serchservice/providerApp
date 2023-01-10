import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class TFACreateCodeScreen extends StatefulWidget {
  const TFACreateCodeScreen({super.key});

  @override
  State<TFACreateCodeScreen> createState() => _TFACreateCodeScreenState();
}

class _TFACreateCodeScreenState extends State<TFACreateCodeScreen> {
  final code1 = TextEditingController();
  final code2 = TextEditingController();
  final code3 = TextEditingController();
  final code4 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void next() {
    if(!formKey.currentState!.validate()){
      return;
    } else {

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Two-step verification", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SText(
                        text: "Create a 6-digit PIN that you can remember",
                        color: Theme.of(context).primaryColorLight,
                        size: 16, weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code1,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          ),
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code2,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          ),
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code3,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          ),
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code4,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  if(code1.value.text.isNotEmpty && code2.value.text.isNotEmpty && code3.value.text.isNotEmpty){
                                    Get.to(() => const TFAConfirmCodeScreen());
                                  }
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          )
                        ]
                      )
                    ],
                  )
                )
              ),

              const SizedBox(height: 20),
              SButton(
                text: "Next",
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                textSize: 16,
                onClick: () => next(),
              ),
              const SizedBox(height: 20),
            ],
          )
        ),
      ),
    );
  }
}




class TFAConfirmCodeScreen extends StatefulWidget {
  const TFAConfirmCodeScreen({super.key});

  @override
  State<TFAConfirmCodeScreen> createState() => _TFAConfirmCodeScreenState();
}

class _TFAConfirmCodeScreenState extends State<TFAConfirmCodeScreen> {
  final code1 = TextEditingController();
  final code2 = TextEditingController();
  final code3 = TextEditingController();
  final code4 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasTFA = false;

  void apply() {
    if(!formKey.currentState!.validate()){
      return;
    } else {
      setState(() => hasTFA = true);
      UserPreferences().saveTFA(hasTFA);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Two-step verification", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SText(
                        text: "Confirm your pin",
                        color: Theme.of(context).primaryColorLight,
                        size: 18, weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code1,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          ),
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code2,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          ),
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code3,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          ),
                          SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: code4,
                              decoration: InputDecoration(
                                hintText: "*", hintStyle: Theme.of(context).textTheme.headline5,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.hint,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  if(code1.value.text.isNotEmpty && code2.value.text.isNotEmpty && code3.value.text.isNotEmpty){
                                    setState(() => hasTFA = true);
                                    UserPreferences().saveTFA(hasTFA);
                                    Get.offUntil(GetPageRoute(page: () => const SecuritySettingScreen()), (route) => false);
                                  }
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          )
                        ]
                      )
                    ],
                  )
                )
              ),

              const SizedBox(height: 20),
              SButton(
                text: "Apply Code",
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                textSize: 16,
                onClick: () => apply(),
              ),
              const SizedBox(height: 20),
            ],
          )
        ),
      ),
    );
  }
}