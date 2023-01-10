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
  bool secured = false;
  void toogleBiometrics() async {
    final bioStatus = UserPreferences().getBiometrics();
    if(bioStatus == false){
      final status = await Biometrics.authenticate();
      if(status){
        setState(() => secured = true);
        UserPreferences().saveBiometrics(secured);
        showGetSnackbar(message: "You have biometrics as a security system now", type: Popup.success);
      } else {
        setState(() => secured = false);
        UserPreferences().saveBiometrics(secured);
        showGetSnackbar(message: "We failed to get your biometrics. Try again please.", type: Popup.error);
      }
    } else {
      final authStatus = await Biometrics.authenticate();
      if(authStatus){
        final status = await Biometrics.auth.stopAuthentication();
        if(status){
          setState(() => secured = false);
          UserPreferences().saveBiometrics(secured);
          showGetSnackbar(message: "You have deactivated biometrics as a security system now", type: Popup.success);
        } else {
          setState(() => secured = true);
          UserPreferences().saveBiometrics(secured);
          showGetSnackbar(message: "We failed to deactivate your biometrics. Try again please.", type: Popup.error);
        }
      } else {
        setState(() => secured = true);
        UserPreferences().saveBiometrics(secured);
        showGetSnackbar(message: "We failed to confirm your biometrics. Try again please.", type: Popup.error);
      }
    }
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
                    settingDetail: UserPreferences().getBiometrics() ? "Enabled" : "Disabled",
                    widget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UserPreferences().getBiometrics() ? SColors.green : SColors.hint
                      ),
                    )
                  ),
                  // const SizedBox(height: 10),
                  // SetTab(
                  //   onPressed: () => {},
                  //   prefixIcon: Icons.fingerprint_rounded,
                  //   settingHeader: "Always log in with email",
                  //   settingDetail: email(),
                  //   widget: Container(
                  //     padding: const EdgeInsets.all(8),
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: UserSharedPermits().getEmailSecure() ? SColors.green : SColors.hint
                  //     ),
                  //   )
                  // ),
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
                    settingDetail: UserPreferences().getTFA() ? "Enabled" : "Disabled",
                    prefixIcon: CupertinoIcons.padlock,
                    onPressed: () {
                      UserPreferences().getTFA() ? Get.to(() => const HasTFAScreen()) : Get.to(() => const TFAScreen());
                    },
                    widget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UserPreferences().getTFA() ? SColors.green : SColors.hint
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