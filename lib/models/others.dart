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

class MoneyModel{
  double totalEarned;
  MoneyModel({this.totalEarned = 0.00});
}

class NotificationModel{
  final int id;
  final String? title;
  final String? body;
  final String? time;
  final String? payload;

  NotificationModel({this.id = 0, this.title, this.body, this.payload, this.time,});
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