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
  String bio(){
    if(UserSharedPermits().getBiometrics()){
      return "Enabled";
    } else {
      return "Disabled";
    }
  }

  void toogleBiometrics() async {
    final bioStatus = UserSharedPermits().getBiometrics();
    if(bioStatus == false){
      final status = await Biometrics.authenticate();
      if(status){
        setState(() => secured = true);
        UserSharedPermits().saveBiometricsMode(PermitModel(hasBiometrics: secured));
        showGetSnackbar(message: "You have biometrics as a security system now", type: Popup.success);
      } else {
        setState(() => secured = false);
        UserSharedPermits().saveBiometricsMode(PermitModel(hasBiometrics: secured));
        showGetSnackbar(message: "We failed to get your biometrics. Try again please.", type: Popup.error);
      }
    } else {
      final authStatus = await Biometrics.authenticate();
      if(authStatus){
        final status = await Biometrics.auth.stopAuthentication();
        if(status){
          setState(() => secured = false);
          UserSharedPermits().saveBiometricsMode(PermitModel(hasBiometrics: secured));
          showGetSnackbar(message: "You have deactivated biometrics as a security system now", type: Popup.success);
        } else {
          setState(() => secured = true);
          UserSharedPermits().saveBiometricsMode(PermitModel(hasBiometrics: secured));
          showGetSnackbar(message: "We failed to deactivate your biometrics. Try again please.", type: Popup.error);
        }
      } else {
        setState(() => secured = true);
        UserSharedPermits().saveBiometricsMode(PermitModel(hasBiometrics: secured));
        showGetSnackbar(message: "We failed to confirm your biometrics. Try again please.", type: Popup.error);
      }
    }
  }

  bool emailLogin = false;
  String email(){
    if(UserSharedPermits().getEmailSecure() == true){
      return "Enabled";
    } else {
      return "Disabled";
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
              onPressed: () => Get.back(),
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
                    settingDetail: bio(),
                    widget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UserSharedPermits().getBiometrics() ? SColors.green : SColors.hint
                      ),
                    )
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    onPressed: () => {},
                    prefixIcon: Icons.fingerprint_rounded,
                    settingHeader: "Always log in with email",
                    settingDetail: email(),
                    widget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UserSharedPermits().getEmailSecure() ? SColors.green : SColors.hint
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