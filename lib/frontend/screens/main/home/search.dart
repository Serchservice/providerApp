import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provide/lib.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  final String selected;
  const SearchScreen({super.key, required this.selected});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  final _formKey = GlobalKey<FormState>();
  TextEditingController locationTextControl = TextEditingController();
  String _sessionToken = "";
  List<dynamic> _listPlaces = [];
  final input = FocusNode();
  // DocumentReference? serviceRequestRef;

  @override
  void initState() {
    super.initState();
    locationTextControl.addListener(() => onChanged());
  }

  void onChanged() {
    if(_sessionToken.isEmpty){
      setState(() => _sessionToken = CodeGenerator.uniqueID.v4());
    }
    getSuggestion(locationTextControl.text);
  }

  void getSuggestion(String searchAddress) async {
    try {
      if(searchAddress.length > 1){
        String mapUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
        String request = "$mapUrl?input=$searchAddress&key=$googleMapApiKey&sessiontoken=$_sessionToken";
        var response = await http.get(Uri.parse(request));
        if(response.statusCode == 200){
          setState(() {
            _listPlaces = jsonDecode(response.body.toString())['predictions'];
          });
        } else {
          showGetSnackbar(message: "Couldn't find the location, try again", type: Popup.error);
        }
      }
    } on HttpException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  void searchProvidersWithServiceLocation(String serviceAddress, context) async {
    if(!_formKey.currentState!.validate()) return;
    try {
      _formKey.currentState!.save();
      showDialog(
        context: context, barrierDismissible: false, builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AlertLoader.fallingDot(
            size: 40, color: Theme.of(context).primaryColor, text: "Searching for providers in your area", textSize: 16,
          ),
        )
      );
      List<Location> locations = await locationFromAddress(serviceAddress);
      Navigator.of(context).pop();
      input.unfocus();
      UserAddressModel userAddressModel = UserAddressModel();
      userAddressModel.latitude = locations.last.latitude;
      userAddressModel.longitude = locations.last.longitude;
      userAddressModel.placeName = serviceAddress;
      Provider.of<UserMapInformation>(context, listen: false).updateServiceLocation(userAddressModel);
      MapFunctions().saveServiceRequest(Provider.of<UserMapInformation>(context, listen: false).serviceLocation, userInformationModel);
    } on NoResultFoundException catch (e) {
      showGetSnackbar(message: e.toString(), type: Popup.error);
      Navigator.of(context).pop();
    }
  }

  void searchProvidersWithCurrentLocation(String location, context){
    // Get.to(() => OnlineProviderList(
    //   title: widget.selected,
    //   location: location,
    //   serviceRequestRef: serviceRequestRef!,
    // ));
    MapFunctions().saveServiceRequest(Provider.of<UserMapInformation>(context, listen: false).currentLocation, userInformationModel);
  }

  void searchProvidersWithSuggestion(String placeId, context) async {
    String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleMapApiKey";
    showDialog(
      context: context, barrierDismissible: false, builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertLoader.fallingDot(
          size: 40, color: Theme.of(context).primaryColor, text: "Wait a moment...", textSize: 16,
        ),
      )
    );
    var response = await http.get(Uri.parse(url));
    Navigator.of(context).pop();
    if(response.statusCode == 200){
      UserAddressModel userAddressModel = UserAddressModel();
      userAddressModel.latitude = jsonDecode(response.body.toString())["result"]["geometry"]["location"]["lat"];
      userAddressModel.longitude = jsonDecode(response.body.toString())["result"]["geometry"]["location"]["lng"];
      userAddressModel.placeID = placeId;
      userAddressModel.placeFormattedAddress = jsonDecode(response.body.toString())["result"]["formatted_address"];
      userAddressModel.placeName = jsonDecode(response.body.toString())["result"]["name"];

      Provider.of<UserMapInformation>(context, listen: false).updateServiceLocation(userAddressModel);
      confirmIncomingProviderShareRequest(context: context, providerName: "Evaristus");
      MapFunctions().saveServiceRequest(Provider.of<UserMapInformation>(context, listen: false).serviceLocation, userInformationModel);
      // Get.to(() => OnlineProviderList(
      //   title: widget.selected,
      //   location: address.placeFormattedAddress!,
      //   serviceRequestRef: serviceRequestRef!,
      // ));
    } else {
      showGetSnackbar(message: "Couldn't locate the place", type: Popup.error);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    String serviceLocation = Provider.of<UserMapInformation>(context).currentLocation.placeName.isEmpty ? "Add Home"
    : Provider.of<UserMapInformation>(context).currentLocation.placeName;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).bottomAppBarColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColorLight, blurRadius: 5.0,
                    spreadRadius: 1, offset: const Offset(0.0, 10.0), blurStyle: BlurStyle.outer
                  )
                ]
              ),
              child: Padding(
                padding: screenPadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: Icon(CupertinoIcons.chevron_back, color: Theme.of(context).primaryColor, size: 28)
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SText(
                            text: widget.selected == "Electrician" ? "You are looking for an" : "You are looking for a",
                            size: 16,
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
                            child: SText(text: widget.selected, color: SColors.white, size: 14, weight: FontWeight.bold,)
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
                        formName: "Where is the ${widget.selected.toLowerCase()} coming to?",
                        controller: locationTextControl,
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
                        onChanged: (val) => getSuggestion(val),
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: InkWell(
                            onTap: () => searchProvidersWithCurrentLocation(serviceLocation, context),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.mapLocation, size: 16, color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 20),
                                  SText(
                                    text: "Use my current location",
                                    color: Theme.of(context).primaryColor,
                                    size: 16, weight: FontWeight.bold
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
                        padding: const EdgeInsets.all(12),
                        textWeight: FontWeight.bold,
                        onClick: () => searchProvidersWithServiceLocation(locationTextControl.text, context)
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: screenPadding,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _listPlaces.length,
                separatorBuilder: (context, index) => const Divider(height: 25, thickness: 2,),
                itemBuilder: (context, index) {
                  if(_listPlaces[index]["structured_formatting"]["secondary_text"] == null
                  || _listPlaces[index]["structured_formatting"]["main_text"] == null){
                    return Center(
                      child: SText(
                        text: "Couldn't find the address you are looking for",
                        color: Theme.of(context).primaryColorLight, size: 16,
                      ),
                    );
                  }
                  return AddressListTile(
                    onClick: () => searchProvidersWithSuggestion(_listPlaces[index]["place_id"], context),
                    maintext: _listPlaces[index]["structured_formatting"]["main_text"],
                    secondarytext: _listPlaces[index]["structured_formatting"]["secondary_text"],
                  );
                }
              ),
            ),
          ],
        )
    );
  }
}

class AddressListTile extends StatelessWidget {
  final String maintext;
  final String secondarytext;
  final void Function()? onClick;
  const AddressListTile({super.key, required this.maintext, required this.secondarytext, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(CupertinoIcons.map_pin, color: SColors.yellow, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: maintext, color: Theme.of(context).primaryColor,
                      flow: TextOverflow.ellipsis, size: 18,
                    ),
                    const SizedBox(height: 3),
                    SText(
                      text: secondarytext, flow: TextOverflow.ellipsis,
                      color: Theme.of(context).primaryColor, size: 16
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}