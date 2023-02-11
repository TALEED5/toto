// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:reader_profile_dummyversion/welcomePage.dart';

import '../my_flutter_app_icons.dart';
import 'TaleedApp.dart';
import 'editProfile.dart';
import 'welcomePage.dart';

class ReaderProfile extends StatefulWidget {
  const ReaderProfile({Key? key}) : super(key: key);

  @override
  ReaderProfileState createState() => ReaderProfileState();
}

class ReaderProfileState extends State<ReaderProfile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? myname = TaleedApp.loggedInUser.name;
  String? myUsername = TaleedApp.loggedInUser.username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color(0xffC17359),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        endDrawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,

          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffE7E2D6),
                  image: DecorationImage(
                      image: AssetImage("assets/images/stripes.png"),
                      fit: BoxFit.scaleDown),
                ),
                child: null //Text('الإعدادات'),
                ),
            ListTile(
              trailing: Icon(Icons.edit),
              title: const Text('تعديل الحساب',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'Tajawal', fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
            ),
            ListTile(
              trailing: Icon(Icons.logout),
              title: const Text('تسجيل خروج',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'Tajawal', fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const welcome()));
              },
            ),
          ],
        )),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg8.png"), fit: BoxFit.cover),
          ),
          child: Column(children: [
            const Expanded(flex: 2, child: _TopPortion()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    //----------here user name and name should  be retrieved from data base--------
                    Text(
                      myname!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    Text(
                      myUsername! + '@',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 58),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  colors: [Color(0xffC17359), Color(0xffC17359)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
            alignment: Alignment(0.0, -0.8),
            child: Text(
              "الملف الشخصي",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 25,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center,
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/userAvatar.png"),
                            ),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: CircleAvatar(
                //     radius: 20,
                //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                //     child: Container(
                //       margin: const EdgeInsets.all(8.0),
                //       decoration: const BoxDecoration(
                //           color: Colors.green, shape: BoxShape.circle),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
