import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:provide/lib.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  final storage = const FlutterSecureStorage();

  // Store data
  // void storeCreatedTimes() async {
  //   await storage.write(key: "1", value: "myValue");
  // }

  // // Read data
  // void readCreatedTimes() async {
  //   String? value = await storage.read(key: "1");
  // }

  // // Delete data
  // await storage.delete(key: "myKey");
}

class HiveUserDatabase{
  final connect = Hive.box(SharedBoxes().database);

  //Getting and Saving the User's profile data
  UserInformationModel getProfileData() {
    final result = connect.get(1);
    if(result == null){
      return const UserInformationModel();
    } else {
      final newJson = UserInformationModel.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveProfileData(UserInformationModel model) {
    final data = UserInformationModel(countryInfo: model.countryInfo, emailAddress: model.emailAddress, lastName: model.lastName,
      firstName: model.firstName, referLink: model.referLink, gender: model.gender, phoneInfo: model.phoneInfo, avatar: model.avatar,
      serchAuth: model.serchAuth, serchID: model.serchID, totalRating: model.totalRating, numberOfRating: model.numberOfRating,
      password: model.password, totalServiceTrips: model.totalServiceTrips, balance: model.balance, totalShared: model.totalShared,
      service: model.service,
    );
    final newJson = json.encode(data.toJson());
    connect.put(1, newJson);
  }

  //Getting and Saving User's service and plan
  UserServiceAndPlan getServiceAndPlanData() {
    final result = connect.get(2);
    if(result == null){
      return const UserServiceAndPlan();
    } else {
      final newJson = UserServiceAndPlan.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveServiceAndPlanData(UserServiceAndPlan model) {
    final data = UserServiceAndPlan(serchID: model.serchID, paymentMethod: model.paymentMethod,
      plan: model.plan, freeTrial: model.freeTrial, onRequestShare: model.onRequestShare,
      onTrip: model.onTrip, status: model.status
    );
    final newJson = json.encode(data.toJson());
    connect.put(2, newJson);
  }

  //Getting and Saving User's additional information
  UserAdditionalModel getAdditionalData() {
    final result = connect.get(3);
    if(result == null){
      return UserAdditionalModel();
    } else {
      final newJson = UserAdditionalModel.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveAdditionalData(UserAdditionalModel model) {
    final data = UserAdditionalModel(city: model.city, state: model.state, serchID: model.serchID, stName: model.stName,
      stNo: model.stNo, lga: model.lga, landMark: model.landMark, country: model.country, emailAlternate: model.emailAlternate,
      phoneAlternate: model.phoneAlternate, nokAddress: model.nokAddress, nokCity: model.nokCity, nokCountry: model.nokCountry,
      nokEmail: model.nokEmail, nokFirstName: model.nokFirstName, nokLastName: model.nokLastName, nokPhone: model.nokPhone,
      nokRelationship: model.nokRelationship, nokTitle: model.nokTitle, nokState: model.nokState
    );
    final newJson = json.encode(data.toJson());
    connect.put(3, newJson);
  }

  //Get and save schedules
  List<UserScheduleModel> getScheduleDataList() {
    final result = connect.get(4);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserScheduleModel> newList = decodedResult.map((e) => UserScheduleModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveScheduleDataList(List<UserScheduleModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(4, newJson);
  }

  void addUserScheduleModelToList(UserScheduleModel model) {
    List<UserScheduleModel> existingList = getScheduleDataList();
    existingList.add(model);
    saveScheduleDataList(existingList);
  }

  //Get and save rates
  UserRateModel getRateData() {
    final result = connect.get(5);
    if(result == null){
      return UserRateModel();
    } else {
      final newJson = UserRateModel.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveRateData(UserRateModel model) {
    final data = UserRateModel(raterComment: model.raterComment, raterID: model.raterID, raterImage: model.raterImage,
      raterName: model.raterName, raterRate: model.raterRate, serchID: model.serchID,
    );
    final newJson = json.encode(data.toJson());
    connect.put(5, newJson);
  }

  //Get and save money/transactions
  List<UserMoneyModel> getMoneyDataList() {
    final result = connect.get(6);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserMoneyModel> newList = decodedResult.map((e) => UserMoneyModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveMoneyDataList(List<UserMoneyModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(6, newJson);
  }

  void addUserMoneyModelToList(UserMoneyModel model) {
    List<UserMoneyModel> existingList = getMoneyDataList();
    existingList.add(model);
    saveMoneyDataList(existingList);
  }

  //Get and save referrals
  List<UserReferralModel> getReferralDataList() {
    final result = connect.get(7);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserReferralModel> newList = decodedResult.map((e) => UserReferralModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveReferralDataList(List<UserReferralModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(7, newJson);
  }

  void addUserReferralModelToList(UserReferralModel model) {
    List<UserReferralModel> existingList = getReferralDataList();
    existingList.add(model);
    saveReferralDataList(existingList);
  }

  //Get and save bank card details
  UserBankCardModel getBankCardData() {
    final result = connect.get(8);
    if(result == null){
      return UserBankCardModel();
    } else {
      final newJson = UserBankCardModel.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveBankCardData(UserBankCardModel model) {
    final data = UserBankCardModel(serchID: model.serchID, cardCode: model.cardCode, cardExpiryDate: model.cardExpiryDate,
      cardName: model.cardName, cardNumber: model.cardNumber, cardType: model.cardType
    );
    final newJson = json.encode(data.toJson());
    connect.put(8, newJson);
  }

  //Get and save bank account details
  UserBankAccountModel getBankAccountData() {
    final result = connect.get(9);
    if(result == null){
      return UserBankAccountModel();
    } else {
      final newJson = UserBankAccountModel.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveBankAccountData(UserBankAccountModel model) {
    final data = UserBankAccountModel(serchID: model.serchID, accountName: model.accountName, bankName: model.bankName,
      accountNumber: model.accountNumber
    );
    final newJson = json.encode(data.toJson());
    connect.put(9, newJson);
  }

  //Get and save bank card details
  UserSettingModel getSettingData() {
    final result = connect.get(10);
    if(result == null){
      return UserSettingModel();
    } else {
      final newJson = UserSettingModel.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveSettingData(UserSettingModel model) {
    final data = UserSettingModel(serchID: model.serchID, tfa: model.tfa, swm: model.swm, ctg: model.ctg, tfaCode: model.tfaCode,
      alwaysOnline: model.alwaysOnline, biometrics: model.biometrics, emailSecure: model.emailSecure, showOnMap: model.showOnMap
    );
    final newJson = json.encode(data.toJson());
    connect.put(10, newJson);
  }

  //Get and save rating lists
  List<UserRateModel> getRateDataList() {
    final result = connect.get(11);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserRateModel> newList = decodedResult.map((e) => UserRateModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveRateDataList(List<UserRateModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(11, newJson);
  }

  void addUserRateModelToList(UserRateModel model) {
    List<UserRateModel> existingList = getRateDataList();
    existingList.add(model);
    saveRateDataList(existingList);
  }

  //Get and save bookmark lists
  List<UserBookmarkModel> getBookmarkDataList() {
    final result = connect.get(12);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserBookmarkModel> newList = decodedResult.map((e) => UserBookmarkModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveBookmarkDataList(List<UserBookmarkModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(12, newJson);
  }

  void addUserBookmarkModelToList(UserBookmarkModel model) {
    List<UserBookmarkModel> existingList = getBookmarkDataList();
    existingList.add(model);
    saveBookmarkDataList(existingList);
  }

  //Get and save rating lists
  List<UserRatingsModel> getRatingsDataList() {
    final result = connect.get(13);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserRatingsModel> newList = decodedResult.map((e) => UserRatingsModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveRatingsDataList(List<UserRatingsModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(13, newJson);
  }

  void addUserRatingsModelToList(UserRatingsModel model) {
    List<UserRatingsModel> existingList = getRatingsDataList();
    existingList.add(model);
    saveRatingsDataList(existingList);
  }

  //Get and save call histories
  List<UserCallModel> getCallDataList() {
    final result = connect.get(14);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserCallModel> newList = decodedResult.map((e) => UserCallModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveCallDataList(List<UserCallModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(14, newJson);
  }

  void addUserCallModelToList(UserCallModel model) {
    List<UserCallModel> existingList = getCallDataList();
    existingList.add(model);
    saveCallDataList(existingList);
  }

  //Getting and Saving User's requestShare
  UserRequestShare getMyRequestShareData() {
    final result = connect.get(15);
    if(result == null){
      return UserRequestShare();
    } else {
      final newJson = UserRequestShare.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveMyRequestShareData(UserRequestShare model) {
    final data = UserRequestShare(
      rsFirstName: model.rsFirstName, rsID: model.rsID, rsImage: model.rsImage, rsLastName: model.rsLastName, serchID: model.serchID
    );
    final newJson = json.encode(data.toJson());
    connect.put(15, newJson);
  }

  //Getting and Saving User's connected requestShare
  UserRequestShare getOtherRequestShareData() {
    final result = connect.get(16);
    if(result == null){
      return UserRequestShare();
    } else {
      final newJson = UserRequestShare.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveOtherRequestShareData(UserRequestShare model) {
    final data = UserRequestShare(
      rsFirstName: model.rsFirstName, rsID: model.rsID, rsImage: model.rsImage, rsLastName: model.rsLastName, serchID: model.serchID
    );
    final newJson = json.encode(data.toJson());
    connect.put(16, newJson);
  }

  //Getting and Saving connected data
  UserConnectedModel getConnectedData() {
    final result = connect.get(17);
    if(result == null){
      return UserConnectedModel();
    } else {
      final newJson = UserConnectedModel.fromJson(json.decode(result));
      return newJson;
    }
  }

  void saveConnectedData(UserConnectedModel model) {
    final data = UserConnectedModel(
      firstName: model.firstName, connectID: model.connectID, avatar: model.avatar, lastName: model.lastName, serchID: model.serchID,
      rate: model.rate
    );
    final newJson = json.encode(data.toJson());
    connect.put(17, newJson);
  }

  //Get and save chat histories
  List<UserChatModel> getChatDataList() {
    final result = connect.get(18);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserChatModel> newList = decodedResult.map((e) => UserChatModel.fromJson(e, e)).toList();
      return newList;
    }
  }

  void saveChatDataList(List<UserChatModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(18, newJson);
  }

  void addUserChatModelToList(UserChatModel model) {
    List<UserChatModel> existingList = getChatDataList();
    existingList.add(model);
    saveChatDataList(existingList);
  }

  //Get and save chatRoom histories
  List<UserChatRoomModel> getChatRoomDataList() {
    final result = connect.get(19);
    if(result == null){
      return [];
    } else {
      List<dynamic> decodedResult = json.decode(result);
      List<UserChatRoomModel> newList = decodedResult.map((e) => UserChatRoomModel.fromJson(e)).toList();
      return newList;
    }
  }

  void saveChatRoomDataList(List<UserChatRoomModel> models) {
    final newJson = json.encode(models.map((item) => item.toJson()).toList());
    connect.put(19, newJson);
  }

  void addUserChatRoomModelToList(UserChatRoomModel model) {
    List<UserChatRoomModel> existingList = getChatRoomDataList();
    existingList.add(model);
    saveChatRoomDataList(existingList);
  }

  //Get and save chatRoom histories
  // Map<String, UserInformationModel> getProfiles() {
  //   final result = connect.get(19);
  //   if(result == null) {
  //     return {};
  //   } else {

  //   }
  //   final box = Hive.box<Map<String, UserInformationModel>>('profiles');
  //   final profiles = box.get('profiles', defaultValue: {})!;
  //   return profiles;
  // }

  // void saveProfiles(Map<String, UserInformationModel?> profiles) {
  //   final box = Hive.box<Map<String, UserInformationModel?>>('profiles');
  //   box.put('profiles', profiles);
  // }

  // void addProfile(String userId, UserInformationModel? profile) {
  //   final box = Hive.box<Map<String, UserInformationModel?>>('profiles');
  //   final profiles = box.get('profiles', defaultValue: {})!;
  //   profiles[userId] = profile;
  //   box.put('profiles', profiles);
  // }
}