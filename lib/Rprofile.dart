// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:reader_profile_dummyversion/welcomePage.dart';

import '../my_flutter_app_icons.dart';
import 'welcomePage.dart';

class ReaderProfile extends StatefulWidget {
  const ReaderProfile({Key? key}) : super(key: key);

  @override
  ReaderProfileState createState() =>ReaderProfileState();
}

class ReaderProfileState extends State <ReaderProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffC17359),
        elevation: 0,
      ),
      backgroundColor: Color(0xffE7E2D6),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
         child: GNav(
        backgroundColor: Colors.white,
        tabBackgroundColor: Color(0xffe5e5e5),
        padding: EdgeInsets.all(16),
        gap: 8,
        tabs: const[
          GButton(icon: Icons.home, text: '   ',
          ),
           GButton(icon: Icons.location_pin,text: '   ',
          ),
           GButton(icon: Icons.chat_outlined, text:'   ',
          ),
           GButton(icon: Icons.person,text: '   ',
          ),
        ],
      )
      ),
      ),

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffE7E2D6),
                image: DecorationImage(image: AssetImage("Assets/stripes.png"),
                fit: BoxFit.scaleDown),
                
              ), 
              child: null //Text('الإعدادات'),
            ),
            ListTile(
              trailing: Icon(Icons.edit),
              title: const Text('تعديل الحساب', textAlign: TextAlign.right,style: TextStyle(fontFamily:'Tajawal', fontWeight: FontWeight.bold)),
              onTap: (){},
            ),
            ListTile(
              trailing: Icon(Icons.logout),
              title: const Text('تسجيل خروج',textAlign: TextAlign.right,style: TextStyle(fontFamily:'Tajawal', fontWeight: FontWeight.bold)),
              onTap: (){
                Navigator.push(
                     context,
                         MaterialPageRoute(builder: (context) => const welcome()));
              },
            ),
          ],
        )
      ),
      
       body:  Container( 
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Assets/b1_bg.PNG"), 
                  fit: BoxFit.cover),
  ),
        child: Column(
        children: [
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
                    style:  Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text("@userName"),
                  const SizedBox(height: 90),
                  //-------------------------------------------------------------------------------

                 //-----------------------logout and editAccount as buttons -------------------------
                  //Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //children: [
                      //FloatingActionButton.extended(
                        //onPressed: () {},
                        //heroTag: 'editProfile',
                        //elevation: 0,
                        //backgroundColor: Color(0xffF8EED7),
                        //label: const Text("تعديل الحساب",style: TextStyle(color: Colors.brown, fontFamily:'Tajawal')),
                        //icon: const Icon(Icons.edit, color: Colors.brown),
                      //),
                      //const SizedBox(height: 10),
                      //FloatingActionButton.extended(
                        //onPressed: () {},
                        //heroTag: 'logOut',
                        //elevation: 0,
                        //backgroundColor: Color(0xffF8EED7),
                        //label: const Text("تسجيل الخروج",style: TextStyle(color: Colors.brown, fontFamily:'Tajawal')),
                        //icon: const Icon(Icons.logout, color: Colors.brown),
                      //),
                    //],
                  //),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ]
       ),
       )

    );
   
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
          child: Text("الملف الشخصي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900,fontSize: 25, fontFamily:'Tajawal', ),textAlign: TextAlign.center,)
        ),
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

