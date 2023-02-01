// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter/src/widgets/form.dart';
import 'package:intl/intl.dart';
import 'package:toto/BottomNavBar.dart';
import 'dart:ui' as ui;

import './writerWriteStory.dart';
import 'add_pin_map_view.dart';
import 'firebase_operations.dart';
import 'writerHome.dart';

class StoryInfo extends StatefulWidget {
  final String scontent;
  final Function funct;
  const StoryInfo({required this.scontent, required this.funct});
  //const StoryInfo({Key? key}) : super(key: key);

  @override
  State<StoryInfo> createState() => _StoryInfo(scontent: scontent, funct: funct);
}

class _StoryInfo extends State<StoryInfo> {
  _StoryInfo({required this.scontent, required this.funct});
  String address = "";
  LatLng? coordinates;
  String scontent;
  Function funct;
  final formKey = GlobalKey<FormState>(); //key for form
  bool? agree = false;
  bool field1 = false;
  bool field2 = false;
  late DateTime _selectedDate;
  final titleController = TextEditingController();
  final discreptionController = TextEditingController();
  TextEditingController dateinput = TextEditingController();


  void saveAddressToLocal() {
    //GetStorage box = GetStorage();
    saveLocationToFire("${coordinates?.latitude}-${coordinates?.longitude}");
  }

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
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

    return Scaffold(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => writerHome()),
                );
              }, icon: Icon(Icons.clear), color: Colors.white)
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
          physics: const NeverScrollableScrollPhysics(),
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
                  ///child: Container(
                  ///height: 100,
                  //padding:const EdgeInsets.all(10.0),
                  ///padding:const EdgeInsets.only(top: 3, right: 11, left: 11, bottom: 3),
                  ///decoration: BoxDecoration(
                  //color: Color(0xffF6F6F6),
                  ///color: Colors.white,
                  //border: Border.all(color: Color(0xff5F7858)),
                  ///borderRadius: BorderRadius.circular(30),),

                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: TextFormField(
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
                      controller:
                          dateinput, //editing controller of this TextField
                      textAlign: TextAlign.right,
                      //cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "تاريخ وقوع القصة",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ), //label text of field
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                          onTap: _presentDatePicker,
                      // onTap: () async {
                      //   DateTime? pickedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(
                      //           2000), //DateTime.now() - not to allow to choose before today.
                      //       lastDate: DateTime(2101));

                      //   if (pickedDate != null) {
                      //     print(
                      //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      //     String formattedDate =
                      //         DateFormat('yyyy-MM-dd').format(pickedDate);
                      //     print(
                      //         formattedDate); //formatted date output using intl package =>  2021-03-16
                      //     //you can implement different kind of Date Format here according to your requirement

                      //     setState(() {
                      //       dateinput.text =
                      //           formattedDate; //set output date to TextField value.
                      //     });
                      //   } else {
                      //     print("Date is not selected");
                      //   }
                      // },
                    ),
                  ),
                ),

                //-----------------------------تحديد القصة على الخريطة-------------------------
                SizedBox(height: height * 0.04),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                        const Text("تحديد القصة على الخريطة"),
                        Icon(Icons.location_pin),
                        Text(
                          address != "" ? "($address)" : "",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ]),

                //-----------------------------------------Terms and conditions checkbox--------------------
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: 290,
                        child: Text(
                          "أقر وأتعهد بأن جميع محتويات القصة صحيحة من أحداث وشخصيات وتواريخ وأتحمل المسؤولية الكاملة إذا ثبت ما يخالف ذلك",
                          textAlign: TextAlign.right,
                        )),
                    Checkbox(
                      value: agree,
                      activeColor: Color(0xffC17359),
                      onChanged: (value) {
                        setState(() {
                          agree = value;
                        });
                      },
                    ),
                  ],
                ),

                //---------------------------publish button-------------------------------

                SizedBox(height: height * 0.022),
                FloatingActionButton.extended(
                  onPressed: () {
                    if (address == "") {
                      Fluttertoast.showToast(msg: "الرجاء اختيار العنوان");
                    } else {
                      saveAddressToLocal();
                    }
                    if (agree == true) {
                      publishStory();
                        //method that publish the story and navigate to home page
                      }
                    // if (formKey.currentState!.validate()) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Processing Data')),
                    //   ); 
                    // }
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

  void writePage() {
    Navigator.pop(context);
  }

  void publishStory() async {
    await FirebaseFirestore.instance.collection("Stories").add({
      "Title": titleController.text,
      "Discreption": discreptionController.text,
      "Date": _selectedDate,
      "Writer": "the wtiter name", //ادور طريقة اوصل بها المستخدم الحالي
      "Like": 0,
      "Content": scontent
    }).then((_) {
      print("collection created");
    }).catchError((_) {
      print("an error occured");
    });
    // widget.funct(
    //   title: enteredTitle,
    //   discreption: entereddiscreprion,
    //   date: _selectedDate,
    //   content: scontent,
    // );

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navBar(),
        ));
  }
}
