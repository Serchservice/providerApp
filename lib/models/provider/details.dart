class UserInformationModel{
  String id, email, firstName, lastName, phone, phoneNumber, userName, password, emailAddress, country, countryDialCode;
  String serchID, databaseID, gender, phoneCountryCode, phoneCountryISOCode, image;
  bool emailVerified;

  UserInformationModel({
    this.id = "", this.email = "", this.firstName = "", this.lastName = "", this.phone = "", this.phoneNumber = "", this.userName = "", this.password = "", this.emailAddress = "",
    this.country = "", this.countryDialCode = "", this.serchID = "", this.databaseID = "", this.gender = "", this.phoneCountryCode = "", this.phoneCountryISOCode = "",
    this.image = "", this.emailVerified = false
  });

  static UserInformationModel fromJson(Map<String, dynamic> json) => UserInformationModel(
    id: json["id"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    phoneNumber: json["phoneNumber"],
    userName: json["userName"],
    password: json["password"],
    emailAddress: json["emailAddress"],
    country: json["country"],
    countryDialCode: json["countryDialCode"],
    serchID: json["serchID"],
    databaseID: json["databaseID"],
    gender: json["gender"],
    phoneCountryCode: json["phoneCountryCode"],
    phoneCountryISOCode: json["phoneCountryISOCode"],
    image: json["image"],
    emailVerified: json["emailVerified"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "phoneNumber": phoneNumber,
    "userName": userName,
    "password": password,
    "emailAddress": emailAddress,
    "country": country,
    "countryDialCode": countryDialCode,
    "serchID": serchID,
    "databaseID": databaseID,
    "gender": gender,
    "phoneCountryCode": phoneCountryCode,
    "phoneCountryISOCode": phoneCountryISOCode,
    "image": image,
    "emailVerified": emailVerified
  };

  ///For DateTime, user name.toIso8601String() to convert to string when using toJson()
  ///But when using fromJson(), use DateTime.parse(json["name"]),
}