// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toto/firebase_operations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:toto/readStory.dart';
import 'package:toto/story.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String mapTheme = '';
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late String stid;

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.7135517, 46.6752957),
    zoom: 5.0,
  );
  DateTime d = DateTime.now();
  List<dynamic> markersList = [];
  Map<MarkerId, Marker> markers = {};
  late Story st = new Story(
      id: "id",
      title: "title",
      discreption: "discreption",
      date: d,
      writername: "writername",
      writerUsername: "writerUsername",
      writerid: "writerid",
      content: "content",
      ARlink: "ARlink",
      region: "region",
      likes: <String, bool>{},
      likecount: 0,
      commentCount: 0);

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);

    Marker marker = Marker(
        markerId: markerId,
        position: position,
        onTap: () async {
          // اذا ضغطت على البين

          FirebaseFirestore.instance
              .collection("Stories")
              .where("latlng",
                  isEqualTo: "${position.latitude}-${position.longitude}")
              .get()
              .then((snapshot) {
            for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.docs) {
              st = Story.fromJson(doc);
              //stid = st.id;
            }
          });

          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          //انفو ويندو فيه اسم الحي
          _customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(212, 193, 115, 89),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReadStory(st)),
                        );
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              st.title,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 255, 255, 254),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ElMessiri"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            position,
          );
        });
    markers[markerId] = marker;
  }

  Future<void> setMarkers() async {
    BitmapDescriptor sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(30, 30)),
        'assets/images/icons/placeholder-3.png');

    for (var element in markersList) {
      var vv = element.split("-");

      //print(vv[0]);
      _addMarker(LatLng(double.parse(vv[0]), double.parse(vv[1])),
          "${element}_origin", sourceIcon);
    }

    setState(() {});
  }

  void getAllAddressFromLocal() {
    GetStorage box = GetStorage();
    if (box.read("local_addresses") != null) {
      List<dynamic> address = box.read("local_addresses");
      // ignore: unnecessary_null_comparison
      if (address != null) {
        markersList = address;
        setMarkers();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/MapStyle/MapS.json')
        .then((Value) {
      mapTheme = Value;
    });
    getAddresses();
  }

  void getAddresses() async {
    List<String> data = await getLocationsFromFire();
    if (data.isNotEmpty) {
      markersList = data;
      setMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(markers.values),
            onTap: (position) {
              // getLocationData(position);
            },
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(mapTheme);
              _controller.complete(controller);
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 45,
            width: 220.w,
            offset: 30,
          ),
        ],
      ),
    );
  }
}
