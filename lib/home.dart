import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:toto/Rprofile.dart';
//import 'package:toto/stl.dart';
import './story.dart';
//import './writerWriteStory.dart';
import './story_list.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _home();
}

class _home extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/housebg.png'), fit: BoxFit.cover),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
            //for the whole page
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: StoryList()),
            ]),
      ),
    ));
  }
}
