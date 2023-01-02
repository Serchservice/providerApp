import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:provide/lib.dart';

// String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

class MethodAssist{

  static Future<List> convertToCoordinates(String placeAddress, context) async {
    List<Location> locations = await locationFromAddress(placeAddress);
    String latitude = locations.last.latitude.toString();
    String longitude = locations.last.longitude.toString();

    AddressModel userPickupAddress = AddressModel();
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
    String streetAndNumber = placemarks.reversed.last.street.toString();
    String streetName = placemarks.last.street.toString();
    String stNo = placemarks.last.subThoroughfare.toString();
    String postalCode = placemarks.last.postalCode.toString();

    placeAddress = "$streetNumber, $streetName, $city, $lga, $state, $country";
    debugShow("$streetNumber, $streetName, $city, $lga, $state, $country");
    debugShow("$streetAndNumber, $stNo, $postalCode");

    AddressModel userAddress = AddressModel();
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

    AddressModel userCurrentAddress = AddressModel();
    userCurrentAddress.latitude = position.latitude;
    userCurrentAddress.longitude = position.longitude;
    userCurrentAddress.placeName = placeAddress;
    Provider.of<UserMapInformation>(context, listen: false).updateCurrentLocation(userCurrentAddress);
    return placeAddress;
  }
}