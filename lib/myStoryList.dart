import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toto/TaleedApp.dart';
import './readStory.dart';
import './story.dart';
import 'package:url_launcher/url_launcher.dart';

class myStoryList extends StatefulWidget {
  @override
  State<myStoryList> createState() => _myStoryListState();
}

class _myStoryListState extends State<myStoryList> {
  int numOfStories = 0;
  late String link = '';

  //   var user =  FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Stories')
            .where("WriterId", isEqualTo: TaleedApp.loggedInUser.userID)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(

                  ///s hrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (ctx, index) {
                    numOfStories++;
                    Story storylist = Story.fromJson(snapshot.data.docs[index]);
                    if (storylist.writerid == TaleedApp.loggedInUser.userID)
                      return Card(
                      //color: Color.fromRGBO(241, 239, 233, 1),
                      margin: const EdgeInsets.only(
                          left: 20, top: 6, right: 20, bottom: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    right: 20,
                                    left: 5,
                                    top: 7,
                                  ),
                                  child: const Icon(
                                    Icons.account_circle,
                                    color: Color.fromRGBO(95, 120, 88, 1),
                                    size: 30,
                                  ),
                                  // color: Color.fromRGBO(95, 120, 88, 1)
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: Text(
                                    storylist.writername,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(86, 63, 2, 1),
                                      fontFamily: "ElMessiri",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  alignment: Alignment.centerLeft,
                                 onPressed: (() {
                                    if (storylist.ARlink != '')
                                    link = '';
                                    link = storylist.ARlink;
                                    _launchURL();
                                  }),
                                    disabledColor: Colors
                                        .grey[600], //عجبني لكن مدري كيف استخدمه
                                    icon: Icon(Icons.api_rounded,
                                      color: storylist.ARlink == ''
                                          ? Colors.grey[600]
                                          : const Color.fromARGB(
                                              255, 184, 178, 110)),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color.fromRGBO(231, 226, 214, 1),
                            indent: 15,
                            endIndent: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //--------------------------title--------------------
                                Text(
                                  storylist.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ElMessiri",
                                  ),
                                ),
                                //---------------------------discreption-------------
                                Text(
                                  storylist.discreption,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "ElMessiri",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IntrinsicHeight(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Color.fromRGBO(154, 61, 33, 1),
                                          size: 19,
                                        ),
                                        Text(
                                          storylist.region,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'tajawal'),
                                        ),
                                        const VerticalDivider(
                                          color:
                                              Color.fromRGBO(231, 226, 214, 1),
                                        ),
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Color.fromRGBO(95, 120, 88, 1),
                                          size: 19,
                                        ),
                                        Text(
                                          DateFormat.y().format(storylist.date),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // const VerticalDivider(
                                        //   color:
                                        //       Color.fromRGBO(231, 226, 214, 1),
                                        // ),
                                        // const Icon(
                                        //   Icons.align_vertical_bottom_rounded,
                                        //   color: Color.fromRGBO(154, 61, 33, 1),
                                        // ),
                                        const VerticalDivider(
                                          color:
                                              Color.fromRGBO(231, 226, 214, 1),
                                        ),
                                        const Icon(
                                          Icons.favorite_rounded,
                                          color: Color.fromRGBO(154, 61, 33, 1),
                                          size: 19,
                                        ),
                                        Text(storylist.likecount.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ]),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReadStory(storylist),
                                            ));
                                      },
                                      child: const Text(
                                        "المزيد",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "ElMessiri",
                                          color: Color.fromRGBO(154, 61, 33, 1),
                                        ),
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ReadStory(storylist),
                                          ));
                                    },
                                    icon:
                                        const Icon(Icons.arrow_forward_rounded),
                                    color: const Color.fromRGBO(154, 61, 33, 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                    else
                      return Text("no stories yet");
                  });
            } else {
              return const Center(
                child: Text('nothing available'),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
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
