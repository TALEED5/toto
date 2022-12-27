// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool obscure_text = true;

  Icon iconfirst = Icon(
    Icons.visibility_off,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    "تسجيل حساب جديد",
                    style: TextStyle(
                        fontSize: 33.0,
                        color: Color.fromARGB(255, 29, 22, 13),
                        fontWeight: FontWeight.bold,
                        fontFamily: "ElMessiri"),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  ),

                  //------------------------------الاسم---------------------------------------
                  SizedBox(
                    height: 3.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "الاسم",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ElMessiri",
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 34, 75, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  SizedBox(
                    height: 9.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "العمر",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ElMessiri",
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 34, 75, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                          Icons.calendar_month,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "العمر",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  //--------------------اسم المستخدم-----------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "اسم المستخدم",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ElMessiri",
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 34, 75, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "رقم الجوال",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ElMessiri",
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 34, 75, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "كلمة المرور",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ElMessiri",
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 34, 75, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                  ElevatedButton(
                    onPressed: createAccount,
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 40),
                        backgroundColor: Color(0xFFA03C1B),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        )),
                    child: Text(
                      "تسجيل ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri",
                          fontSize: 22.0,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //////////////////////////////////////// have an account
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateAccount(),
                                  ));
                            },
                            style: ButtonStyle(
                              alignment: Alignment.center,
                            ),
                            child: Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ElMessiri",
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          Text(
                            "لديك حساب؟",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "ElMessiri",
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
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

  void createAccount() {}
}
