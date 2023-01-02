import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  //For BottomNavigationBar
  final ValueNotifier<int> pageIndex = ValueNotifier(4);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  //Database Fetching and Provider Fetching
  UserServiceInfo userServiceInfo = UserServiceInfo();

  //For Connection Checking
  ConnectivityResult connectionState = ConnectivityResult.none;
  bool isDeviceConnected = false;
  bool isAlert = false;
  StreamSubscription? subscription;

  //Country Checker
  Country? _selectedCountry;
  bool country = false;
  String? countryDialCode;

  void getCurrentUserServiceInfo() async {
    // DocumentReference ref = MainDB().providers.doc(user?.email).collection(SecondDB.profile).doc(ProfileDB.service);

    // ref.get().then((DocumentSnapshot snapshot) {
    //   if(snapshot.data() != null){
    //     userServiceInfo = UserServiceInfo.fromSnapshot(snapshot);
    //   } else {
    //     debugShow("Error");
    //   }
    // }).onError((error, stackTrace) {
    //   if(error == "field does not exist within the DocumentSnapshotPlatform"){
    //     setState(() => hasService = true);
    //   }
    //   debugShow(error);
    // });
  }

  void getCurrentUserAddInfo() async {
    // DocumentReference ref = MainDB().providers.doc(user?.email).collection(SecondDB.profile).doc(ProfileDB.additional);

    // ref.get().then((DocumentSnapshot snapshot) {
    //   if(!snapshot.exists){
    //     setState(() => finishSignup = true);
    //   }else if(snapshot.data() != null){
    //     currentUserAddInfo = UserAddInfo.fromSnapshot(snapshot);
    //   } else {
    //     debugShow("Error");
    //   }
    // }).onError((error, stackTrace) {
    //   if(error.toString() == "field does not exist within the DocumentSnapshotPlatform"){
    //     setState(() => finishSignup = true);
    //   }
    //   debugShow(error);
    // });
  }

  //Check ConnectionState everytime
  getConnection(context) => subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    connectionState = await Connectivity().checkConnectivity();
    if(!isDeviceConnected && isAlert == false){
      showConnectionDialogBox(context: context);
      setState(() => isAlert = true);
    }
  });

  //Showing connection error when there is no connection
  showConnectionDialogBox({
    required BuildContext context, double titleSize = 14, double contentSize = 14, FontWeight titleWeight = FontWeight.bold,
    FontWeight contentWeight = FontWeight.normal,
  }) => showCupertinoDialog(
      context: context,
      builder:(context) => StatefulBuilder(
        builder: (context, setState) => CupertinoAlertDialog(
          title: SText(
            text: connectionState == ConnectivityResult.mobile ? "No Mobile Connection"
            : connectionState == ConnectivityResult.wifi ? "No Wifi Connection" : "No Connection",
            size: titleSize, weight: titleWeight, color: SColors.black
          ),
          content: SText(
            text: connectionState == ConnectivityResult.mobile ? "Please check your mobile data connection"
            : connectionState == ConnectivityResult.wifi ? "Please check your wifi connection" : "Please check your internet connection",
            size: contentSize, weight: contentWeight, color: SColors.black
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlert = false);
                isDeviceConnected = await InternetConnectionChecker().hasConnection;
                if(!isDeviceConnected){
                  showConnectionDialogBox(context: context);
                  setState(() => isAlert = true);
                }
              },
              child: SText(text: "Understood", color: SColors.black, weight: titleWeight, size: titleSize),
            )
          ],
      )
    )
  );

  ///Handling Navigation Bar for the HomeScreens
  // void onNavigationItemSelected(index) => pageIndex.value = index;
  void handleItemSelected(int index){
    setState(() {
      pageIndex.value = index;
    });
  }

  //Getting the country stored in the User's Db and Provider
  void getCountry() {
    countryDialCode = Provider.of<UserInformation>(context, listen: false).user.countryDialCode ?? "NG";
    _selectedCountry = countries.firstWhere((country) => country.dialCode == countryDialCode,
    orElse: () => countries.first);
    setState(() => country = true);
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
    // getCurrentUserServiceInfo();
    // SerchUser.getCurrentUserInfo();
    // // SerchUser.getCurrentUserServiceInfo();
    // getCurrentUserAddInfo();
    getConnection(context);
    getCountry();
    // UserNotifications.initNotification();
    // listenNotifications();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  // final pages = navPages;
  @override
  Widget build(BuildContext context) {
    //Checking authentication status
    bool finishSignup = true;
    bool verifyEmail = true;
    String service = Provider.of<UserServiceInformation>(context, listen: false).service ?? "Plumber";
    String phone = Provider.of<UserInformation>(context, listen: false).user.phone ?? "";
    String gender = Provider.of<UserInformation>(context, listen: false).user.gender ?? "";
    int earnings = 500;
    String userAmount = "${getCurrency()}${earnings.toString()}";

    final pages = [
      const HomeScreen(),
      const ChatScreen(),
      CallScreen(),
      const SettingScreen(),
      CentreScreen(
        finishSignup: finishSignup,
        service: service,
        phone: phone,
        gender: gender,
        verified: verifyEmail,
        userAmount: userAmount,
        selectedCountry: _selectedCountry!
      ),
    ];
    return FeatureDiscovery(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          },
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