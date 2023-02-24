import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Initializers{
  StreamSubscription? subscription;

  changePage(page, context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => page
      ));
    });
  }

  Future<void> initializeSerchUser(context) async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      try {
        // Get.offAll(() => const BottomNavigator());
        final userID = supabase.auth.currentUser;
        final result = await supabase.from(Supa().profile).select().eq("serchAuth", userID!.id).single() as Map;
        final model = UserInformationModel(
          emailAddress: result["emailAddress"], firstName: result["firstName"], lastName: result["lastName"],
          referLink: result["referLink"], gender: result["gender"], serchAuth: result["serchAuth"], serchID: result["serchID"],
          phoneInfo: UserPhoneInfo.fromJson(result["phoneInfo"] as Map<String, dynamic>), avatar: result["avatar"],
          countryInfo: UserCountryInfo.fromJson(result["countryInfo"] as Map<String, dynamic>), totalShared: result["totalShared"],
          password: result["password"], totalRating: result["totalRating"], numberOfRating: result["numberOfRating"],
          totalServiceTrips: result["total_service_trips"], balance: result["balance"], certificate: result["certificate"],
          service: result["service"],
        );
        HiveUserDatabase().saveProfileData(model);
        getServiceAndPlan(model);
        getConnectionModel(model);
        getMyRequestShare(model);
        getOtherRequestShare(model);
        getScheduleList(model);
        initializeCallHistory(model);
        getLatestMessagesList(model);
        getSettingModel(model);
        changePage(const BottomNavigator(), context);
      } on PostgrestException {
        changePage(const SignupScreen(), context);
      }
    } else {
      changePage(const OnboardScreen(), context);
    }
  }

  Future<void> initializeUserAdditionalInfo(UserInformationModel userInformationModel) async {
    try {
      final json = await supabase.from(Supa().additionalInfo).select().eq("serchID", userInformationModel.serchID).single() as Map;
      final model = UserAdditionalModel(
        stNo: json["stNo"], stName: json["stName"], lga: json["lga"], landMark: json["landMark"], city: json["city"],
        state: json["state"], country: json["country"], emailAlternate: json["emailAlternate"], phoneAlternate: json["phoneAlternate"],
        nokTitle: json["nokTitle"], nokRelationship: json["nokRelationship"], nokFirstName: json["nokFirstName"],
        nokLastName: json["nokLastName"], nokEmail: json["nokEmail"], nokPhone: json["nokPhone"], nokAddress: json["nokAddress"],
        nokCity: json["nokCity"], nokState: json["nokState"], nokCountry: json["nokCountry"],
      );
      HiveUserDatabase().saveAdditionalData(model);
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getRateLists(UserInformationModel userInformationModel) async {
    try {
      final ratingList = await supabase.from(Supa().rating).select().eq("serchID", userInformationModel.serchID) as List;
      if(ratingList.isNotEmpty){
        final ratings = ratingList.map((rating) => UserRatingsModel.fromJson(rating)).toList();
        HiveUserDatabase().saveRatingsDataList(ratings);
      } else {
        final ratingList = [];
        final ratings = ratingList.map((rating) => UserRatingsModel.fromJson(rating)).toList();
        HiveUserDatabase().saveRatingsDataList(ratings);
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getSettingModel(UserInformationModel userInformationModel) async {
    // Subscribe to changes in the Supabase table
    try {
      final settings = await supabase.from(Supa().setting).select().eq("serchID", userInformationModel.serchID)
        .single() as Map;
      final serviceModel = UserSettingModel.fromMap(settings as Map<String, dynamic>);
      HiveUserDatabase().saveSettingData(serviceModel);
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  void disposeSubscription() => subscription?.cancel();

  Future<void> initializeCallHistory(UserInformationModel userInformationModel) async {
    try {
      final callList = await supabase.from(Supa().callHistory).select().eq("serchID", userInformationModel.serchID).order("created_at") as List;
      if(callList.isNotEmpty){
        final callModel = callList.map((call) => UserCallModel.fromJson(call)).toList();
        HiveUserDatabase().saveCallDataList(callModel);
      } else {
        final callList = [];
        final callModel = callList.map((call) => UserCallModel.fromJson(call)).toList();
        HiveUserDatabase().saveCallDataList(callModel);
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getServiceAndPlan(UserInformationModel userInformationModel) async {
    try {
      final serviceAndPlan = await supabase.from(Supa().serviceAndPlan).select().eq("serchID", userInformationModel.serchID)
        .single() as Map;
      final serviceModel = UserServiceAndPlan(
        plan: serviceAndPlan["plan"], freeTrial: serviceAndPlan["free_trial"],
        paymentMethod: serviceAndPlan["payment_method"], onRequestShare: serviceAndPlan["on_request_share"],
        onTrip: serviceAndPlan["on_trip"], status: serviceAndPlan["status"]
      );
      HiveUserDatabase().saveServiceAndPlanData(serviceModel);
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getConnectionModel(UserInformationModel userInformationModel) async {
    try {
      UserServiceAndPlan serviceAndPlan = HiveUserDatabase().getServiceAndPlanData();
      if(serviceAndPlan.onTrip){
        final connect = await supabase.from(Supa().connection).select().eq("serchID", userInformationModel.serchID).single() as Map;
        DateTime createdAt = TimeFormatter.supabaseDateParser.parse(connect["created_at"]);
        DateTime nowDate = DateTime.now();
        final modelDate = nowDate.day == createdAt.day && nowDate.month == createdAt.month && nowDate.year == createdAt.year;
        if(modelDate){
          final connected = UserConnectedModel(
            firstName: connect["firstName"], lastName: connect["lastName"], avatar: connect["avatar"], rate: connect["rate"],
            connectID: connect["connectID"], serchID: connect["serchID"]
          );
          HiveUserDatabase().saveConnectedData(connected);
        }
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getScheduleList(UserInformationModel userInformationModel) async {
    try {
      final scheduleList = await supabase.from(Supa().scheduled).select().eq("serchID", userInformationModel.serchID) as List;
      if(scheduleList.isNotEmpty){
        final scheduleModel = scheduleList.map((schedule) => UserScheduleModel.fromJson(schedule)).toList();
        HiveUserDatabase().saveScheduleDataList(scheduleModel);
      } else {
        final scheduled = [];
        final scheduleModel = scheduled.map((schedule) => UserScheduleModel.fromJson(schedule)).toList();
        HiveUserDatabase().saveScheduleDataList(scheduleModel);
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getMyRequestShare(UserInformationModel userInformationModel) async {
    try {
      UserServiceAndPlan serviceAndPlan = HiveUserDatabase().getServiceAndPlanData();
      if(serviceAndPlan.onRequestShare){
        final request = await supabase.from(Supa().requestShare).select().eq("rsID", userInformationModel.serchID).single() as Map;
        DateTime createdAtDate = TimeFormatter.supabaseDateParser.parse(request["created_at"]);
        DateTime now = DateTime.now();
        final date = now.day == createdAtDate.day && now.month == createdAtDate.month && now.year == createdAtDate.year;
        if(date){
          final requestShare = UserRequestShare(
            rsFirstName: request["rsFirstName"], rsLastName: request["rsLastName"], rsImage: request["rsImage"],
            rsID: request["rsID"], serchID: request["serchID"],
          );
          HiveUserDatabase().saveMyRequestShareData(requestShare);
        }
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getOtherRequestShare(UserInformationModel userInformationModel) async {
    try {
      UserServiceAndPlan serviceAndPlan = HiveUserDatabase().getServiceAndPlanData();
      if(serviceAndPlan.onRequestShare){
        final request = await supabase.from(Supa().requestShare).select().eq("serchID", userInformationModel.serchID).single() as Map;
        DateTime createdAtDate = TimeFormatter.supabaseDateParser.parse(request["created_at"]);
        DateTime now = DateTime.now();
        final date = now.day == createdAtDate.day && now.month == createdAtDate.month && now.year == createdAtDate.year;
        if(date){
          final requestShare = UserRequestShare(
            rsFirstName: request["rsFirstName"], rsLastName: request["rsLastName"], rsImage: request["rsImage"],
            rsID: request["rsID"], serchID: request["serchID"],
          );
          HiveUserDatabase().saveOtherRequestShareData(requestShare);
        }
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getProfile(UserInformationModel userInformationModel) async {
    try {
      final result = await supabase.from(Supa().profile).select().eq("serchAuth", userInformationModel.serchAuth).single() as Map;
      final model = UserInformationModel(
        emailAddress: result["emailAddress"], firstName: result["firstName"], lastName: result["lastName"],
        referLink: result["referLink"], gender: result["gender"], serchAuth: result["serchAuth"], serchID: result["serchID"],
        phoneInfo: UserPhoneInfo.fromJson(result["phoneInfo"] as Map<String, dynamic>), avatar: result["avatar"],
        countryInfo: UserCountryInfo.fromJson(result["countryInfo"] as Map<String, dynamic>), totalShared: result["totalShared"],
        password: result["password"], totalRating: result["totalRating"], numberOfRating: result["numberOfRating"],
        totalServiceTrips: result["total_service_trips"], balance: result["balance"], certificate: result["certificate"],
      );
      HiveUserDatabase().saveProfileData(model);
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  Future<void> getLatestMessagesList(UserInformationModel userInformationModel) async {
    try {
      final roomList = await supabase.from(Supa().chatRoom).select().or("serchID.eq.${userInformationModel.serchID}")
        .or("second_serchID.eq.${userInformationModel.serchID}").order("created_at") as List;
      final rooms = roomList.map((e) => UserChatRoomModel.fromRoomParticipants(e)).where(
        (room) => room.otherUserID != userInformationModel.serchID || room.serchID != userInformationModel.serchID).toList();
      HiveUserDatabase().saveChatRoomDataList(rooms);
      for(final room in rooms) {
        final message = await supabase.from(Supa().messages).select().eq('room_id', room.roomID).order('created_at').limit(1) as List;
        final thisUserID = room.otherUserID == userInformationModel.serchID ? room.otherUserID : room.serchID == userInformationModel.serchID ? room.serchID : "";
        // final otherUserID = room.otherUserID != userInformationModel.serchID ? room.otherUserID : room.serchID != userInformationModel.serchID ? room.serchID : "";
        final messages = message.map((e) => UserChatModel.fromJson(e, thisUserID)).toList();
        HiveUserDatabase().saveChatDataList(messages);
        // getChatProfile(otherUserID, profiles);
      }
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }
}