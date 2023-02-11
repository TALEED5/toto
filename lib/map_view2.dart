// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toto/firebase_operations.dart';
import 'package:geocoding/geocoding.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.7135517, 46.6752957),
    zoom: 12,
  );

  List<dynamic> markersList = [];
  Map<MarkerId, Marker> markers = {};

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        position: position,
        onTap: () async {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);

          _customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            placemarks.first.name ?? "",
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
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
    // getAllAddressFromLocal();
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
              _controller.complete(controller);
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 50,
            width: 250.w,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
