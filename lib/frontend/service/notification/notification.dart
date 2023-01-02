import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provide/lib.dart';
import 'package:rxdart/rxdart.dart';

class UserNotifications{
  static final notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static const DarwinInitializationSettings initializationSettingsMacOS = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false
  );

  //Initialization Settings for different platforms
  static final initializationSettingsDarwin = DarwinInitializationSettings(
    // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
    notificationCategories: [
      DarwinNotificationCategory(
        "Serchservice",
        actions: [
          DarwinNotificationAction.text('id_1', 'Action 1', buttonTitle: "Ok"),
          DarwinNotificationAction.text('id_2', 'Action 2', buttonTitle: "Ok", options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          }),
          DarwinNotificationAction.text('id_3', 'Action 3', buttonTitle: "Ok", options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          }),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ]
  );

  static const initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");

  static const initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
    macOS: initializationSettingsMacOS
  );

  static const channelID = "channel id";
  static const channelName = "channel Name";

  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        channelID,
        channelName,
        channelDescription: "channel description",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'
      ),
      iOS: DarwinNotificationDetails()
    );
  }

  Future initNotification({bool initScheduled = false}) async => await notifications.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
  );

  static Future showNormalNotification({required NotificationModel model}) async => notifications.show(
    model.id, model.title, model.body, await notificationDetails(), payload: model.payload
  );

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           // Navigator.of(context, rootNavigator: true).pop();
    //           // await Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //     builder: (context) => SecondScreen(payload),
    //           //   ),
    //           // );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  Future<bool> requestPermission() async {
    final bool? result = await notifications
    //MacOSFlutterLocalNotificationsPlugin
    //AndroidFlutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    if(result == null || result == false){
      return false;
    } else {
      return true;
    }
  }



  //Grouping Notifications
  static const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails(threadIdentifier: 'thread_id');
  
  static const String groupKey = 'com.android.example.WORK_EMAIL';
  static const String groupChannelId = 'grouped channel id';
  static const String groupChannelName = 'grouped channel name';
  static const String groupChannelDescription = 'grouped channel description';
  // example based on https://developer.android.com/training/notify-user/group.html
  static const AndroidNotificationDetails firstNotificationAndroidSpecifics =
      AndroidNotificationDetails(groupChannelId, groupChannelName,
          channelDescription: groupChannelDescription,
          importance: Importance.max,
          priority: Priority.high,
          groupKey: groupKey);
  static const NotificationDetails firstNotificationPlatformSpecifics =
      NotificationDetails(android: firstNotificationAndroidSpecifics);
  // await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
      // 'You will not believe...', firstNotificationPlatformSpecifics);
  static const AndroidNotificationDetails secondNotificationAndroidSpecifics =
      AndroidNotificationDetails(groupChannelId, groupChannelName,
          channelDescription: groupChannelDescription,
          importance: Importance.max,
          priority: Priority.high,
          groupKey: groupKey);
  static const NotificationDetails secondNotificationPlatformSpecifics =
      NotificationDetails(android: secondNotificationAndroidSpecifics);
  // await flutterLocalNotificationsPlugin.show(
  //     2,
  //     'Jeff Chang',
  //     'Please join us to celebrate the...',
  //     secondNotificationPlatformSpecifics);

  // Create the summary notification to support older devices that pre-date
  /// Android 7.0 (API level 24).
  ///
  /// Recommended to create this regardless as the behaviour may vary as
  /// mentioned in https://developer.android.com/training/notify-user/group
  static const List<String> lines = <String>[
      'Alex Faarborg  Check this out',
      'Jeff Chang    Launch Party'
  ];
  static const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
      lines,
      contentTitle: '2 messages',
      summaryText: 'janedoe@example.com');
  static const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(groupChannelId, groupChannelName,
          channelDescription: groupChannelDescription,
          styleInformation: inboxStyleInformation,
          groupKey: groupKey,
          setAsGroupSummary: true);
  // static const NotificationDetails notificationDetails =
  //     NotificationDetails(android: androidNotificationDetails);
  // await flutterLocalNotificationsPlugin.show(
  //     3, 'Attention', 'Two messages', notificationDetails);

  // cancel the notification with id value of zero
  // await flutterLocalNotificationsPlugin.cancel(0);
  // await flutterLocalNotificationsPlugin.cancelAll();
  // final NotificationAppLaunchDetails notificationAppLaunchDetails =
    // await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  //For Swift
//   if(!UserDefaults.standard.bool(forKey: "Notification")) {
//     UIApplication.shared.cancelAllLocalNotifications()
//     UserDefaults.standard.set(true, forKey: "Notification")
// }
}