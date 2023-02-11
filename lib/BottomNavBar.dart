// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:toto/writerHome.dart';
import 'package:toto/writerProfile.dart';
import 'mainChatRooms.dart';
import 'map_view.dart';

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBar();
}

class _navBar extends State<navBar> {
  int currentIndex =0;
  List <Widget> wpages = [writerHome(), MapView(),MainChatRooms(), Wprofile(),]; //[writerHome(), MapView(),search(), Wprofile(),];

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