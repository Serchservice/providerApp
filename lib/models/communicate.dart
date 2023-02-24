import 'package:provide/lib.dart';

class UserCallModel {
  final String callType;
  final String callMode;
  final String callerName;
  final String callerImage;
  final DateTime callTime;
  final String serchID;
  final String callerID;

  UserCallModel({
    this.callerName = "", required this.callTime, this.callerImage = "", this.callType = "Voice", this.callMode = "Received",
    this.callerID = "", this.serchID = ""
  });

  static UserCallModel fromJson(Map<String, dynamic> json) => UserCallModel(
    callMode: json["callMode"],
    callTime: TimeFormatter.supabaseDateParserTz.parse(json["callTime"]),
    callType: json["callType"],
    callerID: json["callerID"],
    callerImage: json["callerImage"],
    callerName: json["callerName"],
    serchID: json["serchID"]
  );

  UserCallModel.fromMap(Map<String, dynamic> map) : callMode = map["callMode"],
    callTime = TimeFormatter.supabaseDateParserTz.parse(map["callTime"]),
    callType = map["callType"],
    callerID = map["callerID"],
    callerImage = map["callerImage"],
    callerName = map["callerName"],
    serchID = map["serchID"];

  Map<String, dynamic> toJson() => {
    "callMode": callMode,
    "callTime": callTime.toIso8601String(),
    "callType": callType,
    "callerID": callerID,
    "callerImage": callerImage,
    "callerName": callerName,
    "serchID": serchID,
  };
}

class CallingModel{
  final String serchID;
  final String callID;
  final String joinedID;
  final String callMode;
  final String callStatus;

  CallingModel({this.serchID = "", this.callID = "", this.joinedID = "", this.callMode = "", this.callStatus = ""});

  static CallingModel fromJson(Map<String, dynamic> json) => CallingModel(
    serchID: json["serchID"],
    callID: json["callID"],
    joinedID: json["joinedID"],
    callMode: json["callMode"],
    callStatus: json["callStatus"]
  );

  Map<String, dynamic> toJson() => {
    "serchID": serchID,
    "callID": callID,
    "joinedID": joinedID,
    "callMode": callMode,
    "callStatus": callStatus,
  };
}

class UserRequestShare{
  final String rsFirstName;
  final String rsLastName;
  final String rsImage;
  final String rsID;
  final String serchID;

  UserRequestShare({this.rsFirstName = "", this.rsID = "", this.rsImage = "", this.rsLastName = "", this.serchID = ""});

  static UserRequestShare fromJson(Map<String, dynamic> json) => UserRequestShare(
    rsFirstName: json["rsFirstName"],
    rsLastName: json["rsLastName"],
    rsID: json["rsID"],
    rsImage: json["rsImage"],
    serchID: json["serchID"]
  );

  Map<String, dynamic> toJson() => {
    "rsFirstName": rsFirstName,
    "rsLastName": rsLastName,
    "rsImage": rsImage,
    "rsID": rsID,
    "serchID": serchID,
  };
}

class UserConnectedModel{
  final String firstName;
  final String lastName;
  final String avatar;
  final String connectID;
  final String rate;
  final String serchID;

  UserConnectedModel({
    this.firstName = "", this.connectID = "", this.avatar = "", this.lastName = "", this.serchID = "", this.rate = "0.0"
  });

  static UserConnectedModel fromJson(Map<String, dynamic> json) => UserConnectedModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    connectID: json["connectID"],
    rate: json["rate"],
    avatar: json["avatar"],
    serchID: json["serchID"]
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "avatar": avatar,
    "rate": rate,
    "connectID": connectID,
    "serchID": serchID,
  };
}

class UserAddressModel{
  String placeFormattedAddress;
  String placeName;
  String placeID;
  double latitude;
  double longitude;

  UserAddressModel({
    this.latitude = 0, this.longitude = 0, this.placeFormattedAddress = "",
    this.placeID = "", this.placeName = ""
  });

  static UserAddressModel fromJson(Map<String, dynamic> json) => UserAddressModel(
    latitude: json["latitude"],
    longitude: json["longitude"],
    placeFormattedAddress: json["placeFormattedAddress"],
    placeID: json["placeID"],
    placeName: json["placeName"]
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "placeFormattedAddress": placeFormattedAddress,
    "placeID": placeID,
    "placeName": placeName,
  };
}

class UserChatRoomModel{
  final String roomID;
  final String roomName;
  final String otherUserID;
  final DateTime createdAt;
  final String serchID;
  final UserChatModel lastMessage;

  UserChatRoomModel({
    required this.roomID, required this.roomName, required this.otherUserID, required this.createdAt, required this.lastMessage,
    required this.serchID
  });

  UserChatRoomModel.fromJson(Map<String, dynamic> json) : roomID = json["room_id"],
    roomName = json["room_name"],
    createdAt = json["created_at"],
    lastMessage = json["last_message"],
    serchID = json["serchID"],
    otherUserID = json["second_serchID"];

  Map<String, dynamic> toJson() => {
    "room_id": roomID,
    "room_name": roomName,
    "last_message": lastMessage,
    "serchID": serchID,
    "second_serchID": otherUserID,
    'created_at': createdAt.millisecondsSinceEpoch,
  };

  /// Creates a room object from room_participants table
  UserChatRoomModel.fromRoomParticipants(Map<String, dynamic> map) : createdAt = DateTime.parse(map['created_at']),
    roomID = map["room_id"],
    roomName = map["room_name"],
    lastMessage = map["last_message"],
    serchID = map["serchID"],
    otherUserID = map["second_serchID"];

  UserChatRoomModel copyWith({
    String? roomID,
    String? roomName,
    DateTime? createdAt,
    String? otherUserID,
    String? serchID,
    UserChatModel? lastMessage,
  }) {
    return UserChatRoomModel(
      createdAt: createdAt ?? this.createdAt,
      otherUserID: otherUserID ?? this.otherUserID,
      lastMessage: lastMessage ?? this.lastMessage,
      roomID: roomID ?? this.roomID,
      roomName: roomName ??  this.roomName,
      serchID: serchID ?? this.serchID
    );
  }
}

class UserChatModel{
  final String otherAvatar;
  final String otherName;
  final String message;
  final String roomID;
  final String msgStatus;
  final String otherID;
  final String serchID;
  final String msgTime;
  final bool isOther;
  final bool isAudio;
  final String audioDuration;
  // final int? index;
  final DateTime? createdAt;
  // final bool isLastWidget;
  UserChatModel({
    this.otherAvatar = "", this.otherName = "", this.message = "", this.msgTime = "", this.msgStatus = "Pending", this.otherID = "",
    this.serchID = "", this.isAudio = false, this.isOther = false, this.audioDuration = "", this.createdAt, this.roomID = ""
  });

  UserChatModel.fromJson(Map<String, dynamic> json, String thisUserId)
  : otherAvatar = json["otherAvatar"],
    otherName = json["otherName"],
    message = json["message"],
    msgTime = json["msgTime"],
    msgStatus = json["msgStatus"],
    otherID = json["otherID"],
    serchID = json["serchID"],
    audioDuration = json["audioDuration"],
    roomID = json["roomID"],
    // index = json["index"],
    isAudio = json["isAudio"],
    isOther = thisUserId != json["otherID"],
    // isLastWidget = json["isLastWidget"],
    createdAt = json['created_at'];

  UserChatModel.fromMap({required Map<String, dynamic> map, required String thisUserId})
    : createdAt = DateTime.parse(map['created_at']),
      otherAvatar = map["otherAvatar"],
      otherName = map["otherName"],
      message = map["message"],
      roomID = map["roomID"],
      msgTime = map["msgTime"],
      msgStatus = map["msgStatus"],
      otherID = map["otherID"],
      serchID = map["serchID"],
      audioDuration = map["audioDuration"],
      // index = map["index"],
      isAudio = map["isAudio"],
      isOther = thisUserId != map["otherID"];
      // isLastWidget = map["isLastWidget"];

  Map<String, dynamic> toJson() => {
    "otherAvatar": otherAvatar,
    "otherName": otherName,
    "message": message,
    "msgTime": msgTime,
    "msgStatus": msgStatus,
    "otherID": otherID,
    "serchID": serchID,
    "isAudio": isAudio,
    "isOther": isOther,
    "roomID": roomID,
    // "isLastWidget": isLastWidget,
    // "index": index,
    "created_at": createdAt,
    "audioDuration": audioDuration,
  };
}

class UserMessageModel{
  final String type;
  final String message;
  final String path;
  final String time;
  final bool isSender;
  final bool isAudio;
  final String audioDuration;
  final String messageDate;
  final String messageStatus;
  final int? index;
  final double? width;
  final bool isLastWidget;
  // final Directory appDirectory;
  UserMessageModel({
    this.audioDuration = "", this.messageDate = "", this.messageStatus = "", this.type = "", this.index, this.width, this.path = "",
    this.message = "", this.time = "", this.isAudio = false, this.isSender = false, this.isLastWidget = false
  });

  static UserMessageModel fromJson(Map<String, dynamic> json) => UserMessageModel(
    audioDuration: json["audioDuration"],
    messageDate: json["messageDate"],
    messageStatus: json["messageStatus"],
    type: json["type"],
    index: json["index"],
    width: json["width"],
    path: json["path"],
    message: json["message"],
    time: json["time"],
    isAudio: json["isAudio"],
    isSender: json["isSender"],
    isLastWidget: json["isLastWidget"]
  );

  Map<String, dynamic> toJson() => {
    "audioDuration": audioDuration,
    "messageDate": messageDate,
    "messageStatus": messageStatus,
    "type": type,
    "index": index,
    "width": width,
    "path": path,
    "message": message,
    "time": time,
    "isAudio": isAudio,
    "isSender": isSender,
    "isLastWidget": isLastWidget
  };
}