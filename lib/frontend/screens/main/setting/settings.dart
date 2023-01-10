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
          SliverAppBar.medium(
            title: SText(
              text: "Settings",
              color: Theme.of(context).primaryColor,
              size: 28,
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
            expandedHeight: 200,
            floating: true,
            snap: true,
            pinned: true,
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
                        if(UserPreferences().getSavedThemeMode() == true){
                          setState(() => theme = false);
                          UserPreferences().changeThemeMode(theme);
                        } else {
                          setState(() => theme = true);
                          UserPreferences().changeThemeMode(theme);
                        }
                      },
                      icon: Icon(CupertinoIcons.moon_fill, color: Theme.of(context).primaryColorLight, size: 22)
                    ),
                    prefixIcon: CupertinoIcons.sparkles,
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingDetail: "Configure your account security to make it stronger.",
                    prefixIcon: CupertinoIcons.shield,
                    settingHeader: "Security and Login",
                    onPressed: () => Get.to(() => const SecuritySettingScreen())
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingDetail: "Check out these faqs, you might find what you are looking for.",
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
                    settingDetail: "Network usage, storage location",
                    prefixIcon: Icons.storage,
                    settingHeader: "Storage and data",
                    onPressed: () => Get.to(() => const HelpSettingScreen())
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingDetail: "(phone's language)",
                    prefixIcon: Icons.public,
                    settingHeader: "App Language",
                    onPressed: () => Get.to(() => const HelpSettingScreen())
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}