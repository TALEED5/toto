import 'package:flutter/material.dart';
import './story.dart';
import './writerWriteStory.dart';
import './story_list.dart';

class writerHome extends StatefulWidget {
  @override
  State<writerHome> createState() => _Writerhome();
}

class _Writerhome extends State<writerHome> {
  // final List<Story> _stories = [
  //   Story(
  //       title: 'toto',
  //       discreption: "taleed life",
  //       date: DateTime.now(),
  //       WriterName: "ثريا",
  //       content: ""
  //       // like: 30
  //       ),
  //   Story(
  //       title: 'story2',
  //       discreption: "taleed s2 dis",
  //       date: DateTime.now(),
  //       writer: "writer2",
  //       content: ""
  //       // like: 5
  //       ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE7E2D6),
          elevation: 0,
          title: Text(
            "قصصي",
            style: TextStyle(
                color: Color.fromRGBO(86, 63, 2, 1),
                fontFamily: "ElMessiri",
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 20),
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
              onPressed: (() {
                Navigator.pop(context);
              }),
              color: Color.fromRGBO(67, 60, 49, 1),
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/housebg.png'),
                fit: BoxFit.cover),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                  //for the whole page
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   StoryList(),
                  ]),
            ),
          ),
        ));
  }
}
