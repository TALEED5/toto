import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toto/TaleedApp.dart';
import 'package:url_launcher/url_launcher.dart';
import './comments.dart';
import './story.dart';
import 'assets.dart';

class ReadStory extends StatefulWidget {
  final Story st;

  ReadStory(this.st);

  @override
  State<ReadStory> createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {
  String? myid = TaleedApp.loggedInUser.userID;
  bool like = false;
  int numlikes = 0;
  bool isliked = false;
  late String link = '';

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Assets.shared.background1,
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Stories')
                .doc(widget.st.id)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //if (snapshot.data.docs.length > 0) {
                // return ListView.builder(
                // itemCount: snapshot.data.docs.length,
                // itemBuilder: (ctx, index) {
                Story storylist = Story.fromJson(snapshot.data);
                numlikes = storylist.likecount;

                return Container(
                  decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage('assets/images/background.png'),
                      //     fit: BoxFit.cover),
                      ),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        //alignment: Alignment.topRight,
                        padding: EdgeInsets.only(right: 20),
                        icon: Icon(Icons.arrow_back_rounded),
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        color: Color.fromRGBO(67, 60, 49, 1),
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    SizedBox(
                        height: height * .15,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: SingleChildScrollView(
                                    ///teeeeeest
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.st.title,
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(67, 60, 49, 1),
                                              fontFamily: "ElMessiri",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        IconButton(
                                          alignment: Alignment.centerLeft,
                                          onPressed: (() {
                                            if (storylist.ARlink != '')
                                              link = '';
                                            link = storylist.ARlink;
                                            _launchURL();
                                          }),
                                          disabledColor: Colors.grey[
                                              600], //عجبني لكن مدري كيف استخدمه
                                          icon: Icon(Icons.api_rounded,
                                              color: storylist.ARlink == ''
                                                  ? Colors.grey[600]
                                                  : const Color.fromARGB(
                                                      255, 184, 178, 110)),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                //alignment: Alignment.centerRight,
                                // width: width * .3,
                                // margin: EdgeInsets.only(right: 20),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 20),
                                      Icon(
                                        Icons.account_circle,
                                        color: Color.fromRGBO(95, 120, 88, 1),
                                        size: 35,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.st.writername,
                                        style: TextStyle(
                                          color: Color.fromRGBO(67, 60, 49, 1),
                                          fontFamily: "ElMessiri",
                                          fontSize: 20,
                                        ),
                                      ),
                                      // VerticalDivider(
                                      //   color: Color.fromRGBO(231, 226, 214, 1),
                                      // ),
                                      // Icon(
                                      //   Icons.align_vertical_bottom_rounded,
                                      //   color: Color.fromRGBO(154, 61, 33, 1),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                    SizedBox(
                      height: height * .03,
                    ),
                    Flexible(
                      child: Material(
                        elevation: 15,
                        borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                topLeft: Radius.circular(35)),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                topLeft: Radius.circular(35)),
                            color: Colors
                                .white, //Color.fromRGBO(249, 242, 237, 1),
                          ),
                          child: Stack(children: [
                            Container(
                              height: height * .62,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    widget.st.content,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color.fromRGBO(67, 60, 49, 1),
                                      fontFamily: "ElMessiri",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Divider(
                                  color: Color.fromARGB(255, 211, 208, 201),
                                  thickness: 1.5,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton.icon(
                                      label: Text(numlikes.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(67, 60, 49, 1),
                                          )),
                                      onPressed: () {
                                        setState(() {
                                          //like = !like;
                                          // if (like)
                                          handleLikeStory();
                                          // else
                                          //  handleLikeStory();
                                        });
                                      },
                                      icon: Icon(
                                        (storylist.likes[myid] == false ||
                                                storylist.likes[myid] == null)
                                            ? Icons.favorite_outline_rounded
                                            : Icons.favorite_rounded,
                                        color: Color.fromRGBO(154, 61, 33, 1),
                                      ),
                                    ),
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    comments(widget.st),
                                              ));
                                        },
                                        icon: Icon(
                                          Icons.chat,
                                          color: Color.fromRGBO(67, 60, 49, 1),
                                        ),
                                        label: Text(
                                            widget.st.commentCount.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromRGBO(83, 63, 2, 1),
                                            ))),
                                    Row(children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromRGBO(95, 120, 88, 1),
                                      ),
                                      Text(
                                          DateFormat.y().format(widget.st.date),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(67, 60, 49, 1),
                                          ))
                                    ]),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Color.fromRGBO(154, 61, 33, 1),
                                        ),
                                        Text(
                                          storylist.region,
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(67, 60, 49, 1),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'tajawal'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15,), 
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ]),
                );

                // } else {
                //   return Center(
                //     child: Text('nothing available'),
                //   );
                // }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  handleLikeStory() {
    if (widget.st.likes[myid] != null) {
      isliked = widget.st.likes[myid] == true;

      if (isliked) {
        setState(() {
          widget.st.updateLike(widget.st.likecount - 1, widget.st, myid, false);
          isliked = false;
          numlikes -= 1;
          //widget.st.likes[getid()] = false;
        });
      } else if (!isliked) {
        setState(() {
          widget.st.updateLike(widget.st.likecount + 1, widget.st, myid, true);
          isliked = true;
          numlikes += 1;
          //widget.st.likes[getid()] = false;
        });
      }
    } else
      setState(() {
        widget.st.updateLike(widget.st.likecount + 1, widget.st,
            TaleedApp.loggedInUser.userID, true);
        isliked = true;
        numlikes += 1;
        //widget.st.likes[getid()] = false;
      });
  }

  _launchURL() async {
    // final uri = Uri.parse(link);
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
