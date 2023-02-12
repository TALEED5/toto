// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toto/TaleedApp.dart';
import 'package:toto/home.dart';
import 'editProfile.dart';
import 'welcomePage.dart';
import '../my_flutter_app_icons.dart';
import 'package:toto/myStories.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '';

class Wprofile extends StatefulWidget {
  const Wprofile({Key? key}) : super(key: key);

  @override
  State<Wprofile> createState() => _Wprofile();
}

class _Wprofile extends State<Wprofile> {
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
        backgroundColor: Colors.white, //Color(0xffE7E2D6),
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
                    ProfileInfoRow(),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class ProfileInfoRow extends StatefulWidget {
  @override
  State<ProfileInfoRow> createState() => ProfileInfoRowState();
}

class ProfileInfoRowState extends State<ProfileInfoRow> {
  late String myid = TaleedApp.loggedInUser.userID.toString();

  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      constraints: const BoxConstraints(maxWidth: 360),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_singleItem1(context), _singleItem2(context)],
      ),
    );
  }

  Widget _singleItem1(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => myStories(),
                    ));
              }, // here it navigates to the writers own story list
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
                child: Container(
                  //height: 100,
                  width: 140,
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(55, 187, 187, 187),
                        offset: Offset.zero,
                        blurRadius: 20.0,
                        spreadRadius: 10,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.auto_stories_rounded,
                        color: Color(0xff3D553F),
                        size: 60,
                      ),
                      SizedBox(height: 5),
                      Text(
                        getnum()
                            .toString(), //retrieve writers number of stories from db
                        style: TextStyle(
                            fontFamily: 'Tajawal', fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )),
        ],
      );

  void _numOfStories() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Stories')
        .where("WriterId", isEqualTo: myid)
        .get();
    setState(() {
      num = snapshot.size;
    });
    //numOfStories = qSnap.docs.length.toString();
  }

  int getnum() {
    _numOfStories();
    return num;
  }

  String getrank() {
    int a = getnum();
    if (a <= 5 && a >= 0)
      return "نجم ثريا";
    else if (a > 5 && a <= 10)
      return "نجم سهيل";
    else
      return "المجموعة الشمسية";
  }

  Widget _singleItem2(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
            child: Container(
              width: 140,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(55, 187, 187, 187),
                    offset: Offset.zero,
                    blurRadius: 20.0,
                    spreadRadius: 10,
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xffd7ab65),
                    size: 60,
                  ),
                  SizedBox(height: 5),
                  Text(
                    getrank(), //retrieve writers rank from db
                    style: TextStyle(
                        fontFamily: 'Tajawal', fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
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
                    //color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/userAvatar.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
