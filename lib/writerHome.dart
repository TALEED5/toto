//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import './story.dart';
import './writerWriteStory.dart';
import './story_list.dart';
import 'assets.dart';

class writerHome extends StatefulWidget {
  @override
  State<writerHome> createState() => _Writerhome();
}

class _Writerhome extends State<writerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Text("القصص",
              style: TextStyle(
                  color: Color(0xFF433F36), //Color(0XFFd7ab65),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Tajawal')),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(239, 235, 229, 1),

        //backgroundColor: Assets.shared.background1,

        //---------------------add story button-------------------------
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Color.fromRGBO(95, 120, 88, 1),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => writeStory1(),
                ));
          },
        ),
        body: Container(
          //color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage('assets/images/housebg.png'),
              //     fit: BoxFit.cover),
              ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: StoryList()),
                ]),
          ),
        ));
  }
}
