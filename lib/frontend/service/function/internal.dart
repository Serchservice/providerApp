import 'package:intl/intl.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';

String twoDigits(int n) => n.toString().padLeft(2, "0");

String formatTime(Duration duration){
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes);
  final seconds = twoDigits(duration.inSeconds);

  return[
    if(duration.inHours > 0) hours, minutes, seconds
  ].join(':');
}

String formatMoney(int amount){
  final first = twoDigits(amount);
  final second = twoDigits(amount);

  return[
    first, second
  ].join('.');
}

String getCurrency() {
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
  return format.currencySymbol;
}

typedef SFn = void Function();

Future<Uint8List> getAssetData(String path) async {
  var asset = await rootBundle.load(path);
  return asset.buffer.asUint8List();
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

openDeleteAccount(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => StatefulBuilder(
    builder:(context, setState) => Padding(
      padding: screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SText.center(
            text: "Are you sure you want to delete this Serch Account?",
            size: 22,
            weight: FontWeight.bold,
            color: SColors.white,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<Auth>(
                builder: (context, value, child) => SBtn(
                  onClick: () => value.deleteSerchAccount(),
                  text: "Yes",
                  loading: value.isLoading,
                ),
              ),
              const SizedBox(width: 10,),
              SBtn(onClick: () => Get.back(), text: "No")
            ],
          ),
        ],
      ),
    ),
  )
);

openHelp(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => StatefulBuilder(
    builder: (context, setState) => Center(
      child: Wrap(
        spacing: 10,
        children: [
          SBtn(onClick: () => launchMail(helpMail), text: "Help us improve our services", width: 150),
          SBtn(onClick: () => launchMail(reportMail), text: "Report a broken feature", width: 150)
        ],
      ),
    )
  )
);

openLogOutAccount(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => StatefulBuilder(
    builder: (context, setState) => Padding(
      padding: screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SText.center(
            text: "Are you sure you want to sign out?",
            size: 22,
            weight: FontWeight.bold,
            color: SColors.white,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<Auth>(
                builder: (context, value, child) => SBtn(
                  onClick: () => value.signOut(context),
                  text: "Yes",
                  loading: value.isLoading,
                ),
              ),
              const SizedBox(width: 10,),
              SBtn(onClick: () => Get.back(), text: "No")
            ],
          ),
        ],
      ),
    )
  )
);

void showReferCode(BuildContext context, String referCode) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: 120,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.chevron_left_slash_chevron_right,
                size: 32,
                color: Theme.of(context).primaryColor
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SText(text: referCode, weight: FontWeight.bold, size: 16, color: Theme.of(context).primaryColor),
                  IconButton(
                    onPressed: () => copy(referCode),
                    icon: Icon(
                      CupertinoIcons.square_on_square,
                      size: 16,
                      color: Theme.of(context).primaryColor
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }