import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class UserInformation extends ChangeNotifier{
  ///Provider for User Basic Information
  ///
  ///This Provider stores the user's information upon registration, which makes it easy for the user's details to be retrieved without
  ///the stress of calling the database everytime.
  ///
  ///If the user's session is null, the database will be called to receive the user's information upon logging in, and then the provider will
  ///be updated with the user's latest version of it's data.
  ///
  ///This will make the database calling to be much lesser than initially done.
  UserInformationModel user = UserInformationModel();

  // String? _status;
  // String get status => _status!;

  // set status(String value){
  //   if(value != _status){
  //     _status = value;
  //     notifyListeners();
  //   }
  // }

  void updateUserInformation({
    String? newId, String? newEmail, String? newFirstName, String? newLastName, String? newPhone, String? newPhoneNumber, String? newImage,
    String? newUserName, String? newPassword, String? newEmailAddress, String? newCountry, String? newCountryDialCode, String? newSerchID,
    String? newDatabaseID, String? newGender, String? newPhoneCountryCode, String? newPhoneCountryISOCode, bool? newEmailVerified
  }) {
    user.id = newId ?? ""; user.email = newEmail ?? ""; user.firstName = newFirstName ?? ""; user.lastName = newLastName ?? ""; user.phone = newPhone ?? "";
    user.phoneNumber = newPhoneNumber ?? ""; user.userName = newUserName ?? ""; user.password = newPassword ?? ""; user.emailAddress = newEmailAddress ?? "";
    user.country = newCountry ?? ""; user.countryDialCode = newCountryDialCode ?? ""; user.serchID = newSerchID ?? ""; user.databaseID = newDatabaseID ?? "";
    user.gender = newGender ?? ""; user.phoneCountryCode = newPhoneCountryCode ?? ""; user.emailVerified = newEmailVerified ?? false;
    user.phoneCountryISOCode = newPhoneCountryISOCode ?? ""; user.image = newImage ?? "";

    notifyListeners();
  }
}

class UserAdditionalInformation extends ChangeNotifier{
  ///Provider for User Additional Information
  ///
  ///This Provider stores the user's additional information upon registration, which makes it easy for the user's details to be retrieved without
  ///the stress of calling the database everytime.
  ///
  ///If the user's session is null, the database will be called to receive the user's additional information upon logging in,
  ///and then the provider will be updated with the user's latest version of it's data.
  ///
  ///This will make the database calling to be much lesser than initially done.
  ///

  UserAdditionalModel user = UserAdditionalModel();

  void updateUserInformation({
    String? newStreetNumber, String? newStreetName, String? newLga, String? newLandMark, String? newUserCity, String? newStateOfOrigin,
    String? newUserCountry, String? newEmailAlternate, String? newAlternatePhoneNumber, String? newNokTitle, String? newNokRelationship,
    String? newNokFirstName, String? newNokLastName, String? newNokCountry, String? newNokEmailAddress, String? newNokPhoneNumber,
    String? newNokAddress, String? newNokCity, String? newNokState,
  }){
    user.streetNumber = newStreetNumber; user.streetName = newStreetName; user.lga = newLga; user.landMark = newLandMark;
    user.userCity = newUserCity; user.stateOfOrigin = newStateOfOrigin; user.userCountry = newUserCountry; user.emailAlternate = newEmailAlternate;
    user.alternatePhoneNumber = newAlternatePhoneNumber; user.nokTitle = newNokTitle; user.nokRelationship = newNokRelationship;
    user.nokFirstName = newNokFirstName; user.nokLastName = newNokLastName; user.nokCountry = newNokCountry;
    user.nokEmailAddress = newNokEmailAddress; user.nokPhoneNumber = newNokPhoneNumber; user.nokAddress = newNokAddress; user.nokCity = newNokCity;
    user.nokState = newNokState;

    notifyListeners();
  }
}

class UserMapInformation extends ChangeNotifier {
  ///Provider for User Map Information
  ///
  ///This Provider stores the user's map information upon every log in. This enables the geofencing to read and know the latitude and longitude
  ///of the user.
  ///

  AddressModel? homeLocation, serviceLocation, currentLocation;

  void updateHomeLocation(AddressModel homeAddress){
    homeLocation = homeAddress;
    notifyListeners();
  }

  void updateServiceLocation(AddressModel serviceAddress){
    serviceLocation = serviceAddress;
    notifyListeners();
  }

  void updateCurrentLocation(AddressModel currentAddress){
    currentLocation = currentAddress;
    notifyListeners();
  }
}

class UserServiceInformation extends ChangeNotifier{
  String? service; String status = "Offline";

  void updateStatus({required String newStatus}){
    status = newStatus;
    notifyListeners();
  }

  void updateService({required String newService}){
    service = newService;
    notifyListeners();
  }
}

class UserScheduleList extends ChangeNotifier {
  ///Provider for User's List of Scheduled Service.
  ///
  ///This Provider stores the user's list of any service scheduled to happen at any certain point in a particular day. The scheduling is only
  ///limited to a day. After each day, the schedule list is cleared from the provider but not cleared from the database of the user.
  ///
  ///This schedule list is also restored when the user session is null. This is gotten from the database and stored in the user's provider. The
  ///essence of storing information here is to limit the database retrieval every moment.
  ///
  List<UserScheduledListModel>? scheduledList;

  void updateUserScheduleList({List<UserScheduledListModel>? newUserScheduleList}){
    scheduledList = newUserScheduleList;
    notifyListeners();
  }
}

class UserRatingInformation extends ChangeNotifier{
  UserRatingModel user = UserRatingModel();

  void updateUserRating({required double newTotalRating, required double newNumberRated}){
    user.totalRating = newTotalRating; user.numberRated = newNumberRated;
  }
}

class UserMoneyInformation extends ChangeNotifier{
  UserMoneyModel user = UserMoneyModel();

  void updateUserMoneyInformation({required double newAmount}){
    user.totalEarned = newAmount;
  }
}

class UserServiceTripInformation extends ChangeNotifier{
  bool? connectToGo;
  bool? stickWithMe;

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


