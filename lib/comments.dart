import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './story.dart';
import 'comment_list.dart';

class comments extends StatefulWidget {
  final Story st;
  comments(this.st);

  @override
  State<comments> createState() => _commentsState();
}

class _commentsState extends State<comments> {
  //bool contentEmpty = true;
  String comment = '';
  final formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();

  // BuildComments() {
  //   return Text("data");
  // }

  void addComment() async {
    final _auth = FirebaseAuth.instance;

    User? user = _auth.currentUser;

    String? usrename = user?.displayName;

    await FirebaseFirestore.instance
        .collection("Stories")
        .doc(widget.st.id)
        .collection("Comments")
        .add({
      "Comment": commentController.text,
      "Username": "اسم المستخدم",
      "Name": "الاسم"
    }).then((_) {
      print("collection created");
    }).catchError((_) {
      print("an error occured");
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    //final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      ///----------------------------navigation bar-----------------
      // bottomNavigationBar: Container(
      //   height: height * .09,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(15), topLeft: Radius.circular(20)),
      //     color: Colors.white,
      //   ),
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         ElevatedButton(
      //           onPressed: () {
      //             // final isValid = formKey.currentState.validate();
      //           },
      //           style: ElevatedButton.styleFrom(
      //               backgroundColor: Color.fromRGBO(193, 115, 89, 1),
      //               disabledBackgroundColor: Colors.grey),
      //           child: Text("إضافة"),
      //         ),
      //         Container(
      //           child: Expanded(
      //             child: Form(
      //               key: formKey,
      //               child: TextFormField(
      //                 onChanged: (value) => setState(() {
      //                   comment = value;
      //                 }),
      //                 controller: commentController,
      //                 decoration: InputDecoration(
      //                   hintTextDirection: TextDirection.rtl,
      //                   floatingLabelAlignment:
      //                       FloatingLabelAlignment.start,
      //                   hintText: "إضافة تعليق..",
      //                   fillColor: Color.fromRGBO(245, 245, 245, .93),
      //                 ),
      //                 validator: ((value) {
      //                   if (value != null && value.isNotEmpty) cont = true;
      //                 }),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ]),
      // ),

      // Container(
      //   height: height * .09,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(15), topLeft: Radius.circular(20)),
      //     color: Colors.white,
      //   ),
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         //if (cont)
      //       },
      //       style: ElevatedButton.styleFrom(
      //           backgroundColor: Color.fromRGBO(193, 115, 89, 1),
      //           disabledBackgroundColor: Colors.grey),
      //       child: Text("إضافة"),
      //     ),

      //     // TextFormField(
      //     //     controller: commentController,
      //     //     style: TextStyle(
      //     //       fontSize: 24,
      //     //       color: Colors.blue,
      //     //       fontWeight: FontWeight.w600,
      //     //     ),
      //     //     decoration: InputDecoration(
      //     //       hintText: "Email/Mobile",
      //     //       labelText: 'Email/Mobile',
      //     //       fillColor: Colors.grey,
      //     //     )),

      //     // Container(
      //     //   child: TextFormField(
      //     //     controller: commentController,
      //     //     decoration: InputDecoration(
      //     //       labelText: "إضافة تعليق..",
      //     //       fillColor: Color.fromRGBO(245, 245, 245, .93),
      //     //     ),
      //     //     validator: ((value) {
      //     //       if (value != null && value.isNotEmpty) cont = true;
      //     //     }),
      //     //   ),
      //     // ),
      //   ]),
      // ),
      //-----------------------------app bar-----------------------
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'التعليقات',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "ElMessiri",
            color: Color.fromRGBO(67, 60, 49, 1),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: Icon(Icons.arrow_forward),
            onPressed: (() {
              Navigator.pop(context);
            }),
            color: Color.fromRGBO(67, 60, 49, 1),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(231, 226, 216, 1), //temporarly
      //----------------------------body-------------------------------
      body: Container(
        alignment: Alignment.centerRight,
        height: double.infinity,
        width: double.infinity,
        //width: width * .4,
        margin: EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height * .05,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.align_vertical_bottom_rounded,
                    color: Color.fromRGBO(154, 61, 33, 1),
                  ),
                  VerticalDivider(
                    color: Color.fromRGBO(67, 60, 49, 1),
                  ),
                  Text(widget.st.writer,
                      style: TextStyle(
                        color: Color.fromRGBO(67, 60, 49, 1),
                        fontFamily: "ElMessiri",
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.end),
                  Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(95, 120, 88, 1),
                    size: 36,
                  ),
                ],
              ),
            ),
            Container(
              height: height * .33,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(widget.st.content,
                  maxLines: 12,
                  style: TextStyle(
                    color: Color.fromRGBO(67, 60, 49, 1),
                    fontFamily: "ElMessiri",
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.end),
            ),
            Divider(
              color: Color.fromARGB(255, 174, 169, 157),
              thickness: 1.5,
              indent: 15,
              endIndent: 15,
            ),
            Expanded(flex: 1, child: comment_list(widget.st.id)),
            ListTile(
              title: TextFormField(
                controller: commentController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(hintText: "...إضافة تعليق"),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  if (commentController.text != '') addComment();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(193, 115, 89, 1),
                    disabledBackgroundColor: Colors.grey),
                child: Text("إضافة"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String comment;
  final String userId;
  //final Timestamp timestamp;

  List colors = [
    Colors.deepOrangeAccent[300],
    Colors.blueGrey[800],
    Colors.teal[200],
    Colors.deepPurple[200]
  ];

  Comment(
      {required this.username, required this.comment, required this.userId});

//factory Comment.fromDocument( DocumentSnapshot doc){
// return Comment(
// username:doc['username'],
// userId: doc ['userId'],
// comment: doc ['comment']
// )
//}

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
