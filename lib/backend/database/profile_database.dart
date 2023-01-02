import 'package:provide/lib.dart';

const user = "Eva";

class UserInfo{
  String? id, email, firstName, lastName, phone, phoneNumber, userName, password, emailAddress, country, countryDialCode;
  String? serchID, firebaseID, gender, phoneCountryCode, phoneCountryISOCode;
  bool? emailVerified;
  UserInfo({
    this.id, this.email, this.firstName, this.lastName, this.phone, this.country, this.countryDialCode, this.emailAddress,
    this.emailVerified, this.firebaseID, this.gender, this.password, this.phoneNumber, this.serchID, this.userName,
    this.phoneCountryCode, this.phoneCountryISOCode
  });

  UserInfo.fromSnapshot(snapshot){
    id = snapshot.get("firebaseID") ?? "";
    firstName = snapshot.get("firstName") ?? "";
    lastName = snapshot.get("lastName") ?? "";
    email = user;
    phone = snapshot.get("phone") ?? "";
    phoneNumber = snapshot.get("phoneNumber") ?? "";
    serchID = snapshot.get("serchID") ?? "";
    firebaseID = snapshot.get("firebaseID") ?? "";
    userName = snapshot.get("userName") ?? "";
    gender = snapshot.get("gender") ?? "";
    password = snapshot.get("password") ?? "";
    emailAddress = snapshot.get("emailAddress") ?? "";
    emailVerified = snapshot.get("emailVerified") ?? "";
    country = snapshot.get("country") ?? "";
    countryDialCode = snapshot.get("countryDialCode") ?? "";
    phoneCountryCode = snapshot.get("phoneCountryCode") ?? "";
    phoneCountryISOCode = snapshot.get("phoneCountryISOCode") ?? "";
  }
}

class UserAddInfo{
  String? streetNumber; String? streetName; String? lga; String? landMark; String? userCity;
  String? stateOfOrigin; String? country; String? emailAlternate; String? alternatePhoneNumber;
  String? nokTitle; String? nokRelationship; String? nokFirstName; String? nokLastName;
  String? nokEmailAddress; String? nokPhoneNumber; String? nokAddress; String? nokCity; String? nokState; String? nokCountry;
  UserAddInfo({
    this.streetNumber, this.streetName, this.lga, this.landMark, this.userCity,
    this.stateOfOrigin, this.country, this.emailAlternate, this.alternatePhoneNumber,
    this.nokTitle, this.nokRelationship, this.nokFirstName, this.nokLastName,
    this.nokEmailAddress, this.nokPhoneNumber, this.nokAddress, this.nokCity, this.nokState, this.nokCountry
  });

  UserAddInfo.fromSnapshot(snapshot){
    streetNumber = snapshot.get("streetNumber") ?? "";
    streetName = snapshot.get("streetName") ?? "";
    lga = snapshot.get("lga") ?? "";
    landMark = snapshot.get("landMark") ?? "";
    userCity = snapshot.get("city") ?? "";
    stateOfOrigin = snapshot.get("state") ?? "";
    country = snapshot.get("country") ?? "";
    emailAlternate = snapshot.get("emailAlternate") ?? "";
    alternatePhoneNumber = snapshot.get("alternatePhoneNumber") ?? "";
    nokTitle = snapshot.get("next-of-kin-title") ?? "";
    nokRelationship = snapshot.get("next-of-kin-relationship") ?? "";
    nokFirstName = snapshot.get("next-of-kin-firstName") ?? "";
    nokLastName = snapshot.get("next-of-kin-lastName") ?? "";
    nokEmailAddress = snapshot.get("next-of-kin-emailAddress") ?? "";
    nokPhoneNumber = snapshot.get("next-of-kin-phoneNumber") ?? "";
    nokAddress = snapshot.get("next-of-kin-address") ?? "";
    nokCity = snapshot.get("next-of-kin-city") ?? "";
    nokState = snapshot.get("next-of-kin-state") ?? "";
    nokCountry = snapshot.get("next-of-kin-country") ?? "";
  }
}

class UserServiceInfo{
  String? service, latitude, longitude, createdAt, serviceAddress;
  Map<dynamic, dynamic>? serviceLocation; bool? online;
  UserServiceInfo({this.service, this.serviceLocation, this.latitude, this.longitude, this.createdAt, this.serviceAddress, this.online});

  UserServiceInfo.fromSnapshot(snapshot){
    service = snapshot.get("service") ?? "";
    latitude = snapshot.get("latitude") ?? "";
    longitude = snapshot.get("longitude") ?? "";
    createdAt = snapshot.get("createdAt") ?? "";
    serviceAddress = snapshot.get("serviceAddress") ?? "";
    serviceLocation = snapshot.get("serviceLocation") ?? "";
    online = snapshot.get("online") ?? "";
  }
}

UserInfo? currentUserInfo;
UserAddInfo? currentUserAddInfo;
UserServiceInfo? currentUserServiceInfo;

class SerchUser{

  static void getCurrentUserInfo() async {
    // final user = FbAuth().currentUser;
    // DocumentReference ref = MainDB().providers.doc(user?.email).collection(SecondDB.profile).doc(ProfileDB.detail);

    // ref.get().then((snapshot) {
    //   if(snapshot.data() != null){
    //     currentUserInfo = UserInfo.fromSnapshot(snapshot);
    //   } else {
    //     debugShow("Error");
    //   }
    // }).onError((error, stackTrace) => debugShow(error));
  }

  static void getCurrentUserAddInfo() async {
    // final user = FbAuth().currentUser;
    // DocumentReference ref = MainDB().providers.doc(user?.email).collection(SecondDB.profile).doc(ProfileDB.additional);

    // ref.get().then((snapshot) {
    //   if(snapshot.data() != null){
    //     currentUserAddInfo = UserAddInfo.fromSnapshot(snapshot);
    //   } else {
    //     debugShow("Error");
    //   }
    // }).onError((error, stackTrace) => debugShow(error));
  }

  static void getCurrentUserServiceInfo() async {
    // final user = FbAuth().currentUser;
    // DocumentReference ref = MainDB().providers.doc(user?.email).collection(SecondDB.profile).doc(ProfileDB.service);

    // ref.get().then((snapshot) {
    //   if(snapshot.data() != null){
    //     currentUserServiceInfo = UserServiceInfo.fromSnapshot(snapshot);
    //   } else {
    //     debugShow("Error");
    //   }
    // }).onError((error, stackTrace) => debugShow(error));
  }
}