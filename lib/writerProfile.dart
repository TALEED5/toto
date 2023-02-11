import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'editProfile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:toto/myStories.dart';
import 'welcomePage.dart';
import '../my_flutter_app_icons.dart';

class Wprofile extends StatefulWidget {
  const Wprofile({Key? key}) : super(key: key);

  @override
  State<Wprofile> createState() => _Wprofile();
}

class _Wprofile extends State<Wprofile> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color(0xffC17359),
          elevation: 0,
        ),
        backgroundColor: Color(0xffE7E2D6),
        endDrawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,

          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffE7E2D6),
                  image: DecorationImage(
                      image: AssetImage("Assets/stripes.png"),
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
                image: AssetImage("Assets/b1_bg.PNG"), fit: BoxFit.cover),
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
                      "اسم المستخدم",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text("@userName"),
                    //const SizedBox(height: 90),
                    //-------------------------------------------------------------------------------

                    const SizedBox(height: 16),
                    _ProfileInfoRow(),
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

class _ProfileInfoRow extends StatefulWidget {
  @override
  State<_ProfileInfoRow> createState() => _ProfileInfoRowState();
}

class _ProfileInfoRowState extends State<_ProfileInfoRow> {
  late String myid = '';


  int num = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement initState

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
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.auto_stories_rounded,
                  color: Color(0xff8E5541),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => myStories(),
                      ));
                },
              )),
          Text(
            getnum(), //retrieve writers number of stories from db
            style:
                TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.w600),
          )
        ],
      );

  void _getdata() async {
    final user = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      ///no need for setstate ارجعي شوفيه
      // _numOfStories();
      setState(() {
        myid = userData.id;
      });
    });
  }

  String getid() {
    _getdata();
    //print(myid);
    return myid;
  }

  void _numOfStories() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Stories')
        .where("WriterId", isEqualTo: getid())
        .get();
    num = snapshot.size;
    //numOfStories = qSnap.docs.length.toString();
  }

  String getnum() {
    _numOfStories();
    return num.toString();
  }
}

Widget _singleItem2(BuildContext context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              MyFlutterApp.podium,
              color: Color(0xff8E5541),
              size: 40,
            )),
        Text(
          "نجم سهيل", //retrieve writers rank from db
          style: TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.w600),
        )
      ],
    );

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
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/727/727393.png?w=1380&t=st=1670965308~exp=1670965908~hmac=d9ce5f3b247a3430e05ea0a0d16a3ea094ea82681921eac9c585fa847df8c685')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
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
