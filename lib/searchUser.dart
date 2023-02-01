// ignore_for_file: unused_local_variable

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toto/User.dart';
import 'package:toto/chat_screen.dart';

import 'new_message.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);
  
  static late var searchedUser;

  @override
  State<search> createState() => _search();
}

class _search extends State<search> {
  TextEditingController searchController = new TextEditingController();
  late QuerySnapshot searchResult;
  bool isLoading = false;
  bool haveUserSearched = false;
  static late var searchedUser;
  var usersList = [];
  

  initiateSearch() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await getUserByUsername(searchController.text).then((snapshot) {
        searchResult = snapshot;

        searchResult.docs.forEach((element) {
          searchedUser = {"name": element["name"], "username": element["username"],"userID": element["userID"]};

          usersList.add(searchedUser);
        });
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
      //userList();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search for user"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xfffffefa),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Color(0xFF9C9895)),
                    onSubmitted: (value) {
                      initiateSearch();
                    },
                    decoration: const InputDecoration(
                      hintText: "search by username",
                      hintStyle: TextStyle(color: Color(0xFF9C9895)),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF9C9895),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          haveUserSearched // TODO:
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    return userTile(usersList[index]);
                  })
              : Container()
        ],
      ),
    );
  }

  //-------methods and widgets-------
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
  }

  // Widget userTile(
  //   String name,
  // ) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //     child: Row(
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               name,
  //               style: TextStyle(color: Colors.white, fontSize: 16),
  //             ),
  //             // Text(
  //             //   username,
  //             //   style: TextStyle(
  //             //       color: Colors.white,
  //             //       fontSize: 16
  //             //   ),
  //             // )
  //           ],
  //         ),
  //         Spacer(),
  //         GestureDetector(
  //           onTap: () {
  //             //sendMessage(userName);
  //           },
  //           child: Container(
  //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //             decoration: BoxDecoration(
  //                 color: Colors.blue, borderRadius: BorderRadius.circular(24)),
  //             child: Text(
  //               "Message",
  //               style: TextStyle(color: Colors.white, fontSize: 16),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget userTile(user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user["name"],
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                user["username"],
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              existOrNot();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(user["name"]),//call chat screen and pass the other persons username as an argument
                ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: const Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget userList(users){
  //   return haveUserSearched ? ListView.builder(
  //     //shrinkWrap: true,
  //     itemCount: users.length, ///?
  //       itemBuilder: (BuildContext context, int index){
  //       return userTile(
  //         // searchResult.docs[index].data['name'], //the error here is in docs "The getter 'docs' isn't defined for the type 'Future<dynamic>' "
  //         // searchResult.docs[index].data["username"],
  //            users[index].data['name'],
  //            users[index].data["username"],
  //       );
  //       }) : Container();
  // }

  Widget userList() {
    print("before condition statement");
    return haveUserSearched
        ? ListView.builder(
            //shrinkWrap: true,
            itemCount: 2, //searchResult.docs.length,
            itemBuilder: (BuildContext context, int index) {
              print("after condition statement");
              String namee = searchResult.docs[index]["name"].toString();
              return userTile(namee
                  //searchResult.docs[index]["name"],
                  //searchResult.docs[index]["username"],
                  );
            })
        : Container(
            child: Text('test test'),
          );
  }
  var docid = 'filwah';
  var docid2 = 'document1';
  late var testdoc = {"degree":"bachelors", 'gradYear':2023, 'docid': docid2, 'name':'filly'};

   testdb() async {
    //DocumentReference<Map<String, dynamic>> obj = FirebaseFirestore.instance.collection('Chat').doc(docid2);
    var fbref = FirebaseFirestore.instance.collection('Chat');
    var document = await fbref.doc(docid2).get();
    if (document.exists) {
      print('dou name filwah match');
    }
    else{
      print('doc with that naame dosnt exist');
    }
    //obj.set(testdoc);
   // obj.collection('messages').add({'text':'hello2','timeStamp': Timestamp.now(), 'worked':'يارب'});
    
  }

  void existOrNot() async{
    final user = FirebaseAuth.instance.currentUser!;
    var dbRef = FirebaseFirestore.instance.collection('Chat');
    newMessage mesgobj = new newMessage();
    var document = await dbRef.doc(createRoomId(user.uid, search.searchedUser['userID'])).get();
    newMessage.roomExist = document.exists;
  }

  String createRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
