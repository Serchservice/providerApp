// ignore_for_file: non_constant_identifier_names

class AddressModel{
  String? placeFormattedAddress;
  String? placeName;
  String? placeId;
  double? latitude;
  double? longitude;

  AddressModel({this.latitude, this.longitude, this.placeFormattedAddress, this.placeId, this.placeName});
}

class UserAddress{
  String? streetNumber;
  String? streetName;
  String? city;
  String? lga;
  String? state;
  String? country;

  UserAddress({
    this.streetNumber, this.streetName, this.city, this.lga, this.state, this.country
  });
}

class PlacePrediction{
  String? secondary_text;
  String? main_text;
  String? place_id;

  PlacePrediction({
    this.secondary_text, this.main_text, this.place_id
  });

  PlacePrediction.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
    secondary_text = json["secondary_text"];
    main_text = json["main_text"];
  }
}