import 'dart:async';
// import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:provide/lib.dart';
// import 'package:location/location.dart' as locate;
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
  UserSettingModel settingModel = HiveUserDatabase().getSettingData();
  late final Stream<UserServiceAndPlan> _serviceStream;
  bool location = false;

  @override
    void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkFirstRun(context));

    _serviceStream = supabase.from(Supa().serviceAndPlan).stream(primaryKey: ['id']).eq("serchID", userInformationModel.serchID).map(
      (maps) => maps.map((map) => UserServiceAndPlan.fromMap(map)).toList()
    ).map((list) => list.first);
  }

  Future toggleStatus() async {
    final serviceAndPlan = await _serviceStream.first;
    if(serviceAndPlan.status == "Online") {
      await supabase.from(Supa().serviceAndPlan).update({"status": "Offline"}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveServiceAndPlanData(serviceAndPlan.copyWith(status: "Offline"));
    } else if(serviceAndPlan.status == "Offline") {
      await supabase.from(Supa().serviceAndPlan).update({"status": "Online"}).eq("serchID", userInformationModel.serchID);
      HiveUserDatabase().saveServiceAndPlanData(serviceAndPlan.copyWith(status: "Online"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 50,
        leading: StreamBuilder<UserServiceAndPlan>(
          stream: _serviceStream,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final service = snapshot.data!;
              HiveUserDatabase().saveServiceAndPlanData(service);
              return service.status == "Online" || settingModel.alwaysOnline ? Material(
                color: SColors.green,
                child: InkWell(
                  onTap: () => toggleStatus(),
                  child: const Icon(CupertinoIcons.bolt_circle_fill, size: 28, color: SColors.white),
                ),
              ) : Container();
            } else {
              return Container();
            }
          }
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SlidingUpPanel(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        minHeight: 80.5,
        maxHeight: userServiceAndPlan.onTrip ? 400 : 330,
        padding: const EdgeInsets.all(20),
        collapsed: const SlideCollapsed(),
        panel: userServiceAndPlan.onTrip ? const ConnectedProfile() : const NoTripCount(),
        body: HomeMap(width: width, height: height, toggleStatus: () => toggleStatus(), serviceStream: _serviceStream,),
      ),
    );
  }
}

class HomeMap extends StatefulWidget {
  final double width;
  final double height;
  final double lat;
  final double lng;
  final Stream<UserServiceAndPlan> serviceStream;
  final VoidCallback? toggleStatus;
  const HomeMap({
    super.key, required this.width, required this.height, this.lat = 37.42796133580664, this.lng = -122.085749655962,
    this.toggleStatus, required this.serviceStream
  });

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
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
      await MapFunctions.getCurrentAddress(position, context);
      MapFunctions().saveServiceRequest(Provider.of<UserMapInformation>(context, listen: false).serviceLocation, userInformationModel);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locatePosition(context);
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

        StreamBuilder(
          stream: widget.serviceStream,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final service = snapshot.data!;
              HiveUserDatabase().saveServiceAndPlanData(service);
              return service.status == "Online" || userSettingModel.alwaysOnline ? Container() :Container(
                height: widget.height,
                width: double.infinity,
                color: Colors.black87
              );
            } else {
              return Container();
            }
          }
        ),

        StreamBuilder(
          stream: widget.serviceStream,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final service = snapshot.data!;
              HiveUserDatabase().saveServiceAndPlanData(service);
              return service.status == "Online" || userSettingModel.alwaysOnline ? Container() : Align(
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
              );
            } else {
              return Container();
            }
          }
        ),
      ],
    );
  }
}