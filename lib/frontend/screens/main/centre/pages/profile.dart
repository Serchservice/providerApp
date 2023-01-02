import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ConnectivityResult connectionState = ConnectivityResult.none;
  StreamSubscription? subscription;
  bool isAlert = false;
  bool isDeviceConnected = false;

  bool finishSignup = false;

  void getCurrentUserAddInfo() async {
    // DocumentReference ref = MainDB().providers.doc(user?.email).collection(SecondDB.profile).doc(ProfileDB.additional);

    // ref.get().then((DocumentSnapshot snapshot) {
    //   if(snapshot.data() != null){
    //     currentUserAddInfo = UserAddInfo.fromSnapshot(snapshot);
    //   } else {
    //     setState(() => finishSignup = true);
    //     debugShow("Error");
    //   }
    // }).onError((error, stackTrace) {
    //   if(error.toString() == "field does not exist within the DocumentSnapshotPlatform"){
    //     setState(() => finishSignup = true);
    //   }
    //   setState(() => finishSignup = true);
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

  @override
  void initState() {
    super.initState();
    // SerchUser.getCurrentUserInfo();
    // getCurrentUserAddInfo();
    // getConnection(context);
  }

  @override
  void dispose(){
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: Theme.of(context).primaryColorLight,
                size: 28
              )
            ),
            title: SText(
              text: "My Contact Information",
              color: Theme.of(context).primaryColorLight,
              size: 30,
              weight: FontWeight.bold
            ),
            expandedHeight: 200,
          ),
          finishSignup
          ? SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Material(
                  color: SColors.aqua,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () => Get.offAll(() => const AdditionalScreen()),
                    child: Container(
                      padding: screenPadding,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(SImages.layers, width: 50,),
                          const SizedBox(width: 10),
                          const Expanded(child: SText(
                            text: "You skipped out on the fun! Finish with your signup by tapping this box!",
                            color: SColors.white, size: 16, weight: FontWeight.bold
                          ))
                        ],
                      )
                    ),
                  ),
                ),
              ),
            )
          : SliverToBoxAdapter(
            child: Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Basic Address
                  const SizedBox(height: 10,),
                  const SText(
                    text: "Basic Information.",
                    color: SColors.hint,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.streetNumber,
                          formName: "Street Number *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.streetName,
                          formName: "Street Name *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.lga ?? "",
                          formName: "LGA (Optional)",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.landMark ?? "",
                          formName: "LandMark (Optional)",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.userCity,
                          formName: "Residential City *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.stateOfOrigin,
                          formName: "State of Origin *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ],
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserAddInfo?.country,
                    formName: "Residential Country *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),

                  const SizedBox(height: 20,),
                  //Email and Phone Number
                  const SText(
                    text: "Email Address and Phone Number",
                    color: SColors.hint,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10,),
                  SFormField(
                    enabled: false,
                    labelText: currentUserInfo?.emailAddress,
                    formName: "Email Address",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserAddInfo?.emailAlternate,
                    formName: "Alternate Email",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserInfo?.phoneNumber,
                    formName: "Phone Number",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserAddInfo?.alternatePhoneNumber,
                    formName: "Alternate Phone Number",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),

                  const SizedBox(height: 20,),
                  //Next of Kin
                  const SText(
                    text: "Next of Kin (This contact is for emergencies)",
                    color: SColors.hint,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 145,
                        child: SDropDown(
                          list: title,
                          hintText: currentUserAddInfo?.nokTitle,
                          formName: "Title *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          width: 170,
                          child: SDropDown(
                            list: relationship,
                            hintText: currentUserAddInfo?.nokRelationship,
                            formName: "Relationship *",
                            fillColor: Theme.of(context).scaffoldBackgroundColor,
                            formColor: Theme.of(context).primaryColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                      )
                      ,
                    ],
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserAddInfo?.nokFirstName,
                    formName: "First Name *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserAddInfo?.nokLastName,
                    formName: "Last Name *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserAddInfo?.nokPhoneNumber,
                    formName: "Phone Number *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: currentUserAddInfo?.nokEmailAddress ?? "",
                    formName: "Email Address (Optional)",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.nokAddress,
                          formName: "Address *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.nokCity,
                          formName: "City *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.nokState,
                          formName: "State *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: SFormField(
                          enabled: false,
                          labelText: currentUserAddInfo?.nokCountry,
                          formName: "Country *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}