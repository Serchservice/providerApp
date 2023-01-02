import 'package:provide/lib.dart';

class AuthIDB{
  Future signUp({
    String? username, required String password, required String email,
    required String firstName, required String lastName, required String phoneNumber,
    required String gender, bool? emailVerified,
    String? phone, String? phoneCountryCode, String? phoneCountryISOCode,
    String? country, String? countryCode, String? countryDialCode, String? countryFlag, String? serchID, String? firebaseID,
  }) async {
    // await MainDB().providers.doc(user?.email)
    // .collection(SecondDB.profile).doc(ProfileDB.detail).set({
    //   "serchID": serchID,
    //   "firebaseID": firebaseID,
    //   "userName": username,
    //   "firstName": firstName,
    //   "lastName": lastName,
    //   "gender": gender,
    //   "password": password,
    //   "emailAddress": email,
    //   "emailVerified": emailVerified,
    //   "phone": phone,
    //   "phoneNumber": phoneNumber,
    //   "phoneCountryCode": phoneCountryCode,
    //   "phoneCountryISOCode": phoneCountryISOCode,
    //   "country": country,
    //   "countryCode": countryCode,
    //   "countryDialCode": countryDialCode,
    //   "countryFlag": countryFlag,
    // },
    // SetOptions(merge: true,));
  }

  Future addservice({required String service}) async {
    // await MainDB().providers.doc(user?.email)
    // .collection(SecondDB.profile).doc(ProfileDB.service).set({"service": service}, SetOptions(merge: true));
  }

  Future addform({
    required String streetNumber, streetName, lga, landMark, userCity, stateOfOrigin, country, emailAlternate,
    required String alternatePhoneNumber, nokTitle, nokRelationship, nokFirstName, nokLastName, nokEmailAddress,
    required String nokPhoneNumber, nokAddress, nokCity, nokState, nokCountry
  }) async {
  //   await MainDB().providers.doc(user?.email)
  //   .collection(SecondDB.profile).doc(ProfileDB.additional).set({
  //     "streetNumber" : streetNumber, "streetName" : streetName, "lga" : lga, "landMark" : landMark,
  //     "city" : userCity, "state" : stateOfOrigin, "country" : country, "emailAlternate" : emailAlternate,
  //     "alternatePhoneNumber" : alternatePhoneNumber, "next-of-kin-title" : nokTitle, "next-of-kin-relationship" : nokRelationship,
  //     "next-of-kin-firstName" : nokFirstName, "next-of-kin-lastName" : nokLastName, "next-of-kin-emailAddress" : nokEmailAddress,
  //     "next-of-kin-phoneNumber" : nokPhoneNumber, "next-of-kin-address" : nokAddress, "next-of-kin-city" : nokCity,
  //     "next-of-kin-state" : nokState, "next-of-kin-country" : nokCountry
  //   }, SetOptions(merge: true)
  // );
  }
}