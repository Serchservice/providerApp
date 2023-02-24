import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:provide/lib.dart';

class HttpRequestAssist{
  static Future<dynamic> getRequest(Uri url) async {
    http.Response response = await http.get(url);

    try {
      if(response.statusCode == 200){
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);

        return decodeData;
      } else {
        return "failed";
      }
    } catch (e) {
      return "failed";
    }
  }
}

// String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

class MapFunctions{
  static Future<List> convertToCoordinates(String placeAddress, context) async {
    List<Location> locations = await locationFromAddress(placeAddress);
    String latitude = locations.last.latitude.toString();
    String longitude = locations.last.longitude.toString();

    UserAddressModel userPickupAddress = UserAddressModel();
    userPickupAddress.latitude = locations.last.latitude;
    userPickupAddress.longitude = locations.last.longitude;
    userPickupAddress.placeName = placeAddress;

    debugShow("$latitude $longitude");
    return locations;
  }

  static Future<String> getAddress(Position position, context) async {
    String placeAddress = "";
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String country = placemarks.last.country.toString();
    String state = placemarks.last.administrativeArea.toString();
    String lga = placemarks.last.subAdministrativeArea.toString();
    String city = placemarks.last.locality.toString();
    String streetNumber = placemarks.reversed.last.name.toString();
    // String streetAndNumber = placemarks.reversed.last.street.toString();
    String streetName = placemarks.last.street.toString();
    // String stNo = placemarks.last.subThoroughfare.toString();
    // String postalCode = placemarks.last.postalCode.toString();

    placeAddress = "$streetNumber, $streetName, $city, $lga, $state, $country";
    UserAddressModel userAddress = UserAddressModel();
    userAddress.latitude = position.latitude;
    userAddress.longitude = position.longitude;
    userAddress.placeName = placeAddress;

    Provider.of<UserMapInformation>(context, listen: false).updateHomeLocation(userAddress);

    return placeAddress;
  }

  static Future<String> getCurrentAddress(Position position, context) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String placeAddress = "";

    String country = placemarks.last.country.toString();
    String state = placemarks.last.administrativeArea.toString();
    String lga = placemarks.last.subAdministrativeArea.toString();
    String city = placemarks.last.locality.toString();
    String streetNumber = placemarks.last.subThoroughfare.toString();
    String streetName = placemarks.reversed.last.thoroughfare.toString();

    placeAddress = "$streetNumber $streetName, $city, $lga, $state, $country";
    UserAddressModel userCurrentAddress = UserAddressModel();
    userCurrentAddress.latitude = position.latitude;
    userCurrentAddress.longitude = position.longitude;
    userCurrentAddress.placeName = placeAddress;
    Provider.of<UserMapInformation>(context, listen: false).updateCurrentLocation(userCurrentAddress);
    return placeAddress;
  }

  void saveServiceRequest(UserAddressModel serviceLocation, UserInformationModel userInformationModel) {
    // serviceRequestRef = MainDB().individual.doc(currentUserInfo?.email).collection(SecondDB.connection).doc(ConnectionDB.requests);
    var location = serviceLocation;
    Map serviceLocationMap = {
      "latitude": location.latitude.toString(),
      "longitude": location.longitude.toString()
    };
    debugShow({
      "serviceStatus": "searching",
      "serviceLocation": serviceLocationMap,
      "clientName": "${userInformationModel.firstName} ${userInformationModel.lastName}",
      "clientPhone": "currentUserInfo?.phone",
      "createdAt": DateTime.now().toString(),
      "serviceAddress": location.placeName
    });
  }
}