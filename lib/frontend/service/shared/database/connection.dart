import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provide/lib.dart';

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