// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showProviderProfile({
  required BuildContext context,
  required String distance,
  required String tripCount,
  required String name,
}) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height / 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConnectionProfile(distance: distance, tripCount: tripCount, name: name,)
      ),
    )
  );
}

void showCancelReason({
  required BuildContext context,
  required CheckBoxListModel checkList,
}) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: SText(text: "We just want to know...", color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.bold),
    content: Column(
      children: [
        SText(text: "What are your reasons for cancelling this service trip?.", color: Theme.of(context).primaryColor, size: 16),
        const SizedBox(height: 10),
        CheckboxListTile(
          value: checkList.value,
          onChanged: checkList.onChanged,
          subtitle: SText(text: checkList.reason, color: Theme.of(context).primaryColor, size: 16),
        )
      ],
    ),
  )
);

void showRatingDialog(BuildContext context){
  showCupertinoModalPopup(context: context, builder: (context) => Container(
    color: Theme.of(context).backgroundColor
  ));
}

 // showAboutDialog(
  //   applicationName: "Serch Provider",
  //   applicationVersion: "1.0",
  //   applicationIcon: Image.asset(SImages.logo, width: 30, color: Theme.of(context).primaryColor),
  //   context: context,
  //   children: [
  //     Container(
  //       padding: screenPadding,
  //       height: 200,
  //       width: 200,
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).scaffoldBackgroundColor,
  //         borderRadius: BorderRadius.circular(5)
  //       ),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Center(child: SBtn(text: "Cool, let's get on"))
  //           ],
  //         ),
  //       ),
  //     ),
  //   ]
  // );

void showImportantNotice(BuildContext context) => showDialog(
  context: context,
  builder:(context) => StatefulBuilder(
    builder: (context, setState) => Container(
      padding: screenPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(SImages.logo, color: Theme.of(context).primaryColor, width: 30),
                const SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(text: "Serch Provider", size: 16, weight: FontWeight.bold, color: Theme.of(context).primaryColor),
                    const SText(text: version, size: 16, color: SColors.hint, weight: FontWeight.bold,),
                  ],
                ),
              ]
            ),
            const SizedBox(height: 20),
            SText.center(text: "NOTICE INFORMATION", size: 20, weight: FontWeight.w900, color: Theme.of(context).primaryColor),
            const SizedBox(height: 5),
            const SText.justify(
              text: """*Please read through before making use of this Serch platform. This information contains the basic understanding on some features of Serch, how to make use of them and some basic instructions.*
              """,
              size: 16, weight: FontWeight.bold, color: SColors.hint, style: FontStyle.italic,
            ),
            const SizedBox(height: 10),
            SText(
              text: "1.  Chats with a user/client is kept only for 30 days. A user/client can chat you up again, if you are bookmarked by the user/client.",
              size: 16, weight: FontWeight.bold, color: Theme.of(context).primaryColor
            ),
            const SizedBox(height: 5),
            SText(
              text: "2.  Once you are online, the online toogle is automatically enabled. You can manually do that by changing it in your settings, under preferences.",
              size: 16, weight: FontWeight.bold, color: Theme.of(context).primaryColor
            ),
            const SizedBox(height: 5),
            SText(
              text: "3.  You can always appear on the map even when you are busy. This enables users/clients to still speak with you if their issues are not urgent. To achieve this, set your 'Show on map' preference.",
              size: 16, weight: FontWeight.bold, color: Theme.of(context).primaryColor
            ),
            const SizedBox(height: 20),
            Container(
              color: SColors.blue,
              padding: screenPadding,
              child: Wrap(
                children: const [
                  SText(text: "There are two statuses in Serch, for providers.", size: 16, color: SColors.white),
                  SText(text: " When the icon is green, ", size: 16, color: SColors.white),
                  Icon(CupertinoIcons.bolt_circle_fill, size: 16, color: SColors.green),
                  SText(text: " then you are online.", size: 16, color: SColors.white),
                  SText(text: " But when the icon is yellow, ", size: 16, color: SColors.white),
                  Icon(CupertinoIcons.bolt_circle_fill, size: 16, color: SColors.yellow),
                  SText(text: " then you are busy.", size: 16, color: SColors.white),
                ]
              ),
            ),
            const SizedBox(height: 30),
            Center(child: SBtn(
              text: "Cool, let's get on",
              textColor: SColors.white,
              buttonColor: SColors.lightPurple,
              textSize: 16,
              width: 150,
              textWeight: FontWeight.bold,
              onClick: () => Get.back(),
            )),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    SText.right(text: "Team Serch,", color: SColors.hint, size: 16, weight: FontWeight.bold, style: FontStyle.italic),
                    SText.right(text: "Serch Platforms,", color: SColors.hint, size: 16, weight: FontWeight.bold, style: FontStyle.italic),
                    SText.right(text: "Lagos, Nigeria.", color: SColors.hint, size: 16, weight: FontWeight.bold, style: FontStyle.italic)
                  ],
                )
              ]
            )
          ],
        ),
      ),
    ),
  ),
);

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