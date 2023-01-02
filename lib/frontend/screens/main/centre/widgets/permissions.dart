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
  bool locationBool = true;
  String locationText(){
    if(locationBool == false){return "off";}
    else{return "on";}
  }

  bool? audioBool;
  String audioText(){
    if(audioBool == false){return "off";}
    else{return "on";}
  }

  void toogleAudio() async {}

  bool cameraBool = false;
  String cameraText(){
    if(cameraBool == false){return "off";}
    else{return "on";}
  }

  void toogleCamera() async {}

  bool? fileBool = false;
  String fileText(){
    if(fileBool == false){return "off";}
    else{return "on";}
  }

  void toogleFile() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SetTab(
          onPressed: () => UserSharedPermits().changeLocationPermit(),
          settingHeader: "Turn ${locationText()} location permission.",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: UserSharedPermits().isLocationGranted() ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        SetTab(
          onPressed: () => toogleFile(),
          settingHeader: "Turn ${fileText()} file access permission.",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: fileBool == true ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        SetTab(
          onPressed: () => toogleAudio(),
          settingHeader: "Turn ${audioText()} audio permission.",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: audioBool == true ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
        SetTab(
          onPressed: () => toogleCamera(),
          settingHeader: "Turn ${cameraText()} camera permission.",
          widget: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cameraBool == true ? SColors.green : SColors.hint
            ),
          )
        ),
        const SizedBox(height: 10,),
      ]
    );
  }
}