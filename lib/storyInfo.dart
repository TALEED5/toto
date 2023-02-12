// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toto/TaleedApp.dart';
import 'package:toto/writerHome.dart';
import './home.dart';
import 'dart:ui' as ui;
import './story.dart';
import './writerWriteStory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toto/firebase_operations.dart';
import 'package:toto/add_pin_map_view.dart';

import 'BottomNavBar.dart';

class StoryInfo extends StatefulWidget {
  final String scontent;
  const StoryInfo({required this.scontent});

  @override
  State<StoryInfo> createState() => _StoryInfo(scontent: scontent);
}

class _StoryInfo extends State<StoryInfo> {
  _StoryInfo({required this.scontent});
  String address = "";
  LatLng? coordinates;
  final _auth = FirebaseAuth.instance;

  String selectedValue = "الرياض";

  String scontent;
  final formKey = GlobalKey<FormState>(); //key for form
  bool? agree = false;
  bool field1 = false;
  bool field2 = false;
  late DateTime _selectedDate;

  final titleController = TextEditingController();
  final discreptionController = TextEditingController();
  final reigonController = TextEditingController();

  void saveAddressToLocal() {
    GetStorage box = GetStorage();
    saveLocationToFire("${coordinates?.latitude}-${coordinates?.longitude}");
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      backgroundColor: Color(0xffe5e5e5),

      //------------------------------app bar------------------------------------------------
      appBar: AppBar(
        backgroundColor: Color(0xff5F7858),
        title: const Text(
          "معلومات القصة",
          style: TextStyle(fontFamily: 'tajawal', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: writePage,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(builder: (context) => navBar()),
                    (route) => false);
              },
              icon: Icon(Icons.clear),
              color: Colors.white)
        ],
      ),

      //---------------------navigation bar-----------------------------
      bottomNavigationBar: Container(
        color: const Color(0xffF6F6F6),
        height: 53,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        ),
      ),

      //-------------------------------Body---------------------------------------
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          //physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),

                Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: TextFormField(
                    maxLength: 30, //max number of characters for the text field
                    textAlign: TextAlign.right,
                    textDirection: ui.TextDirection.rtl,
                    controller: titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Color(0xffF6F6F6)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Color(0xFF90B28D))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 242, 104, 94))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.red)),
                      labelText: 'العنوان',
                      labelStyle: TextStyle(
                          color: Color.fromARGB(172, 29, 22, 13),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'tajawal'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "الرجاء كتابة عنوان للقصة";
                      }
                      field1 = true;
                      return null;
                    },

                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          field1 = false;
                        }
                      });
                    },
                  ),
                ),

                SizedBox(height: height * 0.04),
                SingleChildScrollView(
                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: TextFormField(
                      controller: discreptionController,
                      maxLength: 120,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      textAlign: TextAlign.right,
                      textDirection: ui.TextDirection.rtl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'نبذة عن القصة',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(175, 48, 44, 39),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'tajawal'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Color(0xffF6F6F6)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF90B28D))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 242, 104, 94))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.red)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          field2 = false;
                          return "الرجاء كتابة نبذة عن القصة";
                        }
                        field2 = true;
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            field2 = false;
                          }
                        });
                      },
                    ),
                  ),
                  //)
                ),

                //--------------------------------date----------------------

                SizedBox(height: height * 0.04),
                Container(
                  height: 49.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextField(
                      //editing controller of this TextField
                      textAlign: TextAlign.right,
                      //cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "تاريخ وقوع القصة",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(175, 48, 44, 39),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'tajawal'),
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: _presentDatePicker,
                    ),
                  ),
                ),

                //-----------------------------تحديد القصة على الخريطة-------------------------
                SizedBox(height: height * 0.04),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: width * .55,
                        child: Text(
                          "  الرجاء اختيار المنطقة التي حدثت فيها القصة:",
                          style: TextStyle(
                              color: Color.fromARGB(174, 0, 0, 0),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'tajawal'),
                        )),
                    DropdownButton(
                        alignment: AlignmentDirectional.center,
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: dropdownItems),
                  ],
                ),
                Row(children: [
                  Text(
                    address != "" ? "($address)" : "",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const AddPinMapView())?.then((value) {
                        //كلاس اد بن ماب

                        setState(() {
                          address = value[0] ?? "";
                          coordinates = value[1];
                          //print(coordinates);
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff5F7858),
                        side: BorderSide(
                          color: Color(0xff5F7858),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_pin),
                        const Text("تحديد القصة على الخريطة"),
                      ],
                    ),
                  ),
                ]),

                //-----------------------------------------Terms and conditions checkbox--------------------
                SizedBox(height: height * 0.03),
                Row(
                  children: [
                    Checkbox(
                      value: agree,
                      activeColor: Color(0xffC17359),
                      onChanged: (value) {
                        setState(() {
                          agree = value;
                        });
                      },
                    ),
                    SizedBox(
                        width: width * .65,
                        child: Text(
                          "أقر وأتعهد بأن جميع محتويات القصة صحيحة من أحداث وشخصيات وتواريخ وأتحمل المسؤولية الكاملة إذا ثبت ما يخالف ذلك",
                          style: TextStyle(
                              color: Color.fromARGB(174, 0, 0, 0),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'tajawal'),
                          textAlign: TextAlign.right,
                        )),
                  ],
                ),

                //---------------------------publish button-------------------------------

                SizedBox(height: height * 0.022),
                FloatingActionButton.extended(
                  onPressed: () {
                    if (formKey.currentState!.validate() && address == "") {
                      Fluttertoast.showToast(msg: "الرجاء تحديد الموقع ");
                    } else {
                      if (agree == true) {
                        publishStory();
                        saveAddressToLocal();
                      }
                    }
                  },
                  heroTag: 'publish',
                  elevation: 4,
                  backgroundColor: Color(0xffC17359),
                  label: Text("نشر",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.bold)),
                )
              ], //column children
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("الرياض"), value: "الرياض"),
      DropdownMenuItem(child: Text("مكة المكرمة"), value: "مكة المكرمة"),
      DropdownMenuItem(
          child: Text("المدينة المنورة"), value: "المدينة المنورة"),
      DropdownMenuItem(child: Text("الشرقية"), value: "الشرقية"),
      DropdownMenuItem(child: Text("عسير"), value: "عسير"),
      DropdownMenuItem(child: Text("تبوك"), value: "تبوك"),
      DropdownMenuItem(child: Text("حائل"), value: "حائل"),
      DropdownMenuItem(
          child: Text("الحدود الشمالية"), value: "الحدود الشمالية"),
      DropdownMenuItem(child: Text("جازان"), value: "جازان"),
      DropdownMenuItem(child: Text("نجران"), value: "نجران"),
      DropdownMenuItem(child: Text("الباحة"), value: "الباحة"),
      DropdownMenuItem(child: Text("الجوف"), value: "الجوف"),
    ];
    return menuItems;
  }

  void writePage() {
    Navigator.pop(context);
  }

  void publishStory() async {
    // User? user = _auth.currentUser;

    // String? usrename = user?.displayName;
    await FirebaseFirestore.instance.collection("Stories").add({
      "Title": titleController.text,
      "Discreption": discreptionController.text,
      "Date": _selectedDate,
      "WriterUsername": TaleedApp.loggedInUser.username,
      "WriterId": TaleedApp.loggedInUser.userID,
      "WriterName": TaleedApp.loggedInUser.name,
      "Like": <String, bool>{}, //??
      "LikeCount": 0,
      "CommentCount": 0,
      "Content": scontent,
      "Region": selectedValue,
      "ARlink": "", //always empty its entered manually from firebase
      'latlng': "${coordinates?.latitude}-${coordinates?.longitude}",
    }).then((_) {
      print("collection created");
    }).catchError((_) {
      print("an error occured");
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navBar(),
        ));
  }
}
