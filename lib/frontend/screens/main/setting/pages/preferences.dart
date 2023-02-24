import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Setting{
  final IconData icon;
  final String header;
  final String? subtitle;
  final bool value;
  final void Function(bool) onChanged;

  Setting({required this.header, required this.icon, this.subtitle, required this.value, required this.onChanged});
}

class PreferenceSettingScreen extends StatefulWidget {
  const PreferenceSettingScreen({super.key});

  @override
  State<PreferenceSettingScreen> createState() => _PreferenceSettingScreenState();
}

class _PreferenceSettingScreenState extends State<PreferenceSettingScreen> {
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  late final Stream<UserSettingModel> _settingStream;

  @override
    void initState() {
    super.initState();
    _settingStream = supabase.from(Supa().setting).stream(primaryKey: ['id']).eq("serchID", userInformationModel.serchID).map(
      (maps) => maps.map((map) => UserSettingModel.fromMap(map)).toList()
    ).map((list) => list.first);
  }

  Future showOnMap() async {
    final setting = await _settingStream.first;
    if(setting.showOnMap) {
      await supabase.from(Supa().setting).update({"showOnMap": false}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveSettingData(setting.copyWith(showOnMap: false));
    } else {
      await supabase.from(Supa().setting).update({"showOnMap": true}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveSettingData(setting.copyWith(showOnMap: true));
    }
  }

  Future alwaysOnline() async {
    final setting = await _settingStream.first;
    if(setting.alwaysOnline) {
      await supabase.from(Supa().setting).update({"alwaysOnline": false}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveSettingData(setting.copyWith(alwaysOnline: false));
    } else {
      await supabase.from(Supa().setting).update({"alwaysOnline": true}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveSettingData(setting.copyWith(alwaysOnline: true));
    }
  }

  Future swm() async {
    final setting = await _settingStream.first;
    if(setting.swm) {
      await supabase.from(Supa().setting).update({"swm": false}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveSettingData(setting.copyWith(swm: false));
    } else {
      await supabase.from(Supa().setting).update({"swm": true}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveSettingData(setting.copyWith(swm: true));
    }
  }


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

  void toggleAlwaysOnline(val) async {
    try {
      if(UserPreferences().getShowAlwaysOnline()){
        setState(() => val = false);
        await supabase.from(Supa().setting).update({"alwaysOnline": val}).eq("serchID", userInformationModel.serchID);
        UserPreferences().saveShowAlwaysOnline(val);
      } else {
        setState(() => val = true);
        await supabase.from(Supa().setting).update({"alwaysOnline": val}).eq("serchID", userInformationModel.serchID);
        UserPreferences().saveShowAlwaysOnline(val);
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            title: SText.center(text: "Preference Settings", size: 24, weight: FontWeight.bold, color: Theme.of(context).primaryColorLight),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(CupertinoIcons.chevron_back, color: Theme.of(context).primaryColorLight, size: 28)
            ),
            expandedHeight: 200,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SText(
                      text: "Notification Preference",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  Column(
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
                      const SizedBox(height: 10,)
                    ]
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SText(
                      text: "Connection Preference",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),

                  StreamBuilder<UserSettingModel>(
                    stream: _settingStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        final setting = snapshot.data!;
                        HiveUserDatabase().saveSettingData(setting);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SetTab(
                            iconColor: setting.showOnMap ? SColors.green : null,
                            prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                            settingHeader: "Show me on map when busy",
                            settingDetail: setting.showOnMap ? "Enabled" : "Disabled",
                            widget: Switch(
                              inactiveThumbColor: SColors.hint,
                              inactiveTrackColor: SColors.grey,
                              activeColor: SColors.lightPurple,
                              value: setting.showOnMap,
                              onChanged: (val) => showOnMap()
                            )
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SetTab(
                            iconColor: userSettingModel.showOnMap ? SColors.green : null,
                            prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                            settingHeader: "Show me on map when busy",
                            settingDetail: userSettingModel.showOnMap ? "Enabled" : "Disabled",
                            widget: Switch(
                              inactiveThumbColor: SColors.hint,
                              inactiveTrackColor: SColors.grey,
                              activeColor: SColors.lightPurple,
                              value: userSettingModel.showOnMap,
                              onChanged: (val) => showOnMap()
                            )
                          ),
                        );
                      }
                    }
                  ),

                  StreamBuilder<UserSettingModel>(
                    stream: _settingStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        final setting = snapshot.data!;
                        HiveUserDatabase().saveSettingData(setting);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SetTab(
                            iconColor: setting.alwaysOnline ? SColors.green : null,
                            prefixIcon: CupertinoIcons.bolt_circle,
                            settingHeader: "Appear online on app launch",
                            settingDetail: setting.alwaysOnline ? "Enabled" : "Disabled",
                            widget: Switch(
                              inactiveThumbColor: SColors.hint,
                              inactiveTrackColor: SColors.grey,
                              activeColor: SColors.lightPurple,
                              value: setting.alwaysOnline,
                              onChanged: (val) => alwaysOnline()
                            )
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SetTab(
                            iconColor: userSettingModel.alwaysOnline ? SColors.green : null,
                            prefixIcon: CupertinoIcons.bolt_circle,
                            settingHeader: "Appear online on app launch",
                            settingDetail: userSettingModel.alwaysOnline ? "Enabled" : "Disabled",
                            widget: Switch(
                              inactiveThumbColor: SColors.hint,
                              inactiveTrackColor: SColors.grey,
                              activeColor: SColors.lightPurple,
                              value: userSettingModel.alwaysOnline,
                              onChanged: (val) => alwaysOnline()
                            )
                          ),
                        );
                      }
                    }
                  ),

                  StreamBuilder<UserSettingModel>(
                    stream: _settingStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        final setting = snapshot.data!;
                        HiveUserDatabase().saveSettingData(setting);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SetTab(
                            iconColor: setting.swm ? SColors.green : null,
                            prefixIcon: CupertinoIcons.location,
                            settingHeader: "Always connect Stick-with-me",
                            settingDetail: setting.swm ? "Enabled" : "Disabled",
                            widget: Switch(
                              inactiveThumbColor: SColors.hint,
                              inactiveTrackColor: SColors.grey,
                              activeColor: SColors.lightPurple,
                              value: setting.swm,
                              onChanged: (val) => swm()
                            )
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SetTab(
                            iconColor: userSettingModel.swm ? SColors.green : null,
                            prefixIcon: CupertinoIcons.location,
                            settingHeader: "Always connect Stick-with-me",
                            settingDetail: userSettingModel.swm ? "Enabled" : "Disabled",
                            widget: Switch(
                              inactiveThumbColor: SColors.hint,
                              inactiveTrackColor: SColors.grey,
                              activeColor: SColors.lightPurple,
                              value: userSettingModel.swm,
                              onChanged: (val) => swm()
                            )
                          ),
                        );
                      }
                    }
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}