// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toto/CreateAccount.dart';

import 'assets.dart';
import 'login.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcome();
}

class _welcome extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        // constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcomebg5.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  // Image.asset(
                  //   'assets/images/totoo.png',
                  //   width: width * .5,
                  //   height: height * .3,
                  // ),
                  // Image.asset(
                  //   'assets/images/slogan.png',
                  //   width: width * 3,
                  //   height: height * .1,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 380,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(280, 40),
                  primary: Color(0xFFB36248),
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  )),
              child: Text(
                " تسجيل الدخول ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "ElMessiri",
                    fontSize: 22.0,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccount(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(280, 40),
                  primary: Color(0xFFA03C1B), //A03C1B
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  )),
              child: Text(
                " تسجيل حساب جديد ",
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
    );
  }
}
