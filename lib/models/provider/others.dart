import 'package:provide/lib.dart';

class UserServiceModel{
  String? service; String status;

  UserServiceModel({this.service, this.status = "Offline"});
}

class UserScheduledListModel{
  String scheduledImage;
  String scheduledTime;

  UserScheduledListModel({required this.scheduledImage, required this.scheduledTime});
}

class UserRatingModel{
  double totalRating;
  double numberRated;

  UserRatingModel({this.totalRating = 0, this.numberRated = 0});
}

class UserMoneyModel{
  double totalEarned;
  UserMoneyModel({this.totalEarned = 0.00});
}

class ReferStep{
  final int step;
  final String referredName;
  final String referredPicture;

  ReferStep({required this.step, required this.referredName, required this.referredPicture});
}

class NotificationModel{
  final int id;
  final String? title;
  final String? body;
  final String? time;
  final String? payload;
  final ChatModel? chatModel;

  NotificationModel({this.id = 0, this.title, this.body, this.payload, this.time, this.chatModel});
}

class PermitModel{
  final bool? location;
  final bool? camera;
  final bool? file;
  final bool? audio;
  final bool? theme;
  final bool? hasBiometrics;
  final bool? chatNotify;
  final bool? callNotify;
  final bool? otherNotify;
  final bool? showOnMap;
  final bool? alwaysOnline;
  final bool? onSWM;
  final bool? showAppBadge;
  final bool? emailSecure;
  final bool? photos;

  PermitModel({
    this.audio, this.camera, this.file, this.location, this.theme, this.alwaysOnline, this.callNotify, this.chatNotify,
    this.hasBiometrics, this.onSWM, this.otherNotify, this.showOnMap, this.showAppBadge, this.emailSecure, this.photos
  });

  static PermitModel fromJson(Map<bool, dynamic> json) => PermitModel(
    audio: json["audio"],
    camera: json["camera"],
    file: json["file"],
    location: json["location"],
    theme: json["theme"],
    hasBiometrics: json["hasBiometrics"],
    chatNotify: json["chatNotify"],
    callNotify: json["callNotify"],
    otherNotify: json['otherNotify'],
    showOnMap: json["showOnMap"],
    alwaysOnline: json["alwaysOnline"],
    onSWM: json["onSWM"],
    showAppBadge: json["showAppBadge"],
    emailSecure: json["emailSecure"],
    photos: json["photos"]
  );

  Map<String, dynamic> toJson() => {
    "audio": audio,
    "camera": camera,
    "file": file,
    "location": location,
    "theme": theme,
    "hasBiometrics": hasBiometrics,
    "chatNotify": chatNotify,
    "callNotify": callNotify,
    "otherNotify": otherNotify,
    "showOnMap": showOnMap,
    "alwaysOnline": alwaysOnline,
    "onSWM": onSWM,
    "showAppBadge": showAppBadge,
    "emailSecure": emailSecure,
    "photos": photos
  };
}