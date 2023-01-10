import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class T2FCallScreen extends StatefulWidget {
  const T2FCallScreen({super.key});

  @override
  State<T2FCallScreen> createState() => _T2FCallScreenState();
}

class _T2FCallScreenState extends State<T2FCallScreen> {

  @override
  void initState() {
    super.initState();
    SerchUser.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppID,
      appSign: zegoAppSign,
      callID: "123456",
      userID: "ieoyquoqw",
      userName: "Evaristus",
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..layout = ZegoLayout.pictureInPicture(
          switchLargeOrSmallViewByClick: true,
        )
        ..onHangUpConfirmation = (BuildContext context) async {
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                title: SText(text: "Are you sure you want to end this call?", color: Theme.of(context).primaryColor, size: 18),
                // content: const Text(
                //     "You can customize this dialog however you like",
                //     style: TextStyle(color: Colors.white70)),
                actions: [
                  SBtn(
                    text: "Yes, am done", textSize: 16,
                    buttonColor: Theme.of(context).backgroundColor,
                    textColor: SColors.lightPurple,
                    onClick: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Theme.of(context).backgroundColor,
                            elevation: 0,
                            title: SText(text: "Feel like adding an extra tip?", color: Theme.of(context).primaryColor, size: 18),
                            // content: const Text(
                            //     "You can customize this dialog however you like",
                            //     style: TextStyle(color: Colors.white70)),
                            actions: [
                              SBtn(
                                text: "Definitely", textSize: 16,
                                buttonColor: Theme.of(context).backgroundColor,
                                textColor: SColors.lightPurple,
                                onClick: () => addExtraTip(context)
                              ),
                              SBtn(
                                text: "Not really", textSize: 16,
                                onClick: () => Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false),
                                buttonColor: Theme.of(context).backgroundColor,
                                textColor: SColors.lightPurple,
                              )
                            ],
                          );
                        },
                      );
                    }
                  ),
                  SBtn(
                    text: "No, continue", textSize: 16,
                    onClick: () => Navigator.of(context).pop(false),
                    buttonColor: Theme.of(context).backgroundColor,
                    textColor: SColors.lightPurple,
                  )
                ],
              );
            },
          );
        }
        ..turnOnMicrophoneWhenJoining = true
        ..useSpeakerWhenJoining = false
        ..turnOnCameraWhenJoining = true,
    );
  }
}

void addExtraTip(context) {
  final amount = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: StatefulBuilder(
        builder:(context, setState) => Container(
          padding: screenPadding,
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SText(
                      text: "Enter extra tip amount",
                      size: 20,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SFormField(
                            labelText: "5,000",
                            formName: "Extra Tip Amount",
                            controller: amount,
                            cursorColor: Theme.of(context).primaryColor,
                            fillColor: Theme.of(context).backgroundColor,
                            formStyle: STexts.normalForm(context),
                            formColor: Theme.of(context).primaryColor,
                            enabledBorderColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 20),
                          SButton(
                            text: "Tip2Fix",
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12.0),
                            textWeight: FontWeight.bold,
                            textSize: 18,
                            onClick: () {
                              Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false);
                            },
                          ),
                          const SizedBox(height: 10),
                          SButton(
                            text: "Cancel",
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12.0),
                            textWeight: FontWeight.bold,
                            textSize: 18,
                            onClick: () {
                              Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false);
                            },
                          ),
                        ]
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      ),
    )
  );
}