import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './comment.dart';

class comment_list extends StatelessWidget {
  String storyid;

  comment_list(this.storyid);
  late String username;
  late String name;

//   void getuserinfo (String userid) async{
// var document=await FirebaseFirestore.instance.doc('Users/'+userid);
// document.get => then((document) {
//     name=document("name");
//     username=doocument("username");
// });
//   }

  @override
  Widget build(BuildContext context) {
    List colors = [
      Colors.blueGrey[800],
      Colors.deepOrangeAccent[300],
      Color.fromARGB(255, 86, 134, 129),
      Color.fromARGB(255, 110, 81, 164)
    ];
    int i = 0;

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
                    // if (i > 2)
                    //   i = 0;
                    // else
                    //   i++;
                    Comment commentlist =
                        Comment.fromJson(snapshot.data.docs[index]);

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0.4,
                      color: Colors.white, //Color.fromRGBO(231, 226, 216, 1),
                      margin: EdgeInsets.only(
                          left: 20, top: 3, right: 20, bottom: 3),
                    
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 4,),
                          Icon(
                            Icons.account_circle,
                            color: colors[i], //from my list
                            size: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(commentlist.name,
                                      style: TextStyle(
                                          fontFamily: "ElMessiri",
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(commentlist.username + "@",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontFamily: "ElMessiri",
                                          fontSize: 13,
                                        )),
                                  ),
                                ]),
                                Text(
                                  commentlist.comnt,
                                  style: TextStyle(
                                    color: Color(
                                        0xFF433C31), //Colors.blueGrey[500],
                                    fontFamily: "ElMessiri",
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4,)
                              ],
                            ),
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
