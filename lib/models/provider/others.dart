import 'package:provide/lib.dart';

class UserServiceModel{
  String? service; String status; bool? hasRequestShare; bool? onRequestShare; bool? onTrip;

  UserServiceModel({this.service, this.status = "Offline", this.hasRequestShare, this.onRequestShare, this.onTrip});

  static UserServiceModel fromJson(Map<String, dynamic> json) => UserServiceModel(
    service: json["service"],
    status: json["status"],
    hasRequestShare: json["hasRequestShare"],
    onRequestShare: json["onRequestShare"],
    onTrip: json["onTrip"],
  );

  Map<String, dynamic> toJson() => {
    "service": service,
    "status": status,
    "hasRequestShare": hasRequestShare,
    "onRequestShare": onRequestShare,
    "onTrip": onTrip
  };
}


class ReferModel{
  String referredFirstName;
  String referredLastName;
  bool referredStatus;
  String? referredPicture;

  ReferModel({required this.referredFirstName, this.referredPicture, required this.referredStatus, required this.referredLastName});

  static ReferModel fromJson(Map<String, dynamic> json) => ReferModel(
    referredFirstName: json["referredFirstName"],
    referredLastName: json["referredLastName"],
    referredPicture: json["referredPicture"],
    referredStatus: json["referredStatus"],
  );

  Map<String, dynamic> toJson() => {
    "referredFirstName": referredFirstName,
    "referredLastName": referredLastName,
    "referredPicture": referredPicture,
    "referredStatus": referredStatus
  };
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
  final bool? hasTFA;

  PermitModel({
    this.audio, this.camera, this.file, this.location, this.theme, this.alwaysOnline, this.callNotify, this.chatNotify,
    this.hasBiometrics, this.onSWM, this.otherNotify, this.showOnMap, this.showAppBadge, this.emailSecure, this.photos, this.hasTFA
  });

  static PermitModel fromJson(Map<String, dynamic> json) => PermitModel(
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
    photos: json["photos"],
    hasTFA: json["hasTFA"],
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
    "photos": photos,
    "hasTFA": hasTFA,
  };
}