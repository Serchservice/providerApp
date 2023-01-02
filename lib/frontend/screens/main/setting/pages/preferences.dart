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
  bool showOnMapbool = false;
  bool onSWMbool = false;
  bool callbool = false;
  bool chatbool = false;
  bool otherbool = false;
  bool showAppBadge = false;
  bool alwaysOnlinebool = false;

  void toggleAppBadge(bool newValue){
    setState(() => showAppBadge = newValue);
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
                    prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                    settingHeader: UserSharedPermits().getChatNotification() ? "Don't nofity me when I get a message" : "Notify me when I get a message",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserSharedPermits().getChatNotification(),
                      onChanged: (val) async {
                        // final notifyStatus = UserSharedPermits().getChatNotification();
                        // if(notifyStatus){

                        // } else {
                        //   final permit = UserNotifications.notifications
                        //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>
                        //     ()!.requestPermission();
                        //   if(permit == ){}
                        // }
                        setState(() => chatbool = val);
                      }
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.phone,
                    settingHeader: UserSharedPermits().getCallNotification() ? "Don't alert me on calls" : "Alert me when a call comes in",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserSharedPermits().getCallNotification(),
                      onChanged: (val) => setState(() => callbool = val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.bell,
                    settingHeader: "${UserSharedPermits().getOtherNotification() ? "Disable" : "Enable"} notification for other information",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserSharedPermits().getOtherNotification(),
                      onChanged: (val) => setState(() => otherbool = val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                    settingHeader: UserSharedPermits().getShowOnMap() ? "Don't show me on map when busy" : "Show me on map when busy",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserSharedPermits().getShowOnMap(),
                      onChanged: (val) => setState(() => showOnMapbool = val)
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.bolt_circle,
                    iconColor: UserSharedPermits().getAlwaysOnline() ? SColors.green : null,
                    settingHeader: UserSharedPermits().getAlwaysOnline() ? "Manually go online when I want." : "Appear online on app launch",
                    widget: Switch(
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      activeColor: SColors.lightPurple,
                      value: UserSharedPermits().getAlwaysOnline(),
                      onChanged: (val) {
                        setState(() => alwaysOnlinebool = val);
                        UserSharedPermits().saveAlwaysOnlineMode(PermitModel(alwaysOnline: alwaysOnlinebool));
                      }
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.location,
                    iconColor: UserSharedPermits().getSWM() ? Scolors.success : null,
                    settingHeader: UserSharedPermits().getSWM() ? "Manually connect Stick-With-Me" : "Always connect Stick-With-Me",
                    widget: Switch(
                      value: UserSharedPermits().getSWM(),
                      activeColor: SColors.lightPurple,
                      inactiveThumbColor: SColors.hint,
                      inactiveTrackColor: SColors.grey,
                      onChanged: (swm) {
                        var status = UserSharedPermits().getSWM();
                        setState(() => status = swm);
                        UserSharedPermits().saveSWMMode(PermitModel(onSWM: status));
                      },
                    )
                  ),
                  const SizedBox(height: 10,),
                  SetTab(
                    prefixIcon: CupertinoIcons.app_badge,
                    iconColor: UserSharedPermits().getShowAppBadge() ? SColors.yellow : null,
                    settingHeader: "${UserSharedPermits().getShowAppBadge() ? "Don't allow" : "Allow"} app badge for notifications",
                    widget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UserSharedPermits().getShowAppBadge() ? SColors.green : SColors.hint
                      ),
                    ),
                    onPressed: () {
                      final status = UserSharedPermits().getShowAppBadge();
                      if(status){
                        setState(() => showAppBadge = false);
                        UserSharedPermits().saveShowAppBadgeMode(PermitModel(showAppBadge: showAppBadge));
                      } else {
                        setState(() => showAppBadge = true);
                        UserSharedPermits().saveShowAppBadgeMode(PermitModel(showAppBadge: showAppBadge));
                      }
                    },
                    // widget: Switch(
                    //   value: UserSharedPermits().getShowAppBadge(),
                    //   // value: showAppBadge,
                    //   activeColor: SColors.lightPurple,
                    //   inactiveThumbColor: SColors.hint,
                    //   inactiveTrackColor: SColors.grey,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       showAppBadge = newValue;
                    //       UserSharedPermits().saveShowAppBadgeMode(PermitModel(showAppBadge: showAppBadge));
                    //     });
                    //     // setState(() => UserSharedPermits().getShowAppBadge() ? false : true);
                    //     // UserSharedPermits().saveShowAppBadgeMode(PermitModel(showAppBadge: UserSharedPermits().getShowAppBadge()));
                    //   },
                    // )
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