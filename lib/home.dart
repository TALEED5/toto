//import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import './story.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _home();
}

class _home extends State<home> {
  final List<Story> stories = [
    Story(
        title: 'toto',
        discreption: "taleed life",
        date: DateTime.now(),
        writer: "taleed members"),
    Story(
        title: 'story2',
        discreption: "taleed s2 dis",
        date: DateTime.now(),
        writer: "writer2"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/housebg.png'), fit: BoxFit.cover),
      ),
      child: Column(
        //for the whole page
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            //the title and go back icon
            children: [
              /*Text("قصصي",
              textAlign: TextAlign.center,
              style: TextStyle(
                      fontFamily: "ElMessiri",
                      fontSize: 21.0,
                      color: Color.fromARGB(255, 34, 75, 12),
                      fontWeight: FontWeight.bold,
                    ),),*/
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: (() {
                  Navigator.pop(context);
                }),
                color: Color(0xFF90B28D),
              )
            ],
          ),
          Column(
            children: stories.map((st) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        st.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          st.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          st.date.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ));
  }
}
