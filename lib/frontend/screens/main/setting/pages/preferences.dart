import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class PreferenceSettingScreen extends StatefulWidget {
  const PreferenceSettingScreen({super.key});

  @override
  State<PreferenceSettingScreen> createState() => _PreferenceSettingScreenState();
}

class _PreferenceSettingScreenState extends State<PreferenceSettingScreen> {
  bool chat = false;
  void toggleChatNotification(val) {
    if(UserPermissions().getChatNotificationPermit()){
      setState(() => chat = false);
      UserPermissions().saveChatNotificationPermit(chat);
    } else {
      setState(() => chat = true);
      UserPermissions().saveChatNotificationPermit(chat);
    }
  }

  bool call = false;
  void toggleCallNotification(val) {
    if(UserPermissions().getCallNotificationPermit()){
      setState(() => call = false);
      UserPermissions().saveCallNotificationPermit(call);
    } else {
      setState(() => call = true);
      UserPermissions().saveCallNotificationPermit(call);
    }
  }

  bool other = false;
  void togglePushNotification(val) {
    if(UserPermissions().getPushNotificationPermit()){
      setState(() => other = false);
      UserPermissions().savePushNotificationPermit(other);
    } else {
      setState(() => other = true);
      UserPermissions().savePushNotificationPermit(other);
    }
  }

  bool showOnMap = false;
  void toggleShowOnMap(val) {
    if(UserPreferences().getShowOnMap()){
      setState(() => showOnMap = false);
      UserPreferences().saveShowOnMap(showOnMap);
    } else {
      setState(() => showOnMap = true);
      UserPreferences().saveShowOnMap(showOnMap);
    }
  }

  bool alwaysOnline = false;
  void toggleAlwaysOnline(val) {
    if(UserPreferences().getShowAlwaysOnline()){
      setState(() => alwaysOnline = false);
      UserPreferences().saveShowAlwaysOnline(alwaysOnline);
    } else {
      setState(() => alwaysOnline = true);
      UserPreferences().saveShowAlwaysOnline(alwaysOnline);
    }
  }

  bool onSWM = false;
  void toggleSWM(val) {
    if(UserPreferences().getSWM()){
      setState(() => onSWM = false);
      UserPreferences().saveSWM(onSWM);
    } else {
      setState(() => onSWM = true);
      UserPreferences().saveSWM(onSWM);
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
              text: "Preference Settings",
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
                    iconColor: UserPermissions().getChatNotificationPermit() ? SColors.green : null,
                    prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                    settingHeader: "Notify me when I get a message",
                    settingDetail: UserPermissions().getChatNotificationPermit() ? "Enabled" : "Disabled",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserPermissions().getChatNotificationPermit(),
                      onChanged: (val) => toggleChatNotification(val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    iconColor: UserPermissions().getCallNotificationPermit() ? SColors.green : null,
                    prefixIcon: CupertinoIcons.phone,
                    settingHeader: "Alert me when a call comes in",
                    settingDetail: UserPermissions().getCallNotificationPermit() ? "Enabled" : "Disabled",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserPermissions().getCallNotificationPermit(),
                      onChanged: (val) => toggleCallNotification(val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    iconColor: UserPermissions().getPushNotificationPermit() ? SColors.green : null,
                    prefixIcon: CupertinoIcons.bell,
                    settingHeader: "Notification for other information",
                    settingDetail: UserPermissions().getPushNotificationPermit() ? "Enabled" : "Disabled",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserPermissions().getPushNotificationPermit(),
                      onChanged: (val) => togglePushNotification(val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    iconColor: UserPreferences().getShowOnMap() ? SColors.green : null,
                    prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                    settingHeader: "Show me on map when busy",
                    settingDetail: UserPreferences().getShowOnMap() ? "Enabled" : "Disabled",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserPreferences().getShowOnMap(),
                      onChanged: (val) => toggleShowOnMap(val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.bolt_circle,
                    iconColor: UserPreferences().getShowAlwaysOnline() ? SColors.green : null,
                    settingHeader: "Appear online on app launch",
                    settingDetail: UserPreferences().getShowAlwaysOnline() ? "Enabled" : "Disabled",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserPreferences().getShowAlwaysOnline(),
                      onChanged: (val) => toggleAlwaysOnline(val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.location,
                    iconColor: UserPreferences().getSWM() ? Scolors.success : null,
                    settingHeader: "Always connect Stick-With-Me",
                    settingDetail: UserPreferences().getSWM() ? "Enabled" : "Disabled",
                    widget: Switch(
                      value: UserPreferences().getSWM(),
                      activeColor: SColors.lightPurple,
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      onChanged: (val) => toggleSWM(val)
                    )
                  ),
                  const SizedBox(height: 100),
                ]
              )
            ),
          ),
        ],
      )
    );
  }
}