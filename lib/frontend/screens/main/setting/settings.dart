import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool theme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: SText(
              text: "Settings",
              color: Theme.of(context).primaryColor,
              size: 40,
              weight: FontWeight.bold
            ),
            actions: [
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  CupertinoIcons.search_circle_fill,
                  color: SColors.light,
                  size: 40
                )
              )
            ],
            expandedHeight: 300,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SetTab(
                    settingHeader: "Theme Changer",
                    settingDetail: "Toogle between light and dark theme.",
                    widget: IconButton(
                      onPressed: () {
                        if(UserSharedPermits().getSavedThemeMode() == true){
                          setState(() => theme = false);
                          UserSharedPermits().changeThemeMode(theme);
                        } else {
                          setState(() => theme = true);
                          UserSharedPermits().changeThemeMode(theme);
                        }
                      },
                      icon: Icon(CupertinoIcons.moon_fill, color: Theme.of(context).primaryColorLight, size: 22)
                    ),
                    prefixIcon: CupertinoIcons.sparkles,
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingDetail: "Configure your login security and make it more secure.",
                    prefixIcon: CupertinoIcons.shield,
                    settingHeader: "Security and Login",
                    onPressed: () => Get.to(() => const SecuritySettingScreen())
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingDetail: "Check out these faqs. You might find what you are looking for.",
                    prefixIcon: CupertinoIcons.doc_on_doc,
                    settingHeader: "Frequently Asked Questions",
                    onPressed: () => Get.to(() => const FAQSettingScreen())
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingDetail: "Set your preferences the way you want them to be",
                    prefixIcon: CupertinoIcons.settings_solid,
                    settingHeader: "Preferences",
                    onPressed: () => Get.to(() => const PreferenceSettingScreen())
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    prefixIcon: CupertinoIcons.envelope_badge,
                    settingHeader: "Feedback",
                    settingDetail: "Send us a feedback on our services.",
                    onPressed:() => openHelp(context)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingDetail: "Help centre, contact us, policies.",
                    prefixIcon: CupertinoIcons.circle_grid_hex,
                    settingHeader: "Help Centre",
                    onPressed: () => Get.to(() => const HelpSettingScreen())
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    prefixIcon: CupertinoIcons.power,
                    settingHeader: "Sign Out",
                    settingDetail: "Log out of Serch app. We would love to see you again.",
                    onPressed: () => openLogOutAccount(context)
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}