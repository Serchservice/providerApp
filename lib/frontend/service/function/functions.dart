import 'dart:io';
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';
import 'package:provide/lib.dart';

const screenPadding = EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0);
const horizontalPadding = EdgeInsets.symmetric(horizontal: 30.0);
const borderRadius = 20.0;
const chatBoxPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 6);
const outerOtherChatPadding = EdgeInsets.only(top: 4, bottom: 4, right: 80);
const outerMyChatPadding = EdgeInsets.only(top: 4, bottom: 4, left: 80);
const version = "0.1.0";
const googleMapApiKey = "AIzaSyDGQHWN3GYaaYfdaIKZktvDsW2MvymykCw";
const int zegoAppID = 188077855;
const zegoAppSign = "ce76ce538bd2857120f635545e316457322020a9b9a072993884735f61908b0e";

bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;
String twoDigits(int n) => n.toString().padLeft(2, "0");
typedef SFn = void Function();

class TimeFormatter{
  static final now = DateTime.now();
  static final supabaseDateParser = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS+00:00");
  static final supabaseDateParserTz = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ");
  final date = DateTime.parse("2023-02-03T14:00:00.000000+00:00");

  static String formatDateTime(DateTime dateTime) {
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if(today.day == dateTime.day && today.minute == dateTime.minute) {
      return "Just now";
    } else if (today.day == dateTime.day) {
      // today
      return DateFormat.jm().format(dateTime);
    } else if (dateTime.isAfter(yesterday)) {
      // yesterday
      return 'Yesterday, ${DateFormat.jm().format(dateTime)}';
    } else {
      // older dates
      final formatter = DateFormat('MMM d, h:mm a');
      return formatter.format(dateTime);
    }
  }

  static String formatDate(DateTime dateTime) {
    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(dateTime);
  }

  static String formatTime(Duration duration){
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds);

    return[
      if(duration.inHours > 0) hours, minutes, seconds
    ].join(':');
  }
}

class CodeGenerator {
  static Random random = Random();
  static const uniqueID = Uuid();
  var unique = uniqueID.v4();

  static String generateReferLink(){
    var unique = uniqueID.v4();
    return 'https://serchservice.com/?=refer-${unique.substring(0, 6)}';
  }

  static String generateSerchID(){
    var unique = uniqueID.v4();
    return unique;
  }

  static String generateRoomID(){
    var unique = uniqueID.v4();
    return "Serch-Room-$unique";
  }

  static String generateCallID() {
    var unique = uniqueID.v4();
    return unique.substring(0, 10);
  }

  static String generateUID(){
    const prefix = "Serch-ID-";
    const length = 15;
    const lowerCase = "abcdefghijklmnopqrstuvwxyz";
    const upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numbers = "0123456789";
    //const special = "!@#\$%^&*()_+=-.,/><';:\"][{}]";

    String code = "";
    code += "$prefix$upperCase$lowerCase$numbers";

    return List.generate(length, (index) {
      final random = Random.secure().nextInt(code.length);
      return code[random];
    }).join('');
  }
}

class CurrencyFormatter{
  static final formatter = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
  );

  static String formatMoney(int amount){
    final first = twoDigits(amount);
    final second = twoDigits(amount);

    return[
      first, second
    ].join('.');
  }

  static String getCurrency() {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return format.currencySymbol;
  }
}

class BasicFunctions{
  static String encodeImageToBase64(Uint8List imageData) {
    return base64Encode(imageData);
  }

  // Decode the base64 string to binary data
  static Uint8List decodeImageFromBase64(String base64String) {
    return base64Decode(base64String);
  }

  static Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  // final imageData = Uint8List.fromList([0, 1, 2, 3]);
  // final encodedImage = encodeImageToBase64(imageData);

  // final jsonData = {
  //   "image": encodedImage
  // };

  // final encodedJson = json.encode(jsonData);
  // final decodedJson = json.decode(encodedJson);

  // final decodedImage = decodeImageFromBase64(decodedJson['image']);
  // final image = Image.memory(decodedImage);
}

class WebFunctions{
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}'
    ).join('&');
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  static Future<void> launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication,);
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(url, mode: LaunchMode.inAppWebView,);
    }
  }

  static Future<void> launchMail(String prefix) async {
    final Uri mailtoUri = Uri(scheme: "mailto", path: "${prefix}serchservice.com");
    await launchUrl(mailtoUri);
  }

  static Future<void> openMail() async {
    final Uri mailtoUri = Uri(scheme: "mailto",);
    await launchUrl(mailtoUri);
  }

  static Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: WebViewConfiguration(
        headers: <String, String>{ url.host: url.path }),
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}

copy(String text){
  try {
    final data = ClipboardData(text: text);
    Clipboard.setData(data);
    showGetSnackbar(
      type: Popup.success, message: "Copied! You can now share your referral code", duration: const Duration(seconds: 3)
    );
  } on SException catch (e) {
    showGetSnackbar(message: e.message, type: Popup.error, duration: const Duration(seconds: 5));
  }
}

Future<bool> requestPermission(Permission permission) async {
  if(await permission.isGranted){
    return true;
  } else {
    var result = await permission.request();
    if(result == PermissionStatus.granted){
      return true;
    } else {
      return false;
    }
  }
}

Future checkFirstRun(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

  if (isFirstRun) {
   // Whatever you want to do, E.g. Navigator.push()
    // ignore: use_build_context_synchronously
    showImportantNotice(context);
    prefs.setBool('isFirstRun', false);
  } else {
    // ignore: use_build_context_synchronously
    // showImportantNotice(context);
    return null;
  }
}

//Create Serch path in platforms
newPath() async {
  Directory? directory;
  if(Platform.isAndroid){
    directory = await getExternalStorageDirectory();
    String serchPath = "";

    List<String> folders = directory!.path.split("/");
    for(int x = 1; x < folders.length; x++){
      String folder = folders[x];

      if(folder != "Android"){
        serchPath += "/$folder";
      } else {
        break;
      }
    }

    serchPath = "$serchPath/Serch";
    directory = Directory(serchPath);
  } else {
    directory = await getTemporaryDirectory();
  }

  if(!await directory.exists()){
    await directory.create(recursive: true);
  }

  // if(await directory.exists()){
  //   folderDirectory = "${directory.path}/$new";
  // }
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) return 'Good Morning, ';
  if (hour < 16) return 'Good Afternoon, ';
  if(hour < 20) return 'Good Evening, ';
  return 'Still up for fixing, ';
}

String statements() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'It\'s not too early to start receiving requests';
  } else if (hour < 10) {
    return 'The day is still bright. Let\'s go more?';
  } else if (hour < 16) {
    return 'You still got time. Let\'s get more offers!.';
  } else if (hour < 20) {
    return 'It\'s almost over. But let\'s make you more money.';
  }
  return 'Never lose out of any offers, we gat your back. ';
}

// Function to create a new chat room or return an existing one
Future<String?> createOrContinueChat(BuildContext context, String otherUserID, String thisUserID) async {
  try {
    // Check if chat room with both participants already exists
    final res = await supabase.from(Supa().chatRoom).select().or("second_serchID.eq.$otherUserID,serchID.eq.$thisUserID")
      .or("second_serchID.eq.$thisUserID,serchID.eq.$otherUserID").range(0, 1).single() as Map;
    final roomExists = res.isNotEmpty;
    final roomId = roomExists ? res['room_id'] : null;

    if (roomId == null) {
      // Create a new chat room
      var i = 1;
      final roomInfo = UserChatRoomModel(
        roomID: CodeGenerator.generateRoomID(), roomName: "Chatroom ${i++}",
        otherUserID: otherUserID, createdAt: DateTime.now(), lastMessage: UserChatModel(), serchID: thisUserID
      );
      final newRoomId = await supabase.from(Supa().chatRoom).insert(roomInfo.toJson()).select("room_id");
      // Insert both users into the new chat room
      // await supabase.from(Supa().chatRoomParticipants).insert([
      //   {'serchID': thisUserID, 'room_id': newRoomId},
      //   {'second_serch_ID': otherUserID, 'room_id': newRoomId},
      // ]);
      Get.to(() => UserChattingScreen.route(newRoomId));
      return newRoomId;
    }
    Get.to(() => UserChattingScreen.route(roomId));
    return roomId;
  } on PostgrestException catch (e) {
    return showGetSnackbar(message: e.message, type: Popup.error);
  }
}

/// Map of app users cache in memory with profile_id as the key
// final Map<String, Profile?> _profiles = {};

Future<void> getChatProfile(String userId, Map<String, UserInformationModel?> profiles) async {
  if (profiles[userId] != null) {
    return;
  }
  try {
    final providers = await supabase.from(Supa().profile).select().match({'serchID': userId}).single();
    final users = await supabase.from(SupaUser().profile).select().match({'serchID': userId}).single();
    final data = providers + users;
    if (data == null) {
      return;
    } else if(providers) {
      profiles[userId] = UserInformationModel.fromMap(providers);
    } else if(users) {
      // userProfiles[userId] = SerchUserModel.fromMap(users);
    } else {
      profiles[userId] = UserInformationModel.fromMap(providers);
      // userProfiles[userId] = SerchUserModel.fromMap(users);
    }
  } on PostgrestException catch (e) {
    return showGetSnackbar(message: e.message, type: Popup.error);
  }
}