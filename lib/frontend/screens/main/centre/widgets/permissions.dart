import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/lib.dart';

class AllPermissions extends StatefulWidget {
  const AllPermissions({super.key});

  @override
  State<AllPermissions> createState() => _AllPermissionsState();
}

class _AllPermissionsState extends State<AllPermissions> {
  bool location = true;
  Future<bool> getLocationPermit() async {
    if(await Permission.location.isGranted){
      setState(() => location = true);
      return true;
    } else {
      setState(() => location = false);
      return false;
    }
  }

  bool storage = false;
  Future<bool> getStoragePermit() async {
    if(await Permission.storage.isGranted){
      setState(() => storage = true);
      return true;
    } else {
      setState(() => storage = false);
      return false;
    }
  }

  bool audio = false;
  Future<bool> getAudioPermit() async {
    if(await Permission.microphone.isGranted){
      setState(() => audio = true);
      return true;
    } else {
      setState(() => audio = false);
      return false;
    }
  }

  bool camera = false;
  Future<bool> getCameraPermit() async {
    if(await Permission.camera.isGranted){
      setState(() => camera = true);
      return true;
    } else {
      setState(() => camera = false);
      return false;
    }
  }

  bool phone = false;
  Future<bool> getPhonePermit() async {
    if(await Permission.phone.isGranted){
      setState(() => phone = true);
      return true;
    } else {
      setState(() => phone = false);
      return false;
    }
  }

  // bool callLog = false;
  // Future<bool> getCallLogPermit() async {
  //   if(await Permission.audio.isGranted){
  //     setState(() => callLog = true);
  //     return true;
  //   } else {
  //     setState(() => callLog = false);
  //     return false;
  //   }
  // }

  bool notification = false;
  Future<bool> getNotificationPermit() async {
    if(await Permission.notification.isGranted){
      setState(() => notification = true);
      return true;
    } else {
      setState(() => notification = false);
      return false;
    }
  }

  void initPermissions() async {
    await getCameraPermit();
    await getAudioPermit();
    await getStoragePermit();
    await getLocationPermit();
    // await getCallLogPermit();
    await getPhonePermit();
    await getNotificationPermit();
  }

  @override
  void initState() {
    initPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SetTab(
          settingHeader: "Location permission",
          settingDetail: location ? "Enabled" : "Disabled",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: location ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        SetTab(
          settingHeader: "Storage access permission",
          settingDetail: storage ? "Enabled" : "Disabled",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: storage ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        SetTab(
          settingHeader: "Microphone permission",
          settingDetail: audio ? "Enabled" : "Disabled",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: audio == true ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        SetTab(
          settingHeader: "Camera permission",
          settingDetail: camera ? "Enabled" : "Disabled",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: camera ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        SetTab(
          settingHeader: "Phone permission",
          settingDetail: phone ? "Enabled" : "Disabled",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: phone ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        // SetTab(
        //   settingHeader: "Call log permission",
        //   settingDetail: callLog ? "Enabled" : "Disabled",
        //   widget: Container(
        //     padding: const EdgeInsets.all(5),
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: callLog ? SColors.green : SColors.hint
        //     ),
        //   )
        // ),
        // const SizedBox(height: 10,),
        SetTab(
          settingHeader: "Notification permission",
          settingDetail: notification ? "Enabled" : "Disabled",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: notification ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
      ]
    );
  }
}