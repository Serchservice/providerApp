import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class SecuritySettingScreen extends StatefulWidget {
  const SecuritySettingScreen({super.key});

  @override
  State<SecuritySettingScreen> createState() => _SecuritySettingScreenState();
}

class _SecuritySettingScreenState extends State<SecuritySettingScreen> {
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  bool secured = false;
  void toogleBiometrics() async {
    Get.to(() => const FingerPrintAuthScreen());
    // if(userSettingModel.biometrics == false){
    //   final status = await Biometrics.authenticate();
    //   if(status){
    //     try {
    //       setState(() => secured = true);
    //       await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
    //       showGetSnackbar(message: "You have biometrics as a security system now", type: Popup.success);
    //     } on PostgrestException catch (e) {
    //       showGetSnackbar(message: e.message, type: Popup.error);
    //     }
    //   } else {
    //     try {
    //       setState(() => secured = false);
    //       await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
    //       showGetSnackbar(message: "We failed to get your biometrics. Try again please.", type: Popup.error);
    //     } on PostgrestException catch (e) {
    //       showGetSnackbar(message: e.message, type: Popup.error);
    //     }
    //   }
    // } else {
    //   final authStatus = await Biometrics.authenticate();
    //   if(authStatus){
    //     final status = await Biometrics.auth.stopAuthentication();
    //     if(status){
    //       try {
    //         setState(() => secured = false);
    //         await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
    //         showGetSnackbar(message: "You have deactivated biometrics as a security system now", type: Popup.success);
    //       } on PostgrestException catch (e) {
    //         showGetSnackbar(message: e.message, type: Popup.error);
    //       }
    //     } else {
    //       try {
    //         setState(() => secured = true);
    //         await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
    //         showGetSnackbar(message: "We failed to deactivate your biometrics. Try again please.", type: Popup.error);
    //       } on PostgrestException catch (e) {
    //         showGetSnackbar(message: e.message, type: Popup.error);
    //       }
    //     }
    //   } else {
    //     try {
    //       setState(() => secured = true);
    //       await supabase.from(Supa().setting).update({"biometrics": secured}).eq("serchID", userInformationModel.serchID);
    //       showGetSnackbar(message: "We failed to confirm your biometrics. Try again please.", type: Popup.error);
    //     } on PostgrestException catch (e) {
    //       showGetSnackbar(message: e.message, type: Popup.error);
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            title: SText.center(
              text: "Security and Login Setting",
              size: 24,
              weight: FontWeight.bold,
              color: Theme.of(context).primaryColorLight
            ),
            leading: IconButton(
              onPressed: () => Get.offAll(() => const BottomNavigator(newPage: 3)),
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: Theme.of(context).primaryColorLight,
                size: 28
              )
            ),
            expandedHeight: 200,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SetTab(
                    prefixIcon: Icons.fingerprint_rounded,
                    onPressed: () => toogleBiometrics(),
                    settingHeader: "Biometrics Authentication",
                    settingDetail: userSettingModel.biometrics ? "Enabled" : "Disabled",
                    widget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: userSettingModel.biometrics ? SColors.green : SColors.hint
                      ),
                    )
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Change Password",
                    settingDetail: "Change your password to a different one.",
                    prefixIcon: CupertinoIcons.padlock,
                    onPressed: () => Get.to(() => const ChangePasswordScreen())
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Two-step verification",
                    settingDetail: userSettingModel.tfa ? "Enabled" : "Disabled",
                    prefixIcon: CupertinoIcons.padlock,
                    onPressed: () {
                      userSettingModel.tfa ? Get.to(() => const HasTFAScreen()) : Get.to(() => const TFAScreen());
                    },
                    widget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: userSettingModel.tfa ? SColors.green : SColors.hint
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}