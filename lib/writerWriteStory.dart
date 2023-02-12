// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toto/TaleedApp.dart';
import 'BottomNavBar.dart';
import 'storyInfo.dart';

class writeStory1 extends StatefulWidget {
  @override
  _writeStory1 createState() => _writeStory1();
}

class _writeStory1 extends State<writeStory1> {
  final storyController = TextEditingController();
  bool btnActive = false;

  //late String sconinput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7E2D6),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .miniEndDocked, /////howwwwww to minimize the button and put it on the right!!!

      //------------------app bar----------------------------------------------
      appBar: AppBar(
          backgroundColor: const Color(0xff5F7858),
          title: const Text(
            "كتابة قصة",
            style:
                TextStyle(fontFamily: 'tajawal', fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(builder: (context) => navBar()),
                    (route) => false);
              },
              icon: Icon(Icons.clear),
              color: Colors.white)),

      //---------------------navigation bar-----------------------------
      floatingActionButton:
          // color: const Color(0xffF6F6F6),
          // height: 56,

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          // ),
          FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            if (btnActive == true) {
              infoPage();
            }
          });
        },
        heroTag: 'next',
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 201, 167, 139),
        label: Text("التالي",
            style: TextStyle(
                color: Colors.brown,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold)),
        icon: Icon(Icons.arrow_right, color: Colors.brown),
      ),

      //-------------------------------body-----------------------------------------------
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/727/727393.png?w=1380&t=st=1670965308~exp=1670965908~hmac=d9ce5f3b247a3430e05ea0a0d16a3ea094ea82681921eac9c585fa847df8c685'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      TaleedApp.loggedInUser.name.toString(),
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      TaleedApp.loggedInUser.username.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Divider(
                height: 4.0,
                color: Color.fromARGB(255, 197, 197, 197),
                thickness: 2.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                height: 448.0,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: storyController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  minLines: 1,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "ما القصة التي تريد نشرها؟",
                    hintStyle: TextStyle(
                      color: Color(0xFF909A99),
                    ),
                  ),
                  onChanged: (value) {
                    //يشوف اذا اليوزر كتب قصة او لا
                    setState(() {
                      if (value.isNotEmpty) {
                        btnActive = true;
                      }
                    });
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void infoPage() {
    //navigate to story information page
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StoryInfo(
                scontent: storyController.text,
              )),
    );
  } //infopage method

}
