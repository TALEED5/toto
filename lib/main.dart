import 'package:flutter/material.dart';
import './forgetpassword.dart';
//import 'package:intl/intl.dart';
import './CreateAccount.dart';
import './home.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool obscure_text = true;
  Icon iconfirst = Icon(
    Icons.visibility_off,
    color: Color.fromARGB(255, 255, 255, 255),
  );
  // void initState() {
  //   dateinput.text = ""; //set the initial value of text field
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/housebg.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  SizedBox(
                    height: height * .05,
                  ),
                  Text(
                    "تسجيل دخول",
                    style: TextStyle(
                      fontSize: 37.0,
                      color: Color.fromARGB(255, 29, 22, 13),
                      fontWeight: FontWeight.bold,
                      fontFamily: "ElMessiri",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  ),
                  SizedBox(height: height * .05),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "البريد الألكتروني",
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
                          Icons.email_outlined,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "البريد الالكتروني",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
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
                  Container(
                    alignment: Alignment.topLeft,
                    width: 280,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => forgetpass(),
                            ));
                      },
                      style: ButtonStyle(
                        alignment: Alignment.topLeft,
                      ),
                      child: Text(
                        " نسيت كلمة المرور",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "ElMessiri",
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                  ),
                  //-------------------------------------the button--------------------
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home(),
                          ));
                    },
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
                      "تسجيل دخول",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri",
                          fontSize: 22.0,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //----------------------dont have account---------------
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
                            "تسجيل جديد",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "ElMessiri",
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        Text(
                          "ليس لديك حساب؟",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "ElMessiri",
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ]))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {}
}
