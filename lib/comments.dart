import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toto/TaleedApp.dart';
import './story.dart';
import 'assets.dart';
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
  String? myname = TaleedApp.loggedInUser.name;
  String? myusername = TaleedApp.loggedInUser.username;
  String? myid = TaleedApp.loggedInUser.userID;

  void addComment() async {
    //print(" print for asma");

    await FirebaseFirestore.instance
        .collection("Stories")
        .doc(widget.st.id)
        .collection("Comments")
        .add({
      "Comment": commentController.text,
      "Userid": myid,
      "Username": myusername,
      "Name": myname,
    }).then((_) {
      print("collection created");
    }).catchError((_) {
      print("an error occured");
    });
    commentController.clear();
    FirebaseFirestore.instance
        .collection("Stories")
        .doc(widget.st.id)
        .update({'CommentCount': widget.st.commentCount + 1});
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    //final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      //-----------------------------app bar-----------------------
      appBar: AppBar(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        title: Text(
          'التعليقات',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: "ElMessiri",
            color: Color(0xFF433C31),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.only(right: 20),
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: (() {
            Navigator.pop(context);
          }),
          color: Color.fromRGBO(67, 60, 49, 1),
        ),
      ),
      backgroundColor: Assets.shared.background1,//Color(0xFFf1efe9), //, Color.fromRGBO(231, 226, 216, 1), //temporarly
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(95, 120, 88, 1),
                    size: 36,
                  ),
                  SizedBox(width: 10),
                  Text(widget.st.writername,
                      style: TextStyle(
                        color: Color.fromRGBO(67, 60, 49, 1),
                        fontFamily: "ElMessiri",
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.end),
                  // VerticalDivider(
                  //   color: Color.fromRGBO(67, 60, 49, 1),
                  // ),
                  // Icon(
                  //   Icons.align_vertical_bottom_rounded,
                  //   color: Color.fromRGBO(154, 61, 33, 1),
                  // ),
                ],
              ),
            ),
            Container(
              height: height * .33,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                widget.st.content,
                maxLines: 12,
                style: TextStyle(
                  color: Color.fromRGBO(67, 60, 49, 1),
                  fontFamily: "ElMessiri",
                  fontSize: 18,
                ),
              ),
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
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: "إضافة تعليق...",
                    filled: true,
                    fillColor: Colors.white),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  if (commentController.text != '') addComment();
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(193, 115, 89, 1),
                    onSurface: Colors.grey),
                child: Text("إضافة"),
              ),
            ),
            SizedBox(height: 13,)
          ],
        ),
      ),
    );
  }
}
