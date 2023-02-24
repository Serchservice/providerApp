import 'package:provide/lib.dart';

class UserPhoneInfo{
  final String phone, phoneCountryCode, phoneCountryISOCode;
  const UserPhoneInfo({this.phone = "", this.phoneCountryCode = "", this.phoneCountryISOCode = ""});

  static UserPhoneInfo fromJson(Map<String, dynamic> json) => UserPhoneInfo(
    phone: json["phone"],
    phoneCountryCode: json["phoneCountryCode"],
    phoneCountryISOCode: json["phoneCountryISOCode"],
  );

  UserPhoneInfo.fromMap(Map<String, dynamic> map) : phone = map["phone"], phoneCountryCode = map["phoneCountryCode"],
    phoneCountryISOCode = map["phoneCountryISOCode"];

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "phoneCountryCode": phoneCountryCode,
    "phoneCountryISOCode": phoneCountryISOCode,
  };
}

class UserCountryInfo{
  final String country, countryDialCode;
  const UserCountryInfo({this.country = "", this.countryDialCode = ""});
  static UserCountryInfo fromJson(Map<String, dynamic> json) => UserCountryInfo(
    country: json["country"],
    countryDialCode: json["countryDialCode"],
  );

  UserCountryInfo.fromMap(Map<String, dynamic> map) : country = map["country"], countryDialCode = map["countryDialCode"];

  Map<String, dynamic> toJson() => {
    "country": country,
    "countryDialCode": countryDialCode,
  };
}

class UserInformationModel{
  final String emailAddress, firstName, lastName, password, gender, referLink, serchID, avatar, certificate, service;
  final UserPhoneInfo phoneInfo; final UserCountryInfo countryInfo; final dynamic serchAuth;
  final String totalRating; final int numberOfRating, totalServiceTrips, totalShared; final String balance;

  const UserInformationModel({
    this.emailAddress = "", this.firstName = "", this.lastName = "", this.password = "", this.referLink = "", this.serchID = "",
    this.gender = "", this.phoneInfo = const UserPhoneInfo(), this.countryInfo = const UserCountryInfo(), this.serchAuth,
    this.totalRating = "0.0", this.numberOfRating = 0, this.avatar = "", this.totalServiceTrips = 0, this.balance = "0",
    this.certificate = "", this.totalShared = 0, this.service = "Service Provider"
  });

  static UserInformationModel fromJson(Map<String, dynamic> json) => UserInformationModel(
    emailAddress: json["emailAddress"], firstName: json["firstName"], lastName: json["lastName"],
    password: json["password"], gender: json["gender"], totalServiceTrips: json["total_service_trips"],
    phoneInfo: UserPhoneInfo.fromJson(json['phoneInfo'] as Map<String, dynamic>), totalShared: json["totalShared"],
    countryInfo: UserCountryInfo.fromJson(json['countryInfo'] as Map<String, dynamic>), certificate: json["certificate"],
    referLink: json["referLink"], serchAuth: json["serchAuth"], avatar: json["avatar"], balance: json["balance"],
    serchID: json["serchID"], totalRating: json["totalRating"], numberOfRating: json["numberOfRating"], service: json["service"]
  );

  UserInformationModel.fromMap(Map<String, dynamic> map) : emailAddress = map["emailAddress"], firstName = map["firstName"],
    lastName = map["lastName"], password = map["password"], gender = map["gender"], totalServiceTrips = map["total_service_trips"],
    phoneInfo = UserPhoneInfo.fromMap(map['phoneInfo'] as Map<String, dynamic>), totalShared = map["totalShared"],
    countryInfo = UserCountryInfo.fromMap(map['countryInfo'] as Map<String, dynamic>), certificate = map["certificate"],
    referLink = map["referLink"], serchAuth = map["serchAuth"], avatar = map["avatar"], balance = map["balance"],
    serchID = map["serchID"], totalRating = map["totalRating"], numberOfRating = map["numberOfRating"], service = map["service"];

  Map<String, dynamic> toJson() => {
    "emailAddress": emailAddress,
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "gender": gender,
    "phoneInfo": phoneInfo.toJson(),
    "countryInfo": countryInfo.toJson(),
    "referLink": referLink,
    "avatar": avatar,
    "service": service,
    "serchAuth": serchAuth,
    "serchID": serchID,
    "totalRating": totalRating,
    "balance": balance,
    "totalShared": totalShared,
    "certificate": certificate,
    "numberOfRating": numberOfRating,
    "total_service_trips": totalServiceTrips
  };
}

class UserServiceAndPlan{
  final String plan, paymentMethod, freeTrial, serchID, status;
  final bool onRequestShare, onTrip;
  const UserServiceAndPlan({
    this.serchID = "", this.paymentMethod = "", this.plan = "", this.freeTrial = "",
    this.onRequestShare = false, this.onTrip = false, this.status = "Offline"
  });

  static UserServiceAndPlan fromJson(Map<String, dynamic> json) => UserServiceAndPlan(
    serchID: json["serchID"],
    plan: json["plan"],
    paymentMethod: json["payment_method"],
    freeTrial: json["free_trial"],
    onRequestShare: json["on_request_share"],
    onTrip: json["on_trip"],
    status: json["status"]
  );

  UserServiceAndPlan.fromMap(Map<String, dynamic> map) : serchID = map["serchID"],
    plan = map["plan"],
    paymentMethod = map["payment_method"],
    freeTrial = map["free_trial"],
    onRequestShare = map["on_request_share"],
    onTrip = map["on_trip"],
    status = map["status"];

  UserServiceAndPlan copyWith({
    String? plan, String? paymentMethod, String? freeTrial, String? serchID, String? status,
    bool? onRequestShare, bool? onTrip
  }) {
    return UserServiceAndPlan(
      plan: plan ?? this.plan,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      freeTrial: freeTrial ?? this.freeTrial,
      onRequestShare: onRequestShare ?? this.onRequestShare,
      status: status ??  this.status,
      serchID: serchID ?? this.serchID,
      onTrip: onTrip ?? this.onTrip
    );
  }

  Map<String, dynamic> toJson() => {
    "serchID": serchID,
    "plan": plan,
    "payment_method": paymentMethod,
    "free_trial": freeTrial,
    "on_request_share": onRequestShare,
    "on_trip": onTrip,
    "status": status,
  };
}

class UserAdditionalModel{
  int stNo;
  String stName, lga, landMark, city, state, country, emailAlternate, phoneAlternate, serchID;
  String nokTitle, nokRelationship, nokFirstName, nokLastName, nokEmail, nokPhone, nokAddress, nokCity, nokState, nokCountry;

  UserAdditionalModel({
    this.stNo = 0, this.stName = "", this.lga = "", this.landMark = "", this.city = "", this.state = "", this.country = "",
    this.emailAlternate = "", this.phoneAlternate = "", this.nokTitle = "", this.nokRelationship = "", this.nokFirstName = "",
    this.nokLastName = "", this.nokEmail = "", this.nokPhone = "", this.nokAddress = "", this.nokCity = "", this.nokCountry = "",
    this.nokState = "", this.serchID = ""
  });

  static UserAdditionalModel fromJson(Map<String, dynamic> json) => UserAdditionalModel(
    serchID: json["serchID"],
    stNo: json["stNo"],
    stName: json["stName"],
    lga: json["lga"],
    landMark: json["landMark"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    emailAlternate: json["emailAlternate"],
    phoneAlternate: json["phoneAlternate"],
    nokTitle: json["nokTitle"],
    nokRelationship: json["nokRelationship"],
    nokFirstName: json["nokFirstName"],
    nokLastName: json["nokLastName"],
    nokEmail: json["nokEmail"],
    nokPhone: json["nokPhone"],
    nokAddress: json["nokAddress"],
    nokCity: json["nokCity"],
    nokState: json["nokState"],
    nokCountry: json["nokCountry"],
  );

  Map<String, dynamic> toJson() => {
    "serchID": serchID,
    "stNo": stNo,
    "stName": stName,
    "lga": lga,
    "landMark": landMark,
    "city": city,
    "state": state,
    "country": country,
    "emailAlternate": emailAlternate,
    "phoneAlternate": phoneAlternate,
    "nokTitle": nokTitle,
    "nokRelationship": nokRelationship,
    "nokFirstName": nokFirstName,
    "nokLastName": nokLastName,
    "nokEmail": nokEmail,
    "nokPhone": nokPhone,
    "nokAddress": nokAddress,
    "nokCity": nokCity,
    "nokState": nokState,
    "nokCountry": nokCountry,
  };
}

class PasswordReset{
  final String accessToken;
  final String? refreshToken;
  final String type;
  final int? expiresIn;

  PasswordReset({required this.accessToken, this.expiresIn, this.refreshToken, required this.type});

  static PasswordReset fromJson(Map<String, dynamic> json) => PasswordReset(
    accessToken: json["accessToken"],
    expiresIn: json["expires_in"],
    refreshToken: json["refreshToken"],
    type: json["type"]
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "expires_in": expiresIn,
    "refreshToken": refreshToken,
    "type": type
  };
}

class UserScheduleModel{
  String schedulerImage;
  String schedulerID;
  String serchID;
  String scheduledTime;

  UserScheduleModel({
    this.schedulerImage = "", this.scheduledTime = "", this.schedulerID = "", this.serchID = ""
  });

  static UserScheduleModel fromJson(Map<String, dynamic> json) => UserScheduleModel(
    schedulerImage: json["schedulerImage"], scheduledTime: json["scheduledTime"],
    schedulerID: json["schedulerID"], serchID: json["serchID"]
  );

  UserScheduleModel.fromMap(Map<String, dynamic> map) : schedulerImage = map["schedulerImage"], scheduledTime = map["scheduledTime"],
    schedulerID = map["schedulerID"], serchID = map["serchID"];

  Map<String, dynamic> toJson() => {
    "schedulerImage": schedulerImage,
    "scheduledTime": scheduledTime,
    "schedulerID": schedulerID,
    "serchID": serchID
  };
}

class UserRateModel{
  final String raterImage;
  final String raterComment;
  final String raterName;
  final String raterID;
  final String serchID;
  final String raterRate;
  UserRateModel({
    this.raterImage = "", this.raterComment = "", this.raterName = "", this.raterRate = "0.0", this.raterID = "", this.serchID = ""
  });

  static UserRateModel fromJson(Map<String, dynamic> json) => UserRateModel(
    raterComment: json["raterComment"],
    raterImage: json["raterImage"], raterName: json["raterName"], raterRate: json["raterRate"], raterID: json["raterID"],
    serchID: json["serchID"]
  );

  Map<String, dynamic> toJson() => {
    "raterComment": raterComment,
    "raterImage": raterImage,
    "raterName": raterName,
    "raterRate": raterRate,
    "raterID": raterID,
    "serchID": serchID,
  };
}

class UserMoneyModel{
  final String transactionType;
  final String transactID;
  final String transactName;
  final String transactAmount;
  final String transactStatus;
  final String transactDate;
  final String serchID;
  final String transactImage;

  UserMoneyModel({
    this.transactionType = "", this.transactID = "", this.transactName = "", this.transactAmount = "",
    this.transactStatus = "", this.transactDate = "", this.serchID = "", this.transactImage = ""
  });

  static UserMoneyModel fromJson(Map<String, dynamic> json) => UserMoneyModel(
    transactionType: json["transactionType"], transactID: json["transactID"],
    transactName: json["transactName"], transactAmount: json["transactAmount"],
    transactStatus: json["transactStatus"], transactDate: json["transactDate"],
    serchID: json["serchID"], transactImage: json["transactImage"]
  );

  Map<String, dynamic> toJson() => {
    "transactionType": transactionType,
    "transactID": transactID,
    "transactName": transactName,
    "transactImage": transactImage,
    "transactAmount": transactAmount,
    "transactStatus": transactStatus,
    "transactDate": transactDate,
    "serchID": serchID
  };
}

class UserReferralModel{
  final String referredFirstName;
  final String referredLastName;
  final String referredStatus;
  final String referredImage;
  final String referredID;
  final String serchID;

  UserReferralModel({
    this.referredFirstName = "", this.referredImage = "", this.referredStatus = "Pending", this.referredLastName = "",
    this.referredID = "", this.serchID = ""
  });

  static UserReferralModel fromJson(Map<String, dynamic> json) => UserReferralModel(
    referredFirstName: json["referredFirstName"],
    referredLastName: json["referredLastName"],
    referredImage: json["referredImage"],
    referredStatus: json["referredStatus"],
    referredID: json["referredID"],
    serchID: json["serchID"],
  );

  Map<String, dynamic> toJson() => {
    "referredFirstName": referredFirstName,
    "referredLastName": referredLastName,
    "referredImage": referredImage,
    "referredStatus": referredStatus,
    "referredID": referredID,
    "serchID": serchID
  };
}

class UserBankCardModel{
  String cardNumber;
  String cardExpiryDate;
  String cardName;
  String cardCode;
  String cardType;
  String serchID;

  UserBankCardModel({
    this.cardNumber = "", this.cardExpiryDate = "", this.cardName = "", this.cardCode = "",
    this.cardType = "", this.serchID = ""
  });

  static UserBankCardModel fromJson(Map<String, dynamic> json) => UserBankCardModel(
    cardNumber: json["cardNumber"], cardExpiryDate: json["cardExpiryDate"], cardName: json["cardName"],
    cardCode: json["cardCode"], cardType: json["cardType"], serchID: json["serchID"]
  );

  Map<String, dynamic> toJson() => {
    "cardNumber": cardNumber, "cardExpiryDate": cardExpiryDate, "cardName": cardName,
    "cardCode": cardCode, "cardType": cardType, "serchID": serchID
  };
}

class UserBankAccountModel{
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String serchID;

  UserBankAccountModel({this.accountName = "", this.accountNumber = "", this.bankName = "", this.serchID = ""});

  static UserBankAccountModel fromJson(Map<String, dynamic> json) => UserBankAccountModel(
    accountName: json["accountName"], accountNumber: json["accountNumber"], bankName: json["bankName"], serchID: json["serchID"]
  );

  Map<String, dynamic> toJson() => {
    "accountName": accountName, "accountNumber": accountNumber, "bankName": bankName, "serchID": serchID
  };
}

class UserSettingModel{
  final bool showOnMap;
  final bool alwaysOnline;
  final bool swm;
  final bool ctg;
  final bool tfa;
  final bool emailSecure;
  final bool biometrics;
  final String serchID;
  final String tfaCode;

  UserSettingModel({
    this.showOnMap = false, this.alwaysOnline = false, this.swm = false, this.ctg = false,
    this.tfa = false, this.emailSecure = false, this.biometrics = false, this.serchID = "", this.tfaCode = ""
  });

  static UserSettingModel fromJson(Map<String, dynamic> json) => UserSettingModel(
    showOnMap: json["showOnMap"], alwaysOnline: json["alwaysOnline"], swm: json["swm"], ctg: json["ctg"], tfa: json["tfa"],
    emailSecure: json["emailSecure"], biometrics: json["biometrics"], serchID: json["serchID"], tfaCode: json["tfaCode"]
  );

  UserSettingModel.fromMap(Map<String, dynamic> map) : showOnMap = map["showOnMap"], alwaysOnline = map["alwaysOnline"],
    swm = map["swm"], ctg = map["ctg"], tfa = map["tfa"], emailSecure = map["emailSecure"], biometrics = map["biometrics"],
    serchID = map["serchID"], tfaCode = map["tfaCode"];

  UserSettingModel copyWith({
    String? serchID,
    String? tfaCode,
    bool? showOnMap,
    bool? alwaysOnline,
    bool? swm,
    bool? ctg,
    bool? tfa,
    bool? emailSecure,
    bool? biometrics,
  }) {
    return UserSettingModel(
      alwaysOnline: alwaysOnline ?? this.alwaysOnline,
      showOnMap: showOnMap ?? this.showOnMap,
      tfa: tfa ?? this.tfa,
      swm: swm ?? this.swm,
      biometrics: biometrics ?? this.biometrics,
      emailSecure: emailSecure ?? this.emailSecure,
      ctg: ctg ?? this.ctg,
      tfaCode: tfaCode ??  this.tfaCode,
      serchID: serchID ?? this.serchID
    );
  }

  Map<String, dynamic> toJson() => {
    "showOnMap": showOnMap,
    "alwaysOnline": alwaysOnline,
    "swm": swm,
    "ctg": ctg,
    "tfa": tfa,
    "emailSecure": emailSecure,
    "biometrics": biometrics,
    "serchID": serchID,
    "tfaCode": tfaCode,
  };
}

class UserBookmarkModel{
  final String firstName;
  final String lastName;
  final String image;
  final String bookmarkID;
  final String serchID;

  UserBookmarkModel({
    this.firstName = "", this.image = "", this.lastName = "", this.bookmarkID = "", this.serchID = ""
  });

  static UserBookmarkModel fromJson(Map<String, dynamic> json) => UserBookmarkModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
    bookmarkID: json["bookmarkID"],
    serchID: json["serchID"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
    "bookmarkID": bookmarkID,
    "serchID": serchID
  };
}

class UserRatingsModel{
  final double rate;
  final int day;

  UserRatingsModel({this.rate = 0.0, this.day = 0});

  static UserRatingsModel fromJson(Map<String, dynamic> json) => UserRatingsModel(
    rate: double.parse(json["rate"]),
    day: TimeFormatter.supabaseDateParser.parse(json["created_at"]).day
  );

  Map<String, dynamic> toJson() => {
    "rate": rate, "day": day
  };
}