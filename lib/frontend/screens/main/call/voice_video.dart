import 'package:flutter/material.dart';
import 'package:provide/lib.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallInvitationPage extends StatefulWidget {
  final bool videoCall;
  final String targetID;
  final String targetName;
  final void Function(String, String, List<String>) onPressed;
  const CallInvitationPage({
    super.key, required this.videoCall, required this.targetID, required this.targetName, required this.onPressed
  });

  @override
  State<CallInvitationPage> createState() => _CallInvitationPageState();
}

class _CallInvitationPageState extends State<CallInvitationPage> {
  final TextEditingController inviteeUsersIDTextCtrl = TextEditingController();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCallWithInvitation(
      appID: zegoAppID,
      appSign: zegoAppSign,
      userID: userInformationModel.serchID,
      userName: userInformationModel.firstName,
      // Modify your custom configurations here.
      ringtoneConfig: const ZegoRingtoneConfig(
        incomingCallPath: SAudios.incomingRingtone,
        outgoingCallPath: SAudios.outgoingRingtone,
      ),
      requireConfig: (ZegoCallInvitationData data) {
        // var config = (data.invitees.length > 1) ? ZegoInvitationType.videoCall == data.type
        // ? ZegoUIKitPrebuiltCallConfig.groupVideoCall() : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
        // : ZegoInvitationType.videoCall == data.type ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        // : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
        var config = ZegoUIKitPrebuiltCallConfig();
        config.turnOnCameraWhenJoining = ZegoInvitationType.videoCall == data.type;
        config.onOnlySelfInRoom = (context) => Navigator.of(context).pop();
        config.turnOnMicrophoneWhenJoining = ZegoInvitationType.videoCall == data.type && ZegoInvitationType.voiceCall == data.type;
        // if (ZegoInvitationType.videoCall == data.type) {
        //   config.bottomMenuBarConfig.extendButtons = [
        //     IconButton(color: Colors.white, icon: const Icon(Icons.phone), onPressed:() {}),
        //     IconButton(color: Colors.white, icon: const Icon(Icons.cookie), onPressed:() {}),
        //     IconButton(color: Colors.white, icon: const Icon(Icons.speaker), onPressed:() {}),
        //     IconButton(color: Colors.white, icon: const Icon(Icons.air), onPressed:() {}),
        //   ];
        // } else if(ZegoInvitationType.voiceCall == data.type){

        // }
        return config;
      },
      plugins: const [],
      child: startCall(
        videoCall: widget.videoCall,
        targetID: widget.targetID,
        targetName: widget.targetName,
        onPressed: widget.onPressed
      )
    );
  }
}

Widget startCall({
  required bool videoCall, required String targetID, required String targetName,
  required void Function(String, String, List<String>) onPressed}) {
  return ZegoStartCallInvitationButton(
    isVideoCall: videoCall, onPressed: onPressed,
    invitees: [
      ZegoUIKitUser(id: targetID, name: targetName)
    ],
  );
}

Widget receiveCall({required String inviterID, required void Function(String, String)? onPressed}) {
  return ZegoAcceptInvitationButton(inviterID: inviterID, onPressed: onPressed,);
}

// ZegoCallDelegate callDelegate = new ZegoCallDelegate(
//   onIncomingCall: (String roomID, String userID, String userName, String userAvatar) {
//     // This callback will be called when an incoming call is received.
//     // You can show a dialog to ask the user whether to accept the call or not.
//   },
//   onCallEnd: (String roomID, String userID, String userName, String userAvatar) {
//     // This callback will be called when a call ends.
//     // You can hide the call UI and do any necessary cleanup.
//   },
// );
// ZegoUIKitPrebuiltCall.delegate = callDelegate;
// ZegoUIKitPrebuiltCall.accept(roomID);

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  final callID = CodeGenerator.generateCallID();
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppID,
      appSign: zegoAppSign,
      callID: callID,
      userID: userInformationModel.serchID,
      userName: userInformationModel.firstName,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..layout = ZegoLayout.pictureInPicture(
          switchLargeOrSmallViewByClick: true,
        )
        ..turnOnMicrophoneWhenJoining = true
        ..useSpeakerWhenJoining = false
        ..turnOnCameraWhenJoining = true
        ..avatarBuilder
        ..onOnlySelfInRoom = (context) {
          Navigator.of(context).pop();
        }
        ..onHangUpConfirmation = (BuildContext context) => endCall(context),
    );
  }
}

class T2FCallScreen extends StatefulWidget {
  const T2FCallScreen({super.key});

  @override
  State<T2FCallScreen> createState() => _T2FCallScreenState();
}

class _T2FCallScreenState extends State<T2FCallScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  final callID = CodeGenerator.generateCallID();
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppID,
      appSign: zegoAppSign,
      callID: callID,
      userID: userInformationModel.serchID,
      userName: userInformationModel.firstName,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..layout = ZegoLayout.pictureInPicture(
          switchLargeOrSmallViewByClick: true,
        )
        ..turnOnMicrophoneWhenJoining = true
        ..useSpeakerWhenJoining = false
        ..turnOnCameraWhenJoining = true
        ..onOnlySelfInRoom = (context) {
          Navigator.of(context).pop();
        }
        ..onHangUpConfirmation = (BuildContext context) async => endT2FVideoCall(context),
    );
  }
}

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  final callID = CodeGenerator.generateCallID();
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppID,
      appSign: zegoAppSign,
      callID: callID,
      userID: userInformationModel.serchID,
      userName: userInformationModel.firstName,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
        ..onOnlySelfInRoom = (context) {
          Navigator.of(context).pop();
        }
        ..onHangUpConfirmation = (BuildContext context) => endCall(context)
    );
  }
}