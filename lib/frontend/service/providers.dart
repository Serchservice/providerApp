import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provide/lib.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => UserMapInformation()),
  ChangeNotifierProvider(create: (_) => UserChatsInformation()),
  ChangeNotifierProvider(create: (_) => UserChattingInformation()),
  ChangeNotifierProvider(create: (_) => UserPermissionInformation()),
];

class UserMapInformation extends ChangeNotifier {
  ///Provider for User Map Information
  ///
  ///This Provider stores the user's map information upon every log in. This enables the geofencing to read and know the latitude and longitude
  ///of the user.
  ///

  UserAddressModel homeLocation = UserAddressModel(), serviceLocation = UserAddressModel(), currentLocation = UserAddressModel();

  void updateHomeLocation(UserAddressModel homeAddress){
    homeLocation = homeAddress;
    notifyListeners();
  }

  void updateServiceLocation(UserAddressModel serviceAddress){
    serviceLocation = serviceAddress;
    notifyListeners();
  }

  void updateCurrentLocation(UserAddressModel currentAddress){
    currentLocation = currentAddress;
    notifyListeners();
  }
}

class UserChatsInformation extends ChangeNotifier{}

class UserChattingInformation extends ChangeNotifier{}

class UserPermissionInformation extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.light;
  void toogleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}