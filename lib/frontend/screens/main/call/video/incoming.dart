import 'package:flutter/material.dart';
import 'package:provide/lib.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallInvitationPage extends StatefulWidget {
  const CallInvitationPage({Key? key}) : super(key: key);

  @override
  State<CallInvitationPage> createState() => _CallInvitationPageState();
}

class _CallInvitationPageState extends State<CallInvitationPage> {
  final TextEditingController inviteeUsersIDTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    SerchUser.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCallWithInvitation(
      appID: zegoAppID,
      appSign: zegoAppSign,
      userID: currentUserInfo!.serchID!,
      userName: currentUserInfo!.firstName!,
      // Modify your custom configurations here.
      ringtoneConfig: const ZegoRingtoneConfig(
        incomingCallPath: "assets/ringtone/incomingCallRingtone.mp3",
        outgoingCallPath: "assets/ringtone/outgoingCallRingtone.mp3",
      ),
      requireConfig: (ZegoCallInvitationData data) {
        var config = (data.invitees.length > 1)
            ? ZegoInvitationType.videoCall == data.type
                ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoInvitationType.videoCall == data.type
                ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        return config;
      },
      plugins: const [],
      child: Column(),
    );
  }
}