import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provide/lib.dart';

class UserSharedPermits{
  final getStorage = GetStorage();
  final permissionKey = "permissions";

  //For Permission handling
  ThemeMode getThemeMode() {
    debugShow(getSavedThemeMode());
    return getSavedThemeMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool getSavedThemeMode() {
    final theme = getStorage.read(permissionKey);
    if(theme == null || theme == false){
      return false;
    } else {
      return true;
    }
  }

  void saveThemeMode(bool theme){
    getStorage.write(permissionKey, theme);
    debugShow("Current value is ${theme ? "Dark" : "Light"} $theme");
  }

  void changeThemeMode(bool theme) {
    Get.changeThemeMode(getSavedThemeMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(theme);
  }

  //Biometrics Handling
  bool getBiometrics(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.hasBiometrics == false || permits.hasBiometrics == null){
      return false;
    } else {
      return true;
    }
  }

  void saveBiometricsMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For ChatNotification Handling
  bool getChatNotification(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.chatNotify == false || permits.chatNotify == null){
      return false;
    } else {
      return true;
    }
  }

  void saveChatNotificationMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For CallNotification Handling
  bool getCallNotification(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.callNotify == false || permits.callNotify == null){
      return false;
    } else {
      return true;
    }
  }

  void saveCallNotificationMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For OtherNotification Handling
  bool getOtherNotification(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.otherNotify == false || permits.otherNotify == null){
      return false;
    } else {
      return true;
    }
  }

  void saveOtherNotificationMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For ShowOnMap Handling
  bool getShowOnMap(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.showOnMap == false || permits.showOnMap == null){
      return false;
    } else {
      return true;
    }
  }

  void saveShowOnMapMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For ShowAppBadge Handling
  bool getShowAppBadge(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.showAppBadge == false || permits.showAppBadge == null){
      return false;
    } else {
      return true;
    }
  }

  void saveShowAppBadgeMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For AlwaysOnline Handling
  bool getAlwaysOnline(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.alwaysOnline == false || permits.alwaysOnline == null){
      return false;
    } else {
      return true;
    }
  }

  void saveAlwaysOnlineMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For SWM Handling
  bool getSWM(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.onSWM == false || permits.onSWM == null){
      return false;
    } else {
      return true;
    }
  }

  void saveSWMMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For EmailSecure Handling
  bool getEmailSecure(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.emailSecure == false || permits.emailSecure == null){
      return false;
    } else {
      return true;
    }
  }

  void saveEmailSecureMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }


  //For Audio Handling
  bool getAudio(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.audio == false || permits.audio == null){
      return false;
    } else {
      return true;
    }
  }

  void saveAudioMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For Camera Handling
  bool getCamera(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.camera == false || permits.camera == null){
      return false;
    } else {
      return true;
    }
  }

  void saveCameraMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For File Handling
  bool getFile(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.file == false || permits.file == null){
      return false;
    } else {
      return true;
    }
  }

  void saveFileMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For Photos Handling
  bool getPhotos(){
    final permitJson = getStorage.read(permissionKey);
    final permits = PermitModel.fromJson(json.decode(permitJson));
    if(permits.photos == false || permits.photos == null){
      return false;
    } else {
      return true;
    }
  }

  void savePhotosMode(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  //For Location Permission
  LocationPermission getLocationPermit() {
    return isLocationGranted() ? LocationPermission.always : LocationPermission.denied;
  }

  bool isLocationGranted() {
    final permitJson = getStorage.read(permissionKey);
    if(permitJson == false){
      return false;
    } else {
      final permits = PermitModel.fromJson(json.decode(permitJson));
      if(permits.location ==  null || permits.location == false){
        return false;
      } else {
        return true;
      }
    }
  }

  void saveLocationPermit(PermitModel model){
    final permitJson = json.encode(model.toJson());
    getStorage.write(permissionKey, permitJson);
  }

  void changeLocationPermit() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.always){
      saveLocationPermit(PermitModel(location: true));
      if(permission == LocationPermission.denied){
        await Geolocator.requestPermission();
        if(permission == LocationPermission.always){
          saveLocationPermit(PermitModel(location: true));
        }
      } else if(permission == LocationPermission.deniedForever){
        await Geolocator.requestPermission();
        if(permission == LocationPermission.always){
          saveLocationPermit(PermitModel(location: true));
        }
      } else if(permission == LocationPermission.unableToDetermine){
        await Geolocator.openLocationSettings();
      } else {
        saveLocationPermit(PermitModel(location: true));
      }
    } else {
      saveLocationPermit(PermitModel(location: false));
    }
    // if(permission == LocationPermission.denied){
    //   await Geolocator.requestPermission();
    // } else if(permission == LocationPermission.deniedForever){
    //   await Geolocator.requestPermission();
    // } else if(permission == LocationPermission.unableToDetermine){
    //   await Geolocator.openLocationSettings();
    // } else 
  }
}