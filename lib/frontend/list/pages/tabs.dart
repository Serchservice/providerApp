import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provide/lib.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

// List<Widget> navPages = [
//     const HomeScreen(),
//     const ChatScreen(),
//     CallScreen(),
//     const SettingScreen(),
//     const CentreScreen(),
// ];

List<IconData> iconData = [
  CupertinoIcons.home,
  CupertinoIcons.chat_bubble_2_fill,
  CupertinoIcons.phone,
  CupertinoIcons.settings,
  CupertinoIcons.person_crop_circle_fill_badge_plus,
];

List<GButton> longChatTabs = [
  const GButton(
    icon: CupertinoIcons.home,
    text: "Home",
    // textStyle:  AppTextStyle.twelveNormal(context),
  ),
  const GButton(
    icon: CupertinoIcons.chat_bubble_2_fill,
    text: "Chatroom",
    //textStyle:  AppTextStyle.twelveNormal(context),
  ),
  const GButton(
    icon: CupertinoIcons.settings,
    text: "Settings",
    //textStyle:  AppTextStyle.twelveNormal(context),
  ),
  const GButton(
    icon: CupertinoIcons.person_crop_circle_fill_badge_plus,
    text: "My Centre",
    //textStyle:  AppTextStyle.twelveNormal(context),
  ),
];

List<GButton> shortChatTabs = const [
  GButton(icon: CupertinoIcons.home),
  GButton(icon: CupertinoIcons.chat_bubble_2_fill),
  GButton(icon: CupertinoIcons.phone),
  GButton(icon: CupertinoIcons.settings),
  GButton(icon: CupertinoIcons.person_crop_circle_fill_badge_plus),
];

List<Widget> chatPages = [
  const AllCallHistoryScreen(),
  const ReceivedCallHistoryScreen(),
  const OutgoingCallHistoryScreen(),
  const MissedCallHistoryScreen(),
];

int chatPageCount = chatPages.length;

List<Widget> callHistory = [
  const HistoryAllCallScreen(),
  const HistoryVoiceCallScreen(),
  const HistoryVideoCallScreen(),
  const HistoryT2FCallScreen()
];

int callHistoryCount = callHistory.length;

List<Widget> userProfile = [
  const UserProfileAll(),
  const UserProfileImages(),
  const UserProfileVideos()
];

int userProfileCount = userProfile.length;