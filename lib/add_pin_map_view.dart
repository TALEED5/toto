// ignore_for_file: prefer_final_fields, library_private_types_in_public_api

import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import '../utils/assets.dart';

class AddPinMapView extends StatefulWidget {
  const AddPinMapView({Key? key}) : super(key: key);

  @override
  _AddPinMapViewState createState() => _AddPinMapViewState();
}

class _AddPinMapViewState extends State<AddPinMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  String _address = "";
  LatLng? _position;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.7135517, 46.6752957),
    zoom: 12,
  );

  List<String> markersList = ["24.7135517-46.6752957", "24.723453-46.694832"];
  Map<MarkerId, Marker> markers = {};

  _addMarker(LatLng position, String id) {
    markers.clear();
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, position: position, onTap: () {});
    markers[markerId] = marker;
    setState(() {});
  }

  
  Future<void> getLocationData(LatLng position) async {
   
    _position = position;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    _address = placemarks.first.name ?? "";
    

    _customInfoWindowController.addInfoWindow!(
      Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffC17359),
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
  }

  @override
  void initState() {
    super.initState();
    // setMarkers();
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
              getLocationData(position);
              _addMarker(position, "${position.latitude}");
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_address == "") {
            Fluttertoast.showToast(msg: "الرجاء تحديد العنوان");
          } else {
            Get.back(result: [_address, _position]);
          }
        },
        label: const Text('تحديد'),
        icon: const Icon(Icons.select_all),
        backgroundColor: Color(0xff5F7858),
        //const Color(0xff427859)
      ),
    );
  }
}
