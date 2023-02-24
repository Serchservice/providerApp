import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = "https://ykoomqbmtnepnyhvzuww.supabase.co";
const supabaseAnon = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrb29tcWJtdG5lcG55aHZ6dXd3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEzODk0OTgsImV4cCI6MTk4Njk2NTQ5OH0.e8elbnyzixeP11IZyr1p2FHTdyaOgTG1w3RRydU2o6w";
final supabase = Supabase.instance.client;
const paystackPublicKey = "pk_test_511cad8766dada648e9ceb87b3cbc364950ff365";

class SupaUser{
  final profile = "user_profile";
  final setting = "user_setting";
  final transaction = "user_transaction";
  final scheduled = "user_scheduled";
  final referral = "user_referral";
  final rating = "user_rating";
  final bankCard = "user_bank_card";
  final location = "user_location";
  final bookmarks = "user_bookmarks";
  final callHistory = "user_call_history";
  final connection = "user_connected";
  final service = "user_service";
  final profilePictureStorage = "profile-pictures/user-pictures/";
}
class Supa{
  final User? user = supabase.auth.currentUser;
  final Session? session = supabase.auth.currentSession;
  final messages = "chat_messages";
  final chatRoom = "chat_rooms";
  // final chatRoomParticipants = "chat_room_participants";

  final profile = "provider_profile";
  final setting = "provider_setting";
  final serviceAndPlan = "provider_service_and_plan";
  final additionalInfo = "provider_additional_info";
  final transaction = "provider_transaction";
  final scheduled = "provider_scheduled";
  final referral = "provider_referral";
  final rating = "provider_rating";
  final bankCard = "provider_bank_card";
  final bankAccount = "provider_bank_account";
  final location = "provider_location";
  final bookmarkers = "provider_bookmarkers";
  final profilePictureStorage = "profile-pictures/provider-pictures/";
  final callHistory = "provider_call_history";
  final requestShare = "provider_request_share";
  final connection = "provider_connected";

  StreamSubscription<AuthState> listenToAuthStatus(page) {
    return supabase.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      final AuthChangeEvent event = data.event;

      switch (event) {
        case AuthChangeEvent.signedIn:
          if(session != null) {
            Get.offAll(() => page);
          } else {
            Get.offAll(() => page);
          }
          break;
        case AuthChangeEvent.signedOut:
          if(session != null) {
            break;
          }
          break;
        case AuthChangeEvent.passwordRecovery:
          if(session != null) {
            break;
          }
          break;
        case AuthChangeEvent.userDeleted:
          if(session != null) {
            break;
          }
          break;
        case AuthChangeEvent.userUpdated:
        default:
      }
    });
  }
}