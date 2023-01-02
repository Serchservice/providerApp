// import 'package:flutter_app_badger/flutter_app_badger.dart';

// class Badging{
//   FlutterAppBadger.updateBadgeCount(1);
// FlutterAppBadger.removeBadge();
// FlutterAppBadger.isAppBadgeSupported();
// }

// @override
//   initState() {
//     super.initState();
//     initPlatformState();
//   }

//   initPlatformState() async {
//     String appBadgeSupported;
//     try {
//       bool res = await FlutterAppBadger.isAppBadgeSupported();
//       if (res) {
//         appBadgeSupported = 'Supported';
//       } else {
//         appBadgeSupported = 'Not supported';
//       }
//     } on PlatformException {
//       appBadgeSupported = 'Failed to get badge support.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _appBadgeSupported = appBadgeSupported;
//     });
//   }