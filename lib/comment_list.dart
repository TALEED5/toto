import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './comment.dart';

class comment_list extends StatelessWidget {
  String storyid;

  comment_list(this.storyid);

  @override
  Widget build(BuildContext context) {
    List colors = [
      Colors.deepOrangeAccent[300],
      Colors.blueGrey[800],
      Colors.teal[200],
      Colors.deepPurple[200]
    ];
    
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Stories")
            .doc(storyid)
            .collection("Comments")
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    Comment commentlist =
                        Comment.fromJson(snapshot.data.docs[index]);

                    return Card(
                      // color: Color.fromRGBO(231, 226, 216, 1),
                      color: Color.fromARGB(255, 167, 132, 62),

                      margin: EdgeInsets.only(
                          left: 20, top: 5, right: 20, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text("اسم المستخدم",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontFamily: "ElMessiri",
                                          fontSize: 14,
                                        )),
                                  ),
                                  Text("الاسم",
                                      style: TextStyle(
                                        fontFamily: "ElMessiri",
                                        fontSize: 15,
                                      )),
                                ]),
                                Text(
                                  "روعتييين",
                                  style: TextStyle(
                                    color: Colors.blueGrey[200],
                                    fontFamily: "ElMessiri",
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.account_circle,
                            color: colors[1], //from my list
                            size: 44,
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('nothing available'),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
