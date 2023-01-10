import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provide/lib.dart';

class HiveStorage{
  var path = Directory.current.path;

  Future<Directory> getDirectory() async {
    Directory? directory = await getExternalStorageDirectory();
    const String pathExt = '/serchDb/';
    Directory newDirectory = Directory(directory!.path + pathExt);
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }

  Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    final collections = await BoxCollection.open(
      "SerchDb", //Name of database
      {
        SharedBoxes().permissions, SharedBoxes().preferences, SharedBoxes().connection
      }, //Name of boxes
      path: directory.path
    );
    await Hive.openBox(SharedBoxes().permissions);
    await Hive.openBox(SharedBoxes().preferences);
    await Hive.openBox(SharedBoxes().connection);
    debugShow(collections.name);
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
// class UserSharedPermits{
//   //Biometrics Handling
//   bool getBiometrics(){
//     final permitJson = SharedKeys().getStorage.read("biometrics");
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.hasBiometrics == false || permits.hasBiometrics == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveBiometricsMode(bool biometric){
//     final model = PermitModel(hasBiometrics: biometric);
//     final permitJson = json.encode(model.toJson());
//     debugShow(permitJson);
//     SharedKeys().getStorage.changes.update("biometrics", (value) => biometric);
//   }

//   //For ChatNotification Handling
//   bool getChatNotification(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.chatNotify == false || permits.chatNotify == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveChatNotificationMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For CallNotification Handling
//   bool getCallNotification(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.callNotify == false || permits.callNotify == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveCallNotificationMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For OtherNotification Handling
//   bool getOtherNotification(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.otherNotify == false || permits.otherNotify == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveOtherNotificationMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For ShowOnMap Handling
//   bool getShowOnMap(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.showOnMap == false || permits.showOnMap == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveShowOnMapMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For ShowAppBadge Handling
//   bool getShowAppBadge(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.showAppBadge == false || permits.showAppBadge == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveShowAppBadgeMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For AlwaysOnline Handling
//   bool getAlwaysOnline(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.alwaysOnline == false || permits.alwaysOnline == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveAlwaysOnlineMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For SWM Handling
//   bool getSWM(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.onSWM == false || permits.onSWM == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveSWMMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For EmailSecure Handling
//   bool getEmailSecure(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.emailSecure == false || permits.emailSecure == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void saveEmailSecureMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For Photos Handling
//   bool getPhotos(){
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     final permits = PermitModel.fromJson(json.decode(permitJson));
//     if(permits.photos == false || permits.photos == null){
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void savePhotosMode(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   //For Location Permission
//   LocationPermission getLocationPermit() {
//     return isLocationGranted() ? LocationPermission.always : LocationPermission.denied;
//   }

//   bool isLocationGranted() {
//     final permitJson = SharedKeys().getStorage.read(SharedKeys().theme);
//     if(permitJson == false){
//       return false;
//     } else {
//       final permits = PermitModel.fromJson(json.decode(permitJson));
//       if(permits.location ==  null || permits.location == false){
//         return false;
//       } else {
//         return true;
//       }
//     }
//   }

//   void saveLocationPermit(PermitModel model){
//     final permitJson = json.encode(model.toJson());
//     SharedKeys().getStorage.write(SharedKeys().theme, permitJson);
//   }

//   void changeLocationPermit() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if(permission == LocationPermission.always){
//       saveLocationPermit(PermitModel(location: true));
//       if(permission == LocationPermission.denied){
//         await Geolocator.requestPermission();
//         if(permission == LocationPermission.always){
//           saveLocationPermit(PermitModel(location: true));
//         }
//       } else if(permission == LocationPermission.deniedForever){
//         await Geolocator.requestPermission();
//         if(permission == LocationPermission.always){
//           saveLocationPermit(PermitModel(location: true));
//         }
//       } else if(permission == LocationPermission.unableToDetermine){
//         await Geolocator.openLocationSettings();
//       } else {
//         saveLocationPermit(PermitModel(location: true));
//       }
//     } else {
//       saveLocationPermit(PermitModel(location: false));
//     }
//     // if(permission == LocationPermission.denied){
//     //   await Geolocator.requestPermission();
//     // } else if(permission == LocationPermission.deniedForever){
//     //   await Geolocator.requestPermission();
//     // } else if(permission == LocationPermission.unableToDetermine){
//     //   await Geolocator.openLocationSettings();
//     // } else 
//   }
// }