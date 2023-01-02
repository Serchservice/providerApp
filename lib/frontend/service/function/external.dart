// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provide/lib.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConnection{
  StreamSubscription? subscription;
  ConnectivityResult connectionState = ConnectivityResult.none;
  bool isDeviceConnected = false;
  bool isAlert = false;

  getConnection(context) => subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    connectionState = await Connectivity().checkConnectivity();
    if(!isDeviceConnected && isAlert == false){
      showConnectionDialogBox(context: context);
      // setState(() => isAlert = true);
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
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(launchUri);
}

Future<void> launchUniversalLinkIos(Uri url) async {
  final bool nativeAppLaunchSucceeded = await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication,);
  if (!nativeAppLaunchSucceeded) {
    await launchUrl(url, mode: LaunchMode.inAppWebView,);
  }
}

Future<void> launchMail(String prefix) async {
  final Uri mailtoUri = Uri(scheme: "mailto", path: "${prefix}serchservice.com");
  await launchUrl(mailtoUri);
}

Future<void> openMail() async {
  final Uri mailtoUri = Uri(scheme: "mailto",);
  await launchUrl(mailtoUri);
}

Future<void> launchInWebViewOrVC(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: WebViewConfiguration(
      headers: <String, String>{ url.host: url.path }),
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}