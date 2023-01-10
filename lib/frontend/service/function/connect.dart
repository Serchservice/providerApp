// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showCancelReason({required BuildContext context}) => showDialog(
  context: context,
  builder: (context) {
    bool onTrip = true;
    TextEditingController reason = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SText(text: "We just want to know...", color: Theme.of(context).primaryColor, size: 20, weight: FontWeight.bold),
              SText(text: "What is your reason for cancelling this service trip?.", color: Theme.of(context).primaryColor, size: 16),
            ],
          ),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: reason,
              maxLines: 5,
              minLines: 1,
              validator: (value) {
                if(reason.value.text.length < 5){
                  return "This field cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Your Reason (Optional)",
                hintStyle: STexts.hints(context),
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                prefixIcon: const Icon(Icons.read_more, color: SColors.red),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 4,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: SColors.lightPurple,
                    width: 2,
                  ),
                )
              ),
            ),
          ),
          actions: [
            SBtn(
              text: "Cancel Trip", textSize: 16,
              buttonColor: Theme.of(context).bottomAppBarColor,
              textColor: SColors.lightPurple,
              onClick: () {
                if(!formKey.currentState!.validate()){
                  return;
                } else {
                  setState(() => onTrip = false);
                UserConnection().saveOnTrip(onTrip);
                Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
                }
              }
            ),
            SBtn(
              text: "Don't cancel", textSize: 16,
              onClick: () => Navigator.of(context).pop(false),
              buttonColor: Theme.of(context).bottomAppBarColor,
              textColor: SColors.lightPurple,
            )
          ],
        );
      }
    );
  }
);

void showRateReason({
  required BuildContext context, required String thisUser, required String rateStatus
}) => showDialog(
  context: context,
  builder: (context) {
    bool onTrip = true;
    TextEditingController reason = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SText(text: "We just want to know...", color: Theme.of(context).primaryColor, size: 20, weight: FontWeight.bold),
              SText(text: "Why are you rating the $thisUser $rateStatus?.", color: Theme.of(context).primaryColor, size: 16),
            ],
          ),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: reason,
              maxLines: 5,
              minLines: 1,
              validator: (value) {
                if(reason.value.text.length < 5){
                  return "This field cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Your Reason (Optional)",
                hintStyle: STexts.hints(context),
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                prefixIcon: const Icon(Icons.read_more, color: SColors.red),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 4,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: SColors.lightPurple,
                    width: 2,
                  ),
                )
              ),
            ),
          ),
          actions: [
            SBtn(
              text: "Rate", textSize: 16,
              buttonColor: Theme.of(context).bottomAppBarColor,
              textColor: SColors.lightPurple,
              onClick: () {
                if(!formKey.currentState!.validate()){
                  return;
                } else {
                  setState(() => onTrip = false);
                  UserConnection().saveOnTrip(onTrip);
                  Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
                }
              }
            ),
            SBtn(
              text: "No reason", textSize: 16,
              onClick: () {
                setState(() => onTrip = false);
                UserConnection().saveOnTrip(onTrip);
                Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
              },
              buttonColor: Theme.of(context).bottomAppBarColor,
              textColor: SColors.lightPurple,
            )
          ],
        );
      }
    );
  }
);

void showRatingDialog({required BuildContext context, required String user}) => showDialog(
  context: context, builder: (context) {
    double rating = 0;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        elevation: 0,
        title: SText.center(
          text: "Rate your service trip with $user",
          size: 24,
          color: Theme.of(context).primaryColor,
          weight: FontWeight.bold
        ),
        content: RatingBar.builder(
          initialRating: 0,
          itemCount: 5,
          minRating: 1,
          allowHalfRating: true,
          wrapAlignment: WrapAlignment.center,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(Icons.sentiment_very_dissatisfied, color: Colors.red,);
              case 1:
                return const Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent,);
              case 2:
                return const Icon(Icons.sentiment_neutral, color: Colors.amber,);
              case 3:
                return const Icon(Icons.sentiment_satisfied, color: Colors.lightGreen,);
              case 4:
                return const Icon(Icons.sentiment_very_satisfied, color: Colors.green,);
              default:
                return const Icon(Icons.sentiment_very_satisfied, color: Colors.green,);
            }
          },
          onRatingUpdate: (newRating) {
            setState(() => rating = newRating);
            debugShow(newRating);
          },
        ),
        actions: [
          SBtn(
            text: "Rate", textSize: 16,
            buttonColor: Theme.of(context).bottomAppBarColor,
            textColor: SColors.lightPurple,
            onClick: () => showRateReason(
              context: context, thisUser: user,
              rateStatus: rating.isEqual(0) ? "bad" : rating.toInt() < 3 ? "bad" :"good"
            )
          ),
        ],
      );
    }
    );
  }
);

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