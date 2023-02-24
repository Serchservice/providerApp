import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provide/lib.dart';

class BottomNavigator extends StatefulWidget {
  final int? newPage;
  const BottomNavigator({super.key, this.newPage});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  //For BottomNavigationBar
  late ValueNotifier<int> pageIndex = ValueNotifier(widget.newPage ?? 4 );
  final ValueNotifier<String> title = ValueNotifier('Messages');

  //Database Fetching and Provider Fetching
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
  UserAdditionalModel userAdditionalModel = UserAdditionalModel();

  //For Connection Checking
  ConnectivityResult connectionState = ConnectivityResult.none;
  bool isDeviceConnected = false;
  bool isAlert = false;
  StreamSubscription? subscription;

  //Check ConnectionState everytime
  getConnection(context) => subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    connectionState = await Connectivity().checkConnectivity();
    if(!isDeviceConnected && isAlert == false){
      showConnectionDialogBox(
        context: context, connectionState: connectionState,
        isAlert: isAlert, isDeviceConnected: isDeviceConnected
      );
      setState(() => isAlert = true);
    }
  });

  ///Handling Navigation Bar for the HomeScreens
  // void onNavigationItemSelected(index) => pageIndex.value = index;
  void handleItemSelected(int index){
    setState(() {
      pageIndex.value = index;
    });
  }

  // void listenNotifications() => UserNotifications.onNotifications.stream.listen(onClickedNotification);

  // void onClickedNotification(String? payload) {
  //   if(payload == null || payload.isEmpty){
  //     return;
  //   } else if(payload.contains("msg")){
  //     // final ChatModel chatModel;
  //     // Navigator.of(context).push(UserChattingScreen.route(payload, chatModel));
  //   } else {
  //     // Navigator.of(context).push(UserChattingScreen.route(chatModel.id, chatModel));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getConnection(context);
    Initializers().initializeUserAdditionalInfo(userInformationModel);
  }

  @override
  void dispose() {
    subscription?.cancel();
    Initializers().disposeSubscription();
    super.dispose();
  }

  // final pages = navPages;
  @override
  Widget build(BuildContext context) {
    //Checking authentication status
    bool verifyEmail = true;
    // "${getCurrency()}${earnings.toString()}";

    final pages = [
      const HomeScreen(),
      const ChatScreen(),
      CallScreen(),
      const SettingScreen(),
      CentreScreen(verified: verifyEmail),
    ];
    return FeatureDiscovery(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: pageIndex,
            builder: (BuildContext context, int value, _) {
              return pages[value];
            },
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          bottom: true,
          child: Container(
            color: Theme.of(context).bottomAppBarColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomNavItem(
                  label: "Home",
                  icon: CupertinoIcons.home,
                  index: 0,
                  onTap: handleItemSelected,
                  isSelected: (pageIndex.value == 0),
                ),
                BottomNavItem(
                  label: "Chats",
                  icon: CupertinoIcons.chat_bubble_2_fill,
                  index: 1,
                  onTap: handleItemSelected,
                  isSelected: (pageIndex.value == 1),
                ),
                BottomNavItem(
                  label: "Calls",
                  icon: CupertinoIcons.phone,
                  index: 2,
                  onTap: handleItemSelected,
                  isSelected: (pageIndex.value == 2),
                ),
                BottomNavItem(
                  label: "Settings",
                  icon: CupertinoIcons.settings,
                  index: 3,
                  onTap: handleItemSelected,
                  isSelected: (pageIndex.value == 3),
                ),
                BottomNavItem(
                  label: "My Centre",
                  icon: CupertinoIcons.person_crop_circle_fill_badge_plus,
                  index: 4,
                  onTap: handleItemSelected,
                  isSelected: (pageIndex.value == 4),
                ),
              ]
            ),
          ),
        )
        // bottomNavigationBar: BottomNavBar(
        //   onItemSelected: onNavigationItemSelected
        // ),
      ),
    );
  }
}