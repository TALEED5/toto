import 'package:flutter/material.dart';
import 'package:toto/utils/utils/assets.dart';

//import '../../utils/assets.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * (100 / 375),
            height: MediaQuery.of(context).size.width * (100 / 375),
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: CircularProgressIndicator(
              color: Assets.shared.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
