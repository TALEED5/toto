import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/housebg.png'),
                  fit: BoxFit.cover),
            ),
            child: Center()));
  }
}
