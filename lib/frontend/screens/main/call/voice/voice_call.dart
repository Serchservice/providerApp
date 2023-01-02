import 'package:flutter/material.dart';
import 'package:provide/lib.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {

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
      userID: currentUserInfo!.serchID!,
      userName: currentUserInfo!.firstName!,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
        ..onHangUpConfirmation = (BuildContext context) async {
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: SText(text: "Are you sure you want to end this call?", color: Theme.of(context).primaryColor, size: 18),
                // content: const Text(
                //     "You can customize this dialog however you like",
                //     style: TextStyle(color: Colors.white70)),
                actions: [
                  SBtn(
                    text: "Yes, am done", textSize: 16,
                    buttonColor: Theme.of(context).scaffoldBackgroundColor,
                    textColor: Theme.of(context).primaryColorDark,
                    onClick: () => Navigator.of(context).pop(true)
                  ),
                  SBtn(
                    text: "No, continue", textSize: 16,
                    onClick: () => Navigator.of(context).pop(false),
                    buttonColor: Theme.of(context).scaffoldBackgroundColor,
                    textColor: Theme.of(context).primaryColorDark,
                  )
                ],
              );
            },
          );
        }
    );
  }
}