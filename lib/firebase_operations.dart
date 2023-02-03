// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


Future<void> saveLocationToFire(String latLng) async {
  try {
    db.collection("locations").doc().set({
      'latlng': latLng,
    }).then((value) {
      // print("saved to Firestore");
      Fluttertoast.showToast(msg: "تم الحفظ بنجاح");
    });
  } catch (e) {
    print(e);
  }
}

Future<List<String>> getLocationsFromFire() async {
  final QuerySnapshot result = await db.collection('locations').get();
  final List<DocumentSnapshot> documents = result.docs;
  print(documents);

  List<String> myListString = []; // My list I want to create.

  for (var snapshot in documents) {
    myListString.add(snapshot.get("latlng"));
    print(snapshot.get("latlng"));
  }

  return myListString;
}


