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
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/housebg.PNG"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/totoo.png',
                    height: height * .2,
                    width: width * .3,
                  ),
                  Image.asset(
                    'assets/images/slogan.png',
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
                        backgroundColor: Assets.shared.RedColor,
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
                        backgroundColor: Assets.shared.RedColor,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        )),
                    child: Text(
                      "تسجيل جديد",
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
          ],
        ),
      ),
    );
  }
}
