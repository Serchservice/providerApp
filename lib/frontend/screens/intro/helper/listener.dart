import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provide/lib.dart';

class UserStateListener extends StatefulWidget {
  ///Auth listener for changes in the user auth state. Mostly used as a widget after the splashscreen.
  ///
  ///This is where the Supabase listens to the auth changes of the user session.
  const UserStateListener({super.key});

  @override
  State<UserStateListener> createState() => _UserStateListenerState();
}

class _UserStateListenerState extends State<UserStateListener> {
  ConnectivityResult connectionState = ConnectivityResult.none;
  StreamSubscription? subscription;
  bool isDeviceConnected = false;
  bool isAlert = false;

  getConnection(context) => subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    connectionState = await Connectivity().checkConnectivity();
    if(!isDeviceConnected && isAlert == false){
      showConnectionDialogBox(context: context);
      setState(() => isAlert = true);
    }
  });

  showConnectionDialogBox({
    required BuildContext context, double titleSize = 14, double contentSize = 14, FontWeight titleWeight = FontWeight.bold,
    FontWeight contentWeight = FontWeight.normal, Color color = SColors.white,
  }) => showCupertinoDialog(
      context: context,
      builder:(context) => StatefulBuilder(
        builder: (context, setState) => CupertinoAlertDialog(
          title: SText(
            text: connectionState == ConnectivityResult.mobile ? "No Mobile Connection"
            : connectionState == ConnectivityResult.wifi ? "No Wifi Connection" : "No Connection",
            size: titleSize, weight: titleWeight, color: color
          ),
          content: SText(
            text: connectionState == ConnectivityResult.mobile ? "Please check your mobile data connection"
            : connectionState == ConnectivityResult.wifi ? "Please check your wifi connection" : "Please check your internet connection",
            size: contentSize, weight: contentWeight, color: color
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
              child: SText(text: "Understood", color: color, weight: titleWeight, size: titleSize),
            )
          ],
      )
    )
  );

  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session != null) {
      Get.offAll(() => const BottomNavigator());
    } else {
      Get.offAll(() => const BottomNavigator());
      // Get.offAll(() => const OnboardScreen());
    }
  }

  @override
  void initState() {
    getConnection(context);
    _redirect();
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<User?>(
    //   stream: FbAuth().changes(),
    //   builder: (context, snapshot) => snapshot.hasData
    //     ? const BottomNavigator()
    //     : const OnboardScreen()
    // );
    return Container();
  }
}

// class AuthListener extends StatelessWidget {
//   const AuthListener({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DocumentSnapshot>(
//       stream: userDetail.snapshots(),
//       builder: (context, snapshot){
//         return snapshot.hasData
//           ? StreamBuilder(
//             stream: userService.snapshots(),
//             builder: (context, snapshot){
//               return snapshot.hasData
//                 ? const HomeScreen()
//                 : const HomeScreen();
//             }
//           )
//           : const SignupScreen();
//       }
//     );
//   }
// }