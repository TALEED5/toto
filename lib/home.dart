//import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import './story.dart';
import 'package:intl/intl.dart';

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
        writer: "ثريا",
        like: 30),
    Story(
        title: 'story2',
        discreption: "taleed s2 dis",
        date: DateTime.now(),
        writer: "writer2",
        like: 5),
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
          //Row(
          //the title and go back icon
          // children: [
          /*Text("قصصي",
              textAlign: TextAlign.center,
              style: TextStyle(
                      fontFamily: "ElMessiri",
                      fontSize: 21.0,
                      color: Color.fromARGB(255, 34, 75, 12),
                      fontWeight: FontWeight.bold,
                    ),),*/
          IconButton(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 20),
            icon: Icon(Icons.arrow_forward),
            onPressed: (() {
              Navigator.pop(context);
            }),
            color: Color.fromRGBO(67, 60, 49, 1),
          ),
          //  ],
          // ),
          Column(
            children: stories.map((st) {
              return Card(
                margin: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
//icon: Icon(Icons.account_circle) for profile
//Icon(Icons.add_a_photo) api_rounded
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            alignment: Alignment.centerLeft,
                            onPressed: null,
                            disabledColor:
                                Colors.grey[600], //عجبني لكن مدري كيف استخدمه
                            icon: Icon(Icons.api_rounded,
                                color: Color.fromARGB(255, 184, 178, 110)),
                            // color: Color.fromRGBO(95, 120, 88, 1)
                            // padding: EdgeInsets.only(right:20,left:5,top:7,bottom: 7),
                          ),
                          Container(
                            //margin: EdgeInsets.only(left: 200),
                            padding: EdgeInsets.only(right: 7),
                            child: Text(
                              st.writer,
                              style: TextStyle(
                                color: Color.fromRGBO(86, 63, 2, 1),
                                fontFamily: "ElMessiri",
                                fontSize: 18,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              right: 20,
                              left: 5,
                              top: 7,
                            ),
                            child: Icon(
                              Icons.account_circle,
                              color: Color.fromRGBO(95, 120, 88, 1),
                              size: 30,
                            ),
                            // color: Color.fromRGBO(95, 120, 88, 1)
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(231, 226, 214, 1),
                      indent: 15,
                      endIndent: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            st.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ElMessiri",
                            ),
                          ),
                          Text(
                            st.discreption,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ElMessiri",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: null,
                              icon: Icon(Icons.arrow_back_rounded),
                              color: Color.fromRGBO(154, 61, 33, 1),
                            ),
                            TextButton(
                                onPressed: null,
                                child: Text(
                                  "المزيد",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ElMessiri",
                                    color: Color.fromRGBO(154, 61, 33, 1),
                                  ),
                                ))
                          ],
                        ),
                        IntrinsicHeight(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(st.like.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Icon(
                                  Icons.favorite_rounded,
                                  color: Color.fromRGBO(154, 61, 33, 1),
                                ),
                                VerticalDivider(
                                  color: Color.fromRGBO(231, 226, 214, 1),
                                  //indent: 15,
                                  //endIndent: 15,
                                ),
                                Icon(
                                  Icons.align_vertical_bottom_rounded,
                                  color: Color.fromRGBO(154, 61, 33, 1),
                                ),
                                VerticalDivider(
                                  color: Color.fromRGBO(231, 226, 214, 1),
                                  //indent: 15,
                                  //endIndent: 15,
                                ),
                                Text(
                                  DateFormat.yMMMd().format(st.date),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color.fromRGBO(95, 120, 88, 1),
                                ),
                                VerticalDivider(
                                  color: Color.fromRGBO(231, 226, 214, 1),
                                  //indent: 15,
                                  //endIndent: 15,
                                ),
                                /* Text(st.loc), */
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Color.fromRGBO(154, 61, 33, 1),
                                ),
                              ]),
                        )
                      ],
                    )
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
