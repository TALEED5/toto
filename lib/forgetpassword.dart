import 'package:flutter/material.dart';
//import './main.dart';

class forgetpass extends StatefulWidget {
  @override
  _forgetpassState createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
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
                children: [
                  Text(
                    "  نسيت كلمة المرور",
                    style: TextStyle(
                        fontSize: 37.0,
                        color: Color.fromARGB(255, 29, 22, 13),
                        fontWeight: FontWeight.bold,
                        fontFamily: "ElMessiri"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  ),
                  Space(25.0),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "رقم الجوال",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ElMessiri",
                        fontSize: 21.0,
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
                  Space(250.0),
                  ElevatedButton(
                    onPressed: forgetPass,
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
                      "استمرار",
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
Widget Space(double px) {
    return SizedBox(
      height: px,
    );
  }
  void forgetPass() {}
}
