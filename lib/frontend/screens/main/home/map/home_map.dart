import 'dart:async';
// import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';
// import 'package:provide/lib.dart';
// import 'package:location/location.dart' as locate;
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomeMap extends StatefulWidget {
  final double width;
  final double height;
  final double lat;
  final double lng;
  final bool online;
  final VoidCallback? toggleStatus;
  const HomeMap({
    super.key, required this.width, required this.height, this.lat = 37.42796133580664, this.lng = -122.085749655962,
    required this.online, this.toggleStatus
  });

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  Position? currentPosition;
  static const initialPosition = LatLng(12.97, 77.58); //Use in cameraposition - target
  //LatLng(37.43296265331129, -122.08832357078792)
  var geolocator = Geolocator();

  final Set<Marker> markers = {};

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: initialPosition,
    zoom: 14.4746,
  );

  final CameraPosition kLake = const CameraPosition(
    bearing: 192.8334901395799,
    target: initialPosition,
    tilt: 59.440717697143555,
    zoom: 19.151926040649414
  );

  //use in onMapCreated
  void onCreated(GoogleMapController controller){
    setState(() {
      mapController = controller;
    });
  }

  void locatePosition(context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      await Geolocator.requestPermission();
    } else if(permission == LocationPermission.deniedForever){
      await Geolocator.requestPermission();
    } else if(permission == LocationPermission.unableToDetermine){
      await Geolocator.openLocationSettings();
    } else {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;

      LatLng latLng = LatLng(position.latitude, position.longitude);
      CameraPosition camPosition = CameraPosition(target: latLng, zoom: 14);
      mapController?.animateCamera(CameraUpdate.newCameraPosition(camPosition));

      await MethodAssist.getCurrentAddress(position, context);
      saveServiceRequest();
    }
  }

  void saveServiceRequest() {
    // locationRef = MainDB().providers.doc(currentUserInfo?.email).collection(SecondDB.profile).doc(ProfileDB.service);

    var location = Provider.of<UserMapInformation>(context, listen: false).currentLocation!;
    Map serviceLocationMap = {
      "latitude": location.latitude.toString(),
      "longitude": location.longitude.toString()
    };
    debugShow({
      "serviceLocation": serviceLocationMap,
      "latitude": location.latitude.toString(),
      "longitude": location.longitude.toString(),
      "createdAt": DateTime.now().toString(),
      "serviceAddress": location.placeName,
      "online" : widget.online
    });

    // locationRef!.set({
    //   "serviceLocation": serviceLocationMap,
    //   "latitude": location.latitude.toString(),
    //   "longitude": location.longitude.toString(),
    //   "createdAt": DateTime.now().toString(),
    //   "serviceAddress": location.placeName,
    //   "online" : widget.online
    // }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            markers: markers,
            // onCameraMove: onCameraMove,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
              locatePosition(context);

              //Black theme
              mapController?.setMapStyle('''
                [
                  {
                    "elementType": "geometry",
                    "stylers": [
                      {
                        "color": "#242f3e"
                      }
                    ]
                  },
                  {
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#746855"
                      }
                    ]
                  },
                  {
                    "elementType": "labels.text.stroke",
                    "stylers": [
                      {
                        "color": "#242f3e"
                      }
                    ]
                  },
                  {
                    "featureType": "administrative.locality",
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#d59563"
                      }
                    ]
                  },
                  {
                    "featureType": "poi",
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#d59563"
                      }
                    ]
                  },
                  {
                    "featureType": "poi.park",
                    "elementType": "geometry",
                    "stylers": [
                      {
                        "color": "#263c3f"
                      }
                    ]
                  },
                  {
                    "featureType": "poi.park",
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#6b9a76"
                      }
                    ]
                  },
                  {
                    "featureType": "road",
                    "elementType": "geometry",
                    "stylers": [
                      {
                        "color": "#38414e"
                      }
                    ]
                  },
                  {
                    "featureType": "road",
                    "elementType": "geometry.stroke",
                    "stylers": [
                      {
                        "color": "#212a37"
                      }
                    ]
                  },
                  {
                    "featureType": "road",
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#9ca5b3"
                      }
                    ]
                  },
                  {
                    "featureType": "road.highway",
                    "elementType": "geometry",
                    "stylers": [
                      {
                        "color": "#746855"
                      }
                    ]
                  },
                  {
                    "featureType": "road.highway",
                    "elementType": "geometry.stroke",
                    "stylers": [
                      {
                        "color": "#1f2835"
                      }
                    ]
                  },
                  {
                    "featureType": "road.highway",
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#f3d19c"
                      }
                    ]
                  },
                  {
                    "featureType": "transit",
                    "elementType": "geometry",
                    "stylers": [
                      {
                        "color": "#2f3948"
                      }
                    ]
                  },
                  {
                    "featureType": "transit.station",
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#d59563"
                      }
                    ]
                  },
                  {
                    "featureType": "water",
                    "elementType": "geometry",
                    "stylers": [
                      {
                        "color": "#17263c"
                      }
                    ]
                  },
                  {
                    "featureType": "water",
                    "elementType": "labels.text.fill",
                    "stylers": [
                      {
                        "color": "#515c6d"
                      }
                    ]
                  },
                  {
                    "featureType": "water",
                    "elementType": "labels.text.stroke",
                    "stylers": [
                      {
                        "color": "#17263c"
                      }
                    ]
                  }
                ]
            ''');
            },
          )
        ),

        Provider.of<UserServiceInformation>(context, listen: false).status == "Online"
        ? Container()
        : Container(
          height: widget.height,
          width: double.infinity,
          color: Colors.black87
        ),

        Provider.of<UserServiceInformation>(context, listen: false).status == "Online"
        ? Container()
        : Align(
          alignment: Alignment.center,
          child: Material(
            color: SColors.yellow,
            child: InkWell(
              onTap: widget.toggleStatus,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                width: 120,
                child: Row(
                  children: const [
                    Icon(
                      CupertinoIcons.bolt_circle_fill,
                      size: 24,
                      color: SColors.white
                    ),
                    SizedBox(width: 10),
                    SText(text: "Go online", size: 16, color: SColors.white)
                  ]
                ),
              ),
            )
          )
        )
      ],
    );
  }
}