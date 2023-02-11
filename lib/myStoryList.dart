import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './readStory.dart';
import './story.dart';

class myStoryList extends StatefulWidget {
  @override
  State<myStoryList> createState() => _myStoryListState();
}

class _myStoryListState extends State<myStoryList> {
  @override
  void initState() {
    _getdata();
  }
  

  String myid = '';
  int numOfStories = 0;

  void _getdata() async {
    final user = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      ///no need for setstate ارجعي شوفيه
      setState(() {
        myid = userData.id;
      });
    });
  }

  String getid() {
    _getdata();
    return myid;
  }

  

  //   var user =  FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Stories')
            .where("WriterId", isEqualTo: getid())
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
                    if (storylist.writerid == getid())
                      return Card(
                        margin: const EdgeInsets.only(
                            left: 20, top: 5, right: 20, bottom: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    alignment: Alignment.centerLeft,
                                    onPressed: /*storylist.ARlink==''?:هنا حطي رابط الويب */ null,
                                    disabledColor: Colors.grey[600],
                                    icon: Icon(Icons.api_rounded,
                                        color: storylist.ARlink == ''
                                            ? Colors.grey[600]
                                            : const Color.fromARGB(
                                                255, 184, 178, 110)),
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
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color.fromRGBO(231, 226, 214, 1),
                              indent: 15,
                              endIndent: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
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
                                          const Icon(Icons.arrow_back_rounded),
                                      color:
                                          const Color.fromRGBO(154, 61, 33, 1),
                                    ),
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
                                            color:
                                                Color.fromRGBO(154, 61, 33, 1),
                                          ),
                                        ))
                                  ],
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(storylist.likecount.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const Icon(
                                          Icons.favorite_rounded,
                                          color: Color.fromRGBO(154, 61, 33, 1),
                                        ),
                                        const VerticalDivider(
                                          color:
                                              Color.fromRGBO(231, 226, 214, 1),
                                        ),
                                        const Icon(
                                          Icons.align_vertical_bottom_rounded,
                                          color: Color.fromRGBO(154, 61, 33, 1),
                                        ),
                                        const VerticalDivider(
                                          color:
                                              Color.fromRGBO(231, 226, 214, 1),
                                        ),
                                        Text(
                                          DateFormat.y().format(storylist.date),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Color.fromRGBO(95, 120, 88, 1),
                                        ),
                                        const VerticalDivider(
                                          color:
                                              Color.fromRGBO(231, 226, 214, 1),
                                        ),
                                        Text(storylist.region),
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Color.fromRGBO(154, 61, 33, 1),
                                        ),
                                      ]),
                                )
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
}
