import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:toto/map_view.dart';
import 'package:toto/searchUser.dart';
import 'package:toto/writerHome.dart';
import 'package:toto/writerWriteStory.dart';

import 'Rprofile.dart';
import 'chat_screen.dart';
import 'home.dart';

class readerNavBar extends StatefulWidget {
  const readerNavBar({Key? key}) : super(key: key);

  @override
  State<readerNavBar> createState() => _readerNavBar();
}

class _readerNavBar extends State<readerNavBar> {
  int currentIndex =0;
  List <Widget> wpages = [home(), MapView()]; //[home(), MapView(),search(), ReaderProfile(),]

  void navigateTo(int index){
    setState(() {
      currentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wpages[currentIndex],

      bottomNavigationBar: Container(

        color: Colors.white,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
         child: GNav(
          selectedIndex: currentIndex,
          onTabChange:navigateTo,
        backgroundColor: Colors.white,
        tabBackgroundColor: Color(0xffe5e5e5),
        padding: EdgeInsets.all(16),
        gap: 8,
        tabs: [
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
    );
  }
}