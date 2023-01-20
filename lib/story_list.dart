import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './readStory.dart';
import './story.dart';

class StoryList extends StatelessWidget {
  final List<Story> stories;

  StoryList(this.stories);
  CollectionReference storyRef =
      FirebaseFirestore.instance.collection('stories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: storyRef.snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              Future<List<DocumentSnapshot>> documents =
                  getStoriesFromFirebase();
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              } else if (!snapshot.hasData) {
                return Text("no data");
              } else {
                // return ListView.builder(
                //   itemBuilder: (ctx, index) {
                //     return Card(
                //       margin:
                //           EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.stretch,
                //         children: <Widget>[
                //           Container(
                //             width: double.infinity,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: [
                //                 IconButton(
                //                   alignment: Alignment.centerLeft,
                //                   onPressed: null,
                //                   // disabledColor:
                //                   //     Colors.grey[600], //عجبني لكن مدري كيف استخدمه
                //                   icon: Icon(Icons.api_rounded,
                //                       color: Color.fromARGB(255, 184, 178, 110)),
                //                 ),
                //                 Container(
                //                   padding: EdgeInsets.only(right: 7),
                //                   child: Text(
                //                     stories[index].writer,
                //                     style: TextStyle(
                //                       color: Color.fromRGBO(86, 63, 2, 1),
                //                       fontFamily: "ElMessiri",
                //                       fontSize: 18,
                //                     ),
                //                   ),
                //                 ),
                //                 Container(
                //                   padding: EdgeInsets.only(
                //                     right: 20,
                //                     left: 5,
                //                     top: 7,
                //                   ),
                //                   child: Icon(
                //                     Icons.account_circle,
                //                     color: Color.fromRGBO(95, 120, 88, 1),
                //                     size: 30,
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           Divider(
                //             color: Color.fromRGBO(231, 226, 214, 1),
                //             indent: 15,
                //             endIndent: 15,
                //           ),
                //           Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 20),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.end,
                //               children: <Widget>[
                //                 //--------------------------title--------------------
                //                 Text(
                //                   stories[index].title,
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                     fontFamily: "ElMessiri",
                //                   ),
                //                 ),
                //                 //---------------------------discreption-------------
                //                 Text(
                //                   stories[index].discreption,
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                     fontFamily: "ElMessiri",
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           //-------------------------------icons---------------------
                //           Padding(
                //             padding: const EdgeInsets.only(
                //               right: 10,
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: [
                //                 Flexible(
                //                   fit: FlexFit.tight,
                //                   child: TextButton.icon(
                //                     icon: Icon(
                //                       Icons.arrow_back_rounded,
                //                       color: Color.fromRGBO(154, 61, 33, 1),
                //                     ),
                //                     onPressed: () {
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                             builder: (context) =>
                //                                 ReadStory(stories[index]),
                //                           ));
                //                     },
                //                     label: Text(
                //                       "المزيد",
                //                       style: TextStyle(
                //                         fontSize: 14,
                //                         fontWeight: FontWeight.bold,
                //                         fontFamily: "ElMessiri",
                //                         color: Color.fromRGBO(154, 61, 33, 1),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 IntrinsicHeight(
                //                   child: Row(
                //                       mainAxisAlignment: MainAxisAlignment.end,
                //                       children: [
                //                         Text(stories[index].like.toString(),
                //                             style: TextStyle(
                //                               fontWeight: FontWeight.bold,
                //                             )),
                //                         Icon(
                //                           Icons.favorite_rounded,
                //                           color: Color.fromRGBO(154, 61, 33, 1),
                //                         ),
                //                         VerticalDivider(
                //                           color: Color.fromRGBO(231, 226, 214, 1),
                //                         ),
                //                         Icon(
                //                           Icons.align_vertical_bottom_rounded,
                //                           color: Color.fromRGBO(154, 61, 33, 1),
                //                         ),
                //                         VerticalDivider(
                //                           color: Color.fromRGBO(231, 226, 214, 1),
                //                         ),
                //                         Text(
                //                           DateFormat.yMMMd()
                //                               .format(stories[index].date),
                //                           style: TextStyle(
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         Icon(
                //                           Icons.calendar_month_outlined,
                //                           color: Color.fromRGBO(95, 120, 88, 1),
                //                         ),
                //                         VerticalDivider(
                //                           color: Color.fromRGBO(231, 226, 214, 1),
                //                         ),
                //                         // Text(st.loc),
                //                         IconButton(
                //                           icon: Icon(Icons.location_on_outlined),
                //                           onPressed: () {},
                //                           color: Color.fromRGBO(154, 61, 33, 1),
                //                         ),
                //                       ]),
                //                 )
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //     );
                //   },
                //   itemCount: stories.length,
                // );
                //final docs = snapshot.data!.docs;
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (ctx, index) {
                          // children: snapshot.data.document.map[(document) {
                          return Card(
                            margin: EdgeInsets.only(
                                left: 20, top: 5, right: 20, bottom: 5),
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
                                        disabledColor: Colors.grey[
                                            600], //عجبني لكن مدري كيف استخدمه
                                        icon: Icon(Icons.api_rounded,
                                            color: Color.fromARGB(
                                                255, 184, 178, 110)),
                                        // color: Color.fromRGBO(95, 120, 88, 1)
                                        // padding: EdgeInsets.only(right:20,left:5,top:7,bottom: 7),
                                      ),
                                      Container(
                                        //margin: EdgeInsets.only(left: 200),
                                        padding: EdgeInsets.only(right: 7),
                                        child: Text(
                                          snapshot.data.docs[index]['Writer'],
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
                                      //--------------------------title--------------------
                                      Text(
                                        snapshot.data.docs['Title'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "ElMessiri",
                                        ),
                                      ),
                                      //---------------------------discreption-------------
                                      Text(
                                        snapshot.data.docs['Discreption'],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                                color: Color.fromRGBO(
                                                    154, 61, 33, 1),
                                              ),
                                            ))
                                      ],
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                snapshot.data.docs['Like']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Icon(
                                              Icons.favorite_rounded,
                                              color: Color.fromRGBO(
                                                  154, 61, 33, 1),
                                            ),
                                            VerticalDivider(
                                              color: Color.fromRGBO(
                                                  231, 226, 214, 1),
                                              //indent: 15,
                                              //endIndent: 15,
                                            ),
                                            Icon(
                                              Icons
                                                  .align_vertical_bottom_rounded,
                                              color: Color.fromRGBO(
                                                  154, 61, 33, 1),
                                            ),
                                            VerticalDivider(
                                              color: Color.fromRGBO(
                                                  231, 226, 214, 1),
                                              //indent: 15,
                                              //endIndent: 15,
                                            ),
                                            Text(
                                              DateFormat.yMMMd().format(
                                                  snapshot.data.docs['Date']),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              color: Color.fromRGBO(
                                                  95, 120, 88, 1),
                                            ),
                                            VerticalDivider(
                                              color: Color.fromRGBO(
                                                  231, 226, 214, 1),
                                              //indent: 15,
                                              //endIndent: 15,
                                            ),
                                            /* Text(st.loc), */
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Color.fromRGBO(
                                                  154, 61, 33, 1),
                                            ),
                                          ]),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
                    : Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<DocumentSnapshot>> getStoriesFromFirebase() async {
    final QuerySnapshot result = await storyRef.get();
    final List<DocumentSnapshot> documents = result.docs;
    print(documents);
    // List<String> myList = [];
    // for (var snapshot in documents) {
    //   myList.add(snapshot.get("Title"));
    //   print(snapshot.get("Title"));
    // }
    return documents;
  }
}
