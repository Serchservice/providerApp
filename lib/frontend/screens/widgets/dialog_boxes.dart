import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void showConnectionDialogBox({
  required BuildContext context, double titleSize = 14, double contentSize = 14, FontWeight titleWeight = FontWeight.bold,
  FontWeight contentWeight = FontWeight.normal, ConnectivityResult? connectionState, bool isDeviceConnected = false, bool isAlert = false
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

void openHelp(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => StatefulBuilder(
    builder: (context, setState) => Center(
      child: Wrap(
        spacing: 10,
        children: [
          SBtn(onClick: () => WebFunctions.launchMail(helpMail), text: "Help us improve our services", width: 150),
          SBtn(onClick: () => WebFunctions.launchMail(reportMail), text: "Report a broken feature", width: 150)
        ],
      ),
    )
  )
);

void openLogOutAccount(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => StatefulBuilder(
    builder: (context, setState) {
      bool loading = false;
      void signOut() async {
        try {
          setState(() => loading = true);
          await supabase.auth.signOut();
          setState(() => loading = false);
          Get.offAll(() => const LoginScreen());
        } on AuthException catch (e) {
          showGetSnackbar(message: e.message, type: Popup.error);
        }
      }

      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Are you sure you want to sign out?",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          SBtn(
            onClick: () => signOut(),
            text: "Yes",
            loading: loading,
            textSize: 16,
          ),
          const SizedBox(width: 10,),
          SBtn(onClick: () => Get.back(), text: "No", textSize: 16,)
        ],
        actionsPadding: EdgeInsets.zero,
        actionsAlignment: MainAxisAlignment.center,
      );
    }
  )
);

void openDeleteAccount(BuildContext context, GlobalKey<FormState> formKey) => showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => StatefulBuilder(
    builder:(context, setState) {
      bool loading = false;
      void delete() async {
        try {
          setState(() => loading = true);
          // await supabase.auth.
          Get.offAll(() => const OnboardScreen());
          setState(() => loading = false);
        } on AuthException catch (e) {
          showGetSnackbar(message: e.message, type: Popup.error);
          setState(() => loading = false);
        }
      }

      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Are you sure you want to delete this Serch Account?",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          SBtn(
            onClick: () => delete(),
            text: "Yes",
            loading: loading,
            textSize: 16,
          ),
          const SizedBox(width: 10,),
          SBtn(onClick: () => Get.back(), text: "No", textSize: 16,)
        ],
        actionsPadding: EdgeInsets.zero,
        actionsAlignment: MainAxisAlignment.center,
      );
    }
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

void openBankOptions({
  required BuildContext context,
  required dynamic bankId,
}) async {
  showDialog(
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
              text: "Are you sure you want to delete this Bank Account?",
              size: 22,
              weight: FontWeight.bold,
              color: SColors.white,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SBtn(
                  onClick: () {},
                  text: "Yes",
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
}

Future<bool?> endCall(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Are you sure you want to end this call?",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          SBtn(onClick: () => Navigator.of(context).pop(true), text: "Yes, am done", textSize: 16),
          const SizedBox(width: 10,),
          SBtn(onClick: () => Navigator.of(context).pop(false), text: "No, continue", textSize: 16,)
        ],
        actionsPadding: const EdgeInsets.symmetric(vertical: 10),
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

Future<bool?> endT2FVideoCall(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Are you sure you want to end this call?",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          SBtn(onClick: () => addMoreTip(context), text: "Yes, am done", textSize: 16),
          const SizedBox(width: 10,),
          SBtn(onClick: () => Navigator.of(context).pop(false), text: "No, continue", textSize: 16,)
        ],
        actionsPadding: const EdgeInsets.symmetric(vertical: 10),
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

Future<bool?> addMoreTip(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Feel like adding an extra tip?",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          SBtn(onClick: () => addExtraTip(context), text: "Definitely", textSize: 16),
          const SizedBox(width: 10,),
          SBtn(
            onClick: () => Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false),
            text: "Not really", textSize: 16,
          )
        ],
        actionsPadding: const EdgeInsets.symmetric(vertical: 10),
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

void addExtraTip(context) {
  final amount = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: StatefulBuilder(
        builder:(context, setState) => Container(
          padding: screenPadding,
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SText(
                      text: "Enter extra tip amount",
                      size: 20,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SFormField(
                            labelText: "5,000",
                            formName: "Extra Tip Amount",
                            controller: amount,
                            cursorColor: Theme.of(context).primaryColor,
                            fillColor: Theme.of(context).backgroundColor,
                            formStyle: STexts.normalForm(context),
                            formColor: Theme.of(context).primaryColor,
                            enabledBorderColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 20),
                          SButton(
                            text: "Tip2Fix",
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12.0),
                            textWeight: FontWeight.bold,
                            textSize: 18,
                            onClick: () {
                              Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false);
                            },
                          ),
                          const SizedBox(height: 10),
                          SButton(
                            text: "Cancel",
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12.0),
                            textWeight: FontWeight.bold,
                            textSize: 18,
                            onClick: () {
                              Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false);
                            },
                          ),
                        ]
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      ),
    )
  );
}

void cancelServiceTrip({
  required BuildContext context, required UserInformationModel userInformationModel,
  required UserConnectedModel userConnectedModel
}) => showDialog(
  context: context,
  builder: (context) {
    TextEditingController reason = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            child: SFormField(
              labelText: "Tell us if something happened",
              formName: "Your reason (Optional)",
              controller: reason,
              cursorColor: Theme.of(context).primaryColor,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              formStyle: STexts.normalForm(context),
              formColor: Theme.of(context).primaryColor,
              enabledBorderColor: Theme.of(context).primaryColor,
            ),
          ),
          actions: [
            SBtn(
              text: "Cancel Trip", textSize: 16,
              onClick: () async {
                showDialog(
                  context: context, barrierDismissible: false, builder: (context) => WillPopScope(
                    onWillPop: () async => false,
                    child: AlertLoader.fallingDot(
                      size: 40, color: Theme.of(context).primaryColor, text: "Cancelling trip", textSize: 16,
                    ),
                  )
                );
                await supabase.from(Supa().serviceAndPlan).update({"on_trip": false}).eq("serchID", userInformationModel.serchID);
                await supabase.from(SupaUser().service).update({"on_trip": false}).eq("serchID", userConnectedModel.connectID);
                // await supabase.from(Supa().profile).update({
                //   "total_service_trips": userInformationModel.totalServiceTrips + 1
                // }).eq("serchAuth", userInformationModel.serchAuth);
                Initializers().getServiceAndPlan(userInformationModel);
                // Initializers().getProfile(userInformationModel);
                Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
              }
            ),
            SBtn(text: "Don't cancel", textSize: 16, onClick: () => Navigator.of(context).pop(false))
          ],
          actionsPadding: const EdgeInsets.symmetric(vertical: 10),
          actionsAlignment: MainAxisAlignment.center,
        );
      }
    );
  }
);

void endServiceTrip({
  required BuildContext context, required UserConnectedModel userConnectedModel, required UserInformationModel userInformationModel
}) => showDialog(
  context: context, builder: (context) {
    double rating = 0;
    TextEditingController reason = TextEditingController();
    List<UserRatingsModel> userRatings = HiveUserDatabase().getRatingsDataList();
    final formKey = GlobalKey<FormState>();

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Rate your service trip with ${userConnectedModel.firstName}",
          size: 24,
          color: Theme.of(context).primaryColor,
          weight: FontWeight.bold
        ),
        content: Form(
          key: formKey,
          child: Column(
            children: [
              RatingBar.builder(
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
                },
              ),
              const SizedBox(height: 10),
              SFormField(
                labelText: "Why this ${rating.isEqual(0) ? "bad" : rating.toInt() < 3 ? "bad" :"good"} rate?",
                formName: "Your reason (Optional)",
                controller: reason,
                cursorColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                formStyle: STexts.normalForm(context),
                formColor: Theme.of(context).primaryColor,
                enabledBorderColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        actions: [
          SBtn(
            text: "End trip", textSize: 16,
            onClick: () async {
              showDialog(
                context: context, barrierDismissible: false, builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: AlertLoader.fallingDot(
                    size: 40, color: Theme.of(context).primaryColor, text: "Ending service trip", textSize: 16,
                  ),
                )
              );
              await supabase.from(Supa().serviceAndPlan).update({"on_trip": false}).eq("serchID", userInformationModel.serchID);
              await supabase.from(SupaUser().service).update({"on_trip": false}).eq("serchID", userConnectedModel.connectID);
              await supabase.from(SupaUser().rating).insert({
                "raterComment": reason.text.trim(),
                "raterImage": userInformationModel.avatar,
                "raterName": "${userInformationModel.firstName} ${userInformationModel.lastName}",
                "raterRate": rating,
                "raterID": userInformationModel.serchID,
                "serchID": userConnectedModel.connectID,
              });
              await supabase.from(Supa().profile).update({
                "total_service_trips": userInformationModel.totalServiceTrips + 1
              }).eq("serchAuth", userInformationModel.serchAuth);
              final connect = await supabase.from(SupaUser().profile).select().eq("serchID", userConnectedModel.connectID)
                .single() as Map;
              await supabase.from(SupaUser().profile).update({
                "numberOfRating": connect["numberOfRating"] + 1,
                "totalRating": connect["totalRating"] + rating / userRatings.length,
                "total_service_trips": connect["total_service_trips"] + 1
              }).eq("serchID", userConnectedModel.connectID);
              Initializers().getServiceAndPlan(userInformationModel);
              Initializers().getRateLists(userInformationModel);
              Initializers().getProfile(userInformationModel);
              Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
            }
          ),
          SBtn(text: "Don't end", textSize: 16, onClick: () => Navigator.of(context).pop(false))
        ],
        actionsPadding: const EdgeInsets.symmetric(vertical: 10),
        actionsAlignment: MainAxisAlignment.center,
      );
    }
    );
  }
);

void endOtherRequestShare({
  required BuildContext context, required UserRequestShare userRequestShare, required UserInformationModel userInformationModel,
  required UserServiceAndPlan userServiceAndPlan
}) => showDialog(
  context: context, builder: (context) {
    double rating = 0;
    TextEditingController reason = TextEditingController();
    List<UserRatingsModel> userRatings = HiveUserDatabase().getRatingsDataList();
    final formKey = GlobalKey<FormState>();

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Rate your requestSharing with ${userRequestShare.rsFirstName}",
          size: 24,
          color: Theme.of(context).primaryColor,
          weight: FontWeight.bold
        ),
        content: Form(
          key: formKey,
          child: Column(
            children: [
              RatingBar.builder(
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
                },
              ),
              const SizedBox(height: 10),
              SFormField(
                labelText: "Why this ${rating.isEqual(0) ? "bad" : rating.toInt() < 3 ? "bad" :"good"} rate?",
                formName: "Your reason (Optional)",
                controller: reason,
                cursorColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                formStyle: STexts.normalForm(context),
                formColor: Theme.of(context).primaryColor,
                enabledBorderColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        actions: [
          SBtn(
            text: "End RS", textSize: 16,
            onClick: () async {
              showDialog(
                context: context, barrierDismissible: false, builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: AlertLoader.fallingDot(
                    size: 40, color: Theme.of(context).primaryColor, text: "Ending requestSharing", textSize: 16,
                  ),
                )
              );
              await supabase.from(Supa().serviceAndPlan).update({"on_request_share": false})
                .eq("serchID", userInformationModel.serchID);
              await supabase.from(Supa().serviceAndPlan).update({"on_request_share": false})
                .eq("serchID", userRequestShare.rsID);
              await supabase.from(Supa().rating).insert({
                "raterComment": reason.text.trim(),
                "raterImage": userInformationModel.avatar,
                "raterName": "${userInformationModel.firstName} ${userInformationModel.lastName}",
                "raterRate": rating,
                "raterID": userInformationModel.serchID,
                "serchID": userRequestShare.rsID,
              });
              await supabase.from(Supa().profile).update({
                "total_service_trips": userInformationModel.totalServiceTrips + 1
              }).eq("serchID", userInformationModel.serchID);
              final otherService = await supabase.from(Supa().profile).select().eq("serchID", userRequestShare.rsID).single() as Map;
              await supabase.from(Supa().profile).update({
                "numberOfRating": otherService["numberOfRating"] + 1,
                "totalRating": otherService["totalRating"] + rating / userRatings.length,
                "total_service_trips": otherService["total_service_trips"] + 1
              }).eq("serchID", userRequestShare.rsID);
              Initializers().getServiceAndPlan(userInformationModel);
              Initializers().getRateLists(userInformationModel);
              Initializers().getProfile(userInformationModel);
              Initializers().getOtherRequestShare(userInformationModel);
              Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
            }
          ),
          SBtn(text: "Don't end", textSize: 16, onClick: () => Navigator.of(context).pop(false))
        ],
        actionsPadding: const EdgeInsets.symmetric(vertical: 10),
        actionsAlignment: MainAxisAlignment.center,
      );
    }
    );
  }
);

void endMyRequestShare({
  required BuildContext context, required UserRequestShare userRequestShare, required UserInformationModel userInformationModel,
  required UserServiceAndPlan userServiceAndPlan
}) => showDialog(
  context: context, builder: (context) {
    double rating = 0;
    TextEditingController reason = TextEditingController();
    List<UserRatingsModel> userRatings = HiveUserDatabase().getRatingsDataList();
    final formKey = GlobalKey<FormState>();

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Rate your requestSharing with ${userRequestShare.rsFirstName}",
          size: 24,
          color: Theme.of(context).primaryColor,
          weight: FontWeight.bold
        ),
        content: Form(
          key: formKey,
          child: Column(
            children: [
              RatingBar.builder(
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
                },
              ),
              const SizedBox(height: 10),
              SFormField(
                labelText: "Why this ${rating.isEqual(0) ? "bad" : rating.toInt() < 3 ? "bad" :"good"} rate?",
                formName: "Your reason (Optional)",
                controller: reason,
                cursorColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                formStyle: STexts.normalForm(context),
                formColor: Theme.of(context).primaryColor,
                enabledBorderColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        actions: [
          SBtn(
            text: "End RS", textSize: 16,
            onClick: () async {
              showDialog(
                context: context, barrierDismissible: false, builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: AlertLoader.fallingDot(
                    size: 40, color: Theme.of(context).primaryColor, text: "Ending requestSharing", textSize: 16,
                  ),
                )
              );
              await supabase.from(Supa().serviceAndPlan).update({"on_request_share": false})
                .eq("serchID", userInformationModel.serchID);
              await supabase.from(Supa().serviceAndPlan).update({"on_request_share": false})
                .eq("serchID", userRequestShare.rsID);
              await supabase.from(Supa().rating).insert({
                "raterComment": reason.text.trim(),
                "raterImage": userInformationModel.avatar,
                "raterName": "${userInformationModel.firstName} ${userInformationModel.lastName}",
                "raterRate": rating,
                "raterID": userInformationModel.serchID,
                "serchID": userRequestShare.rsID,
              });
              await supabase.from(Supa().profile).update({
                "total_service_trips": userInformationModel.totalServiceTrips + 1
              }).eq("serchID", userInformationModel.serchID);
              final otherService = await supabase.from(Supa().profile).select().eq("serchID", userRequestShare.rsID).single() as Map;
              await supabase.from(Supa().profile).update({
                "numberOfRating": otherService["numberOfRating"] + 1,
                "totalRating": otherService["totalRating"] + rating / userRatings.length,
                "total_service_trips": otherService["total_service_trips"] + 1
              }).eq("serchID", userRequestShare.rsID);
              Initializers().getServiceAndPlan(userInformationModel);
              Initializers().getRateLists(userInformationModel);
              Initializers().getProfile(userInformationModel);
              Initializers().getMyRequestShare(userInformationModel);
              Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
            }
          ),
          SBtn(text: "Don't end", textSize: 16, onClick: () => Navigator.of(context).pop(false))
        ],
        actionsPadding: const EdgeInsets.symmetric(vertical: 10),
        actionsAlignment: MainAxisAlignment.center,
      );
    }
    );
  }
);

class ServiceList{
  final String service;
  final int index;
  ServiceList({required this.service, required this.index});
}

void enableRequestShare(context) {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  final list = [
    ServiceList(service: "Plumber", index: 0),
    ServiceList(service: "Mechanic", index: 1),
    ServiceList(service: "Electrician", index: 2)
  ];
  int selected = -1;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder:(context) => StatefulBuilder(
      builder:(context, setState) {
        void handleItemSelected(int index){
          setState(() {
            selected = index;
          });
        }

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(
                            size: 22,
                            text: "Got a sharing location ${userInformationModel.firstName}?",
                            weight: FontWeight.bold,
                            color: Theme.of(context).primaryColor
                          ),
                          SText(
                            size: 16,
                            weight: FontWeight.w600,
                            text: "Where and what do you need help with?",
                            color: Theme.of(context).primaryColorLight
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 5,
                    runSpacing: 10,
                    children: [
                      ...list.map((item) => SServiceContainer(
                        text: item.service,
                        onTap: handleItemSelected,
                        index: item.index,
                        selected: (selected == item.index),
                      ))
                    ]
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stepping(lineH: 5),
                    Stepping(lineH: 5)
                  ],
                ),
                const SizedBox(height: 10),
                Material(
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () => Get.to(() => SearchScreen(
                      selected: selected == 0 ? list.first.service
                      : selected == 1 ? list.singleWhere((element) => element.index == 1).service
                      : list.last.service,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.search, color: SColors.hint),
                          SizedBox(width: 10.0),
                          SText(text: "Enter your location", color: SColors.hint, weight: FontWeight.bold, size: 16)
                        ]
                      )
                    )
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }
    ),
  );
}

void confirmServiceSchedule(BuildContext context, String time, String provider) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SText.center(
          text: "Accept service schedule for $time with $provider",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          SBtn(onClick: () async {
            await supabase.from(Supa().serviceAndPlan).update({"on_request_share": false}).eq("serchID", "serchID");
          }, text: "Definitely", textSize: 16),
          const SizedBox(width: 10,),
          SBtn(
            onClick: () => Navigator.of(context).pop(false),
            text: "Not really", textSize: 16,
          )
        ],
        actionsPadding: const EdgeInsets.symmetric(vertical: 10),
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

void confirmIncomingUserCTGRequest({required BuildContext context, required String client,}){
  final formKey = GlobalKey<FormState>();
  final input = FocusNode();
  final addressName = TextEditingController();

  showDialog(
    context: context,
    builder:(context) => StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          CupertinoIcons.chevron_back,
                          color: Theme.of(context).primaryColor,
                          size: 28
                        )
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SText(
                      text: "Confirm that you are ready to Connect-To-Go",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: SColors.blue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: SText(text: client, color: SColors.white, size: 16, weight: FontWeight.bold,)
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stepping(lineH: 6,),
                    Stepping(lineH: 6,)
                  ],
                ),
                SFormField(
                  focus: input,
                  labelText: "Enter your location",
                  formName: "What is the location of the $client?",
                  controller: addressName,
                  validate: (value) {
                    if(value!.isEmpty){
                      return "You must enter a service location";
                    } else {
                      return null;
                    }
                  },
                  formColor: Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  enabledBorderColor: Theme.of(context).primaryColorDark,
                  prefixIcon: const Icon(CupertinoIcons.location_fill, color: SColors.red),
                  formStyle: STexts.normalForm(context),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stepping(lineH: 6,),
                    Stepping(lineH: 6,)
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Theme.of(context).backgroundColor,
                    child: InkWell(
                      onTap: () => {},
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.mapLocation,
                              size: 16,
                              color: Theme.of(context).primaryColor
                            ),
                            const SizedBox(width: 20),
                            SText(
                              text: "Use my current location",
                              color: Theme.of(context).primaryColor,
                              size: 16,
                              weight: FontWeight.bold
                            )
                          ]
                        ),
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SButton(
                  text: "Search",
                  textSize: 16,
                  textWeight: FontWeight.bold,
                  onClick: () => {}
                ),
              ],
            ),
          ),
        ),
      )
    ),
  );
}

void confirmIncomingProviderShareRequest({required BuildContext context, required String providerName}){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      bool hasRequestShare = false;
      bool stickWithMe = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            elevation: 0,
            title: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                const Picture.small(),
                SText(
                  text: "$providerName is trying to share a job with you, do you accept?",
                  color: Theme.of(context).primaryColor, size: 18
                ),
              ],
            ),
            content: UserPreferences().getSWM() ? null : CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: SColors.white,
              activeColor: SColors.lightPurple,
              title: SText(
                text: "Enable Stick-With-Me",
                color: Theme.of(context).primaryColor, size: 14
              ),
              value: stickWithMe,
              onChanged: (val) {
                setState(() => stickWithMe = !stickWithMe);
              }
            ),
            actions: [
              SBtn(
                text: "Yes, I do", textSize: 16,
                buttonColor: Theme.of(context).bottomAppBarColor,
                textColor: SColors.lightPurple,
                onClick: () {
                  setState(() => hasRequestShare = true);
                  UserConnection().saveHasRequestShare(hasRequestShare);
                  UserPreferences().saveSWM(stickWithMe);
                  Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
                }
              ),
              SBtn(
                text: "No, I don't", textSize: 16,
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
}

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