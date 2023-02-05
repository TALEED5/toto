import 'package:flutter/material.dart';
import './story.dart';
import './writerWriteStory.dart';
import './story_list.dart';
import 'myStoryList.dart';

class myStories extends StatelessWidget {
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
            child: Column(
                //for the whole page
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: myStoryList()),
                ]),
          ),
        ));
  }
}
