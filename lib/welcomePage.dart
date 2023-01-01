// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcome();
}

class _welcome extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container( 
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Assets/housebg2.png"), 
                  fit: BoxFit.cover),
  ),
  child: Stack(
    children: [
      Center(
        child: Column(
          children: [
            Image.asset('Assets/totoo.png', width: 200, height: 360,),
            Image.asset('Assets/slogan.png', width: 500, height: 360,),
          ],
        ),
      ),
    ],
  ),
     ),
      );
    
  }
}