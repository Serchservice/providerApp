import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provide/lib.dart';

class HiveStorage{
  var path = Directory.current.path;

  // Future<Directory> getDirectory() async {
  //   Directory? directory = await getExternalStorageDirectory();
  //   const String pathExt = '/serchDb/';
  //   Directory newDirectory = Directory(directory!.path + pathExt);
  //   if (await newDirectory.exists() == false) {
  //     return newDirectory.create(recursive: true);
  //   }
  //   return newDirectory;
  // }

  Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    await BoxCollection.open(
      "SerchDb", //Name of database
      {SharedBoxes().permissions, SharedBoxes().preferences, SharedBoxes().connection, SharedBoxes().database}, //Name of boxes
      path: directory.path
    );
    await Hive.openBox(SharedBoxes().permissions);
    await Hive.openBox(SharedBoxes().preferences);
    await Hive.openBox(SharedBoxes().connection);
    await Hive.openBox(SharedBoxes().database);
  }
}

//For User Preferences
class UserPreferences{
  final prefer = Hive.box(SharedBoxes().preferences);
  //For Theme Preference 1
  ThemeMode getThemeMode(){
    return getSavedThemeMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool getSavedThemeMode(){
    final permitJson = prefer.get(1);
    if(permitJson == null) return false;
    final permit = PermitModel.fromJson(json.decode(permitJson));
    if(permit.theme == null || permit.theme == false){
      return false;
    } else {
      return true;
    }
  }

  void saveThemeMode(bool theme) async {
    final permits = PermitModel(theme: theme);
    final permitJson = json.encode(permits.toJson());
    prefer.put(1, permitJson);
  }

  void changeThemeMode(bool theme){
    Get.changeThemeMode(getSavedThemeMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(theme);
  }

    //ShowOnMap Preference Handling 2
  void saveShowOnMap(bool granted) async {
    final permits = PermitModel(showOnMap: granted);
    final permitJson = json.encode(permits.toJson());
    prefer.put(2, permitJson);
  }

  bool getShowOnMap() {
    final permitted = prefer.get(2);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.showOnMap == null || permits.showOnMap == false){
      return false;
    } else {
      return true;
    }
  }


  //Show always online preference Handling 3
  void saveShowAlwaysOnline(bool granted) async {
    final permits = PermitModel(alwaysOnline: granted);
    final permitJson = json.encode(permits.toJson());
    prefer.put(3, permitJson);
  }

  bool getShowAlwaysOnline() {
    final permitted = prefer.get(3);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.alwaysOnline == null || permits.alwaysOnline == false){
      return false;
    } else {
      return true;
    }
  }


  //Stick with me preference Handling 4
  void saveSWM(bool granted) async {
    final permits = PermitModel(onSWM: granted);
    final permitJson = json.encode(permits.toJson());
    prefer.put(4, permitJson);
  }

  bool getSWM() {
    final permitted = prefer.get(4);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.onSWM == null || permits.onSWM == false){
      return false;
    } else {
      return true;
    }
  }


  //Biometrics Handling 5
  bool getBiometrics(){
    final permitted = prefer.get(5);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.hasBiometrics == null || permits.hasBiometrics == false){
      return false;
    } else {
      return true;
    }
  }

  void saveBiometrics(bool biometric){
    final permits = PermitModel(hasBiometrics: biometric);
    final permitJson = json.encode(permits.toJson());
    prefer.put(5, permitJson);
  }


  //Two-step verification Handling 6
  bool getTFA(){
    final permitted = prefer.get(6);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.hasTFA == null || permits.hasTFA == false){
      return false;
    } else {
      return true;
    }
  }

  void saveTFA(bool hasTFA){
    final permits = PermitModel(hasTFA: hasTFA);
    final permitJson = json.encode(permits.toJson());
    prefer.put(6, permitJson);
  }
}

//User Preferences in User Setting
class UserPermissions{
  final permit = Hive.box(SharedBoxes().permissions);

  //Chat Notification Handling 1
  void saveChatNotificationPermit(bool granted) async {
    final permits = PermitModel(chatNotify: granted);
    final permitJson = json.encode(permits.toJson());
    permit.put(1, permitJson);
  }

  bool getChatNotificationPermit() {
    final permitted = permit.get(1);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.chatNotify == null || permits.chatNotify == false){
      return false;
    } else {
      return true;
    }
  }


  //Call Notification Handling 2
  void saveCallNotificationPermit(bool granted) async {
    final permits = PermitModel(callNotify: granted);
    final permitJson = json.encode(permits.toJson());
    permit.put(2, permitJson);
  }

  bool getCallNotificationPermit() {
    final permitted = permit.get(2);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.callNotify == null || permits.callNotify == false){
      return false;
    } else {
      return true;
    }
  }


  //Push Notification Handling 3
  void savePushNotificationPermit(bool granted) async {
    final permits = PermitModel(otherNotify: granted);
    final permitJson = json.encode(permits.toJson());
    permit.put(3, permitJson);
  }

  bool getPushNotificationPermit() {
    final permitted = permit.get(3);
    if(permitted == null) return false;
    final permits = PermitModel.fromJson(json.decode(permitted));
    if(permits.otherNotify == null || permits.otherNotify == false){
      return false;
    } else {
      return true;
    }
  }
}

class UserConnection{
  final connect = Hive.box(SharedBoxes().connection);

  //HasRequestShare 1
  bool getHasRequestShare() {
    final result = connect.get(1);
    if(result == null){
      return false;
    } else {
      final newJson = UserServiceModel.fromJson(json.decode(result));
      if(newJson.hasRequestShare == null || newJson.hasRequestShare == false){
        return false;
      } else {
        return true;
      }
    }
  }

  void saveHasRequestShare(bool hasRequestShare) {
    final requestShare = UserServiceModel(hasRequestShare: hasRequestShare);
    final newJson = json.encode(requestShare.toJson());
    connect.put(1, newJson);
  }

  //OnRequestShare 2
  bool getOnRequestShare() {
    final result = connect.get(2);
    if(result == null){
      return false;
    } else {
      final newJson = UserServiceModel.fromJson(json.decode(result));
      if(newJson.onRequestShare == null || newJson.onRequestShare == false){
        return false;
      } else {
        return true;
      }
    }
  }

  void saveOnRequestShare(bool onRequestShare) {
    final requestShare = UserServiceModel(onRequestShare: onRequestShare);
    final newJson = json.encode(requestShare.toJson());
    connect.put(2, newJson);
  }

  //OnTripStatus 3
  bool getOnTrip() {
    final result = connect.get(3);
    if(result == null){
      return false;
    } else {
      final newJson = UserServiceModel.fromJson(json.decode(result));
      if(newJson.onTrip == null || newJson.onTrip == false){
        return false;
      } else {
        return true;
      }
    }
  }

  void saveOnTrip(bool onTrip) {
    final onTripStatus = UserServiceModel(onTrip: onTrip);
    final newJson = json.encode(onTripStatus.toJson());
    connect.put(3, newJson);
  }
}