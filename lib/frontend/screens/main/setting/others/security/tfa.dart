import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class TFAScreen extends StatelessWidget {
  const TFAScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Two-step verification", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: Get.width,
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 150, width: 150,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(SImages.security),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SText.center(
                      text: "For extra security, turn on two-step verification, which will require a pin when registering your email with Serch again",
                      color: Theme.of(context).primaryColorLight,
                      size: 16
                    )
                  ],
                ),
              ),
              SButton(
                text: "Enable",
                padding: const EdgeInsets.all(20),
                width: Get.width,
                textSize: 16,
                onClick: () => Get.to(() => const TFACreateCodeScreen()),
              )
            ]
          ),
        )
      ),
    );
  }
}

class HasTFAScreen extends StatefulWidget {
  const HasTFAScreen({super.key});

  @override
  State<HasTFAScreen> createState() => _HasTFAScreenState();
}

class _HasTFAScreenState extends State<HasTFAScreen> {
  bool hasTFA = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Two-step verification", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: Get.width,
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 150, width: 150,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(SImages.security),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(Icons.check_circle, size: 60, color: Scolors.success,)
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SText(
                    text: "Two-step verification is on. You'll need to enter your PIN if you register your account on Serch again.",
                    color: Theme.of(context).primaryColorLight, size: 16
                  )
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SetTab(
                    settingHeader: "Disable",
                    prefixIcon: Icons.cancel,
                    onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          title: SText(text: "Want to disable two-step verification?", color: Theme.of(context).primaryColor, size: 18),
                          actions: [
                            SBtn(
                              text: "Disable", textSize: 16,
                              buttonColor: Theme.of(context).scaffoldBackgroundColor,
                              textColor: Theme.of(context).primaryColorDark,
                              onClick: () {
                                setState(() => hasTFA = false);
                                UserPreferences().saveTFA(hasTFA);
                                Get.offUntil(GetPageRoute(page: () => const SecuritySettingScreen()), (route) => false);
                                // Navigator.of(context).pop(true);
                              }
                            ),
                            SBtn(
                              text: "Cancel", textSize: 16,
                              onClick: () => Navigator.of(context).pop(false),
                              buttonColor: Theme.of(context).scaffoldBackgroundColor,
                              textColor: Theme.of(context).primaryColorDark,
                            )
                          ],
                        );
                      }
                    )
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Change PIN",
                    prefixIcon: Icons.password,
                    onPressed: () => Get.to(() => const TFACreateCodeScreen())
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ]
          ),
        )
      ),
    );
  }
}