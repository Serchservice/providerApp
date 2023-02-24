import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provide/lib.dart';

class FingerPrintAuthScreen extends StatefulWidget {
  const FingerPrintAuthScreen({super.key});

  @override
  State<FingerPrintAuthScreen> createState() => _FingerPrintAuthScreenState();
}

class _FingerPrintAuthScreenState extends State<FingerPrintAuthScreen> {
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  bool bioError = false, bioCorrect = false;
  bool secured = false;

  @override
  void initState() {
    super.initState();
    initializeAuth();
  }

  void initializeAuth() async {
    if(userSettingModel.biometrics == false){
      final status = await Biometrics.authenticate();
      if(status){
        try {
          setState(() => secured = true);
          await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
          showGetSnackbar(message: "You have biometrics as a security system now", type: Popup.success);
        } on PostgrestException catch (e) {
          showGetSnackbar(message: e.message, type: Popup.error);
        }
      } else {
        try {
          setState(() => secured = false);
          await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
          showGetSnackbar(message: "We failed to get your biometrics. Try again please.", type: Popup.error);
        } on PostgrestException catch (e) {
          showGetSnackbar(message: e.message, type: Popup.error);
        }
      }
    } else {
      final authStatus = await Biometrics.authenticate();
      if(authStatus){
        final status = await Biometrics.auth.stopAuthentication();
        if(status){
          try {
            setState(() => secured = false);
            await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
            showGetSnackbar(message: "You have deactivated biometrics as a security system now", type: Popup.success);
          } on PostgrestException catch (e) {
            showGetSnackbar(message: e.message, type: Popup.error);
          }
        } else {
          try {
            setState(() => secured = true);
            await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
            showGetSnackbar(message: "We failed to deactivate your biometrics. Try again please.", type: Popup.error);
          } on PostgrestException catch (e) {
            showGetSnackbar(message: e.message, type: Popup.error);
          }
        }
      } else {
        try {
          setState(() => secured = true);
          await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
          showGetSnackbar(message: "We failed to confirm your biometrics. Try again please.", type: Popup.error);
        } on PostgrestException catch (e) {
          showGetSnackbar(message: e.message, type: Popup.error);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(SImages.logoName, width: 130, color: Theme.of(context).primaryColor)),
              if (bioCorrect) Image.asset(SImages.fingerPrintSuccess, width: 150)
              else if(bioError) Image.asset(SImages.fingerPrintFail, width: 150)
              else Icon(Icons.fingerprint_rounded, size: 60, color: Theme.of(context).primaryColor,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}