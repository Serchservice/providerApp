import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provide/lib.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  final String selected;
  const SearchScreen({super.key, required this.selected});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController locationTextControl = TextEditingController();
  var uniqueID = const Uuid();
  String _sessionToken = "123456";
  List<dynamic> _listPlaces = [];
  final input = FocusNode();
  // DocumentReference? serviceRequestRef;

  @override
  void initState() {
    super.initState();
    locationTextControl.addListener(() => onChanged());
    // MapDB.getCurrentUserInfo();
  }

  void onChanged() {
    // ignore: unnecessary_null_comparison
    if(_sessionToken == null){
      setState(() => _sessionToken = uniqueID.v4());
    }
    getSuggestion(locationTextControl.text);
  }

  void getSuggestion(String searchAddress) async {
    if(searchAddress.length > 1){
      String mapUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request = "$mapUrl?input=$searchAddress&key=$googleMapApiKey&sessiontoken=$_sessionToken";

      var response = await http.get(Uri.parse(request));

      if(response.statusCode == 200){
        setState(() {
          _listPlaces = jsonDecode(response.body.toString())['predictions'];
        });
      } else {
        throw Exception("failed");
      }
    }
  }

  void searchProvidersWithServiceLocation(String serviceAddress, context) async {
    if(!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      showDialog(
        context: context,
        barrierDismissible: false, //Fix SU
        builder:(context) => SLoader.fallingDot(color: Theme.of(context).scaffoldBackgroundColor, size: 70),
      );

      List<Location> locations = await locationFromAddress(serviceAddress);

      Navigator.pop(context);
      input.unfocus();

      AddressModel userServiceAddress = AddressModel();
      userServiceAddress.latitude = locations.last.latitude;
      userServiceAddress.longitude = locations.last.longitude;
      userServiceAddress.placeName = serviceAddress;

      Provider.of<UserMapInformation>(context, listen: false).updateServiceLocation(userServiceAddress);
    } on NoResultFoundException catch (e) {
      debugShow(e);
      showGetSnackbar(
        message: "We could not find any result for the supplied address or coordinates.",
        type: Popup.error,
        duration: const Duration(seconds: 5),
      );
      Navigator.pop(context);
    }
  }

  void searchProvidersWithCurrentLocation(String location, context){
    // Get.to(() => OnlineProviderList(
    //   title: widget.selected,
    //   location: location,
    //   serviceRequestRef: serviceRequestRef!,
    // ));
    saveServiceRequest(Provider.of<UserMapInformation>(context, listen: false).currentLocation!);
  }

  void searchProvidersWithSuggestion(String placeId, context) async {
    String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleMapApiKey";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) => SLoader.fallingDot(color: Theme.of(context).scaffoldBackgroundColor, size: 70),
    );

    var response = await http.get(Uri.parse(url));

    Navigator.pop(context);
    if(response.statusCode == 200){
      AddressModel address = AddressModel();
      address.latitude = jsonDecode(response.body.toString())["result"]["geometry"]["location"]["lat"];
      address.longitude = jsonDecode(response.body.toString())["result"]["geometry"]["location"]["lng"];
      address.placeId = placeId;
      address.placeFormattedAddress = jsonDecode(response.body.toString())["result"]["formatted_address"];
      address.placeName = jsonDecode(response.body.toString())["result"]["name"];

      Provider.of<UserMapInformation>(context, listen: false).updateServiceLocation(address);
      // Get.to(() => OnlineProviderList(
      //   title: widget.selected,
      //   location: address.placeFormattedAddress!,
      //   serviceRequestRef: serviceRequestRef!,
      // ));
    } else {
      showGetSnackbar(
        message: "We could not find any result for the supplied address or coordinates.",
        type: Popup.error,
        duration: const Duration(seconds: 5),
      );
      throw Exception("failed");
    }

    saveServiceRequest(Provider.of<UserMapInformation>(context, listen: false).serviceLocation!);
  }

  void saveServiceRequest(AddressModel serviceLocation) {
    // serviceRequestRef = MainDB().individual.doc(currentUserInfo?.email).collection(SecondDB.connection).doc(ConnectionDB.requests);

    var location = serviceLocation;
    Map serviceLocationMap = {
      "latitude": location.latitude.toString(),
      "longitude": location.longitude.toString()
    };

    debugShow({
      "serviceStatus": "searching",
      "serviceLocation": serviceLocationMap,
      "clientName": "${currentUserInfo?.firstName} ${currentUserInfo?.lastName}",
      "clientPhone": currentUserInfo?.phone,
      "createdAt": DateTime.now().toString(),
      "serviceAddress": location.placeName
    });
  }

  @override
  Widget build(BuildContext context) {
    String serviceLocation = Provider.of<UserMapInformation>(context).currentLocation?.placeName ?? "Add Home";
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
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            onTap: () => searchProvidersWithCurrentLocation(serviceLocation, context),
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
                  itemBuilder: (context, index) => AddressListTile(
                    onClick: () => searchProvidersWithSuggestion(_listPlaces[index]["place_id"], context),
                    maintext: _listPlaces[index]["structured_formatting"]["main_text"],
                    secondarytext: _listPlaces[index]["structured_formatting"]["secondary_text"],
                  )
                ),
              ),
          ],
        )
    );
  }
}