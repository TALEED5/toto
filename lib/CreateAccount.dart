// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool obscure_text = true;
  TextEditingController dateinput = TextEditingController();
  Icon iconfirst = Icon(
    Icons.visibility_off,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Color.fromARGB(33, 0, 0, 0),
        //Color.fromARGB(255, 255, 253, 244),
        //backgroundColor: Color.fromARGB(255, 146, 130, 63),
        body:
            //SafeArea(
            Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/housebg.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "تسجيل حساب جديد",
                    style: TextStyle(
                        fontSize: 37.0,
                        color: Color.fromARGB(255, 29, 22, 13),
                        fontWeight: FontWeight.bold,
                        fontFamily: "ElMessiri"),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  ),
                  //------------------------------الاسم---------------------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    //مربع الاسم
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "الاسم",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                    ),
                  ),
                  //------------------------
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                  Container(
                    //SizedBox(
                    //      height: 15.0,
                    //   ),
                    //  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),

                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
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
                        hintText: "تاريخ الميلاد",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ), //label text of field
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  //--------------------اسم المستخدم-----------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.account_box,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "اسم المستخدم",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                    ),
                  ),
                  //------------------------------رقم الجوال-----------------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "رقم الجوال",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  //-------------------------------كلمة المرور------------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      obscureText: obscure_text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF90B28D),
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (obscure_text == true) {
                                obscure_text = false;
                                iconfirst = Icon(
                                  Icons.visibility,
                                  color: Color(0xFF90B28D),
                                );
                              } else {
                                obscure_text = true;
                                iconfirst = Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey.shade300,
                                );
                              }
                            });
                          },
                          child: iconfirst,
                        ),
                        hintText: "كلمة المرور",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                  ),
                  Container(
                    //------------------------مربع التسجيل----------------------
                    width: 280.0,
                    height: 40.0,

                    decoration: BoxDecoration(
                      color: Color(0xFFA03C1B),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      "تسجيل",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri",
                          fontSize: 22.0,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
