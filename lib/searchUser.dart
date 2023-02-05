// ignore_for_file: unused_local_variable

//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toto/User.dart';
import 'TaleedApp.dart';
import 'chatProvider.dart';
import 'chatRoomModel.dart';
import 'chatView.dart';
import 'messages_model.dart';
import 'new_message.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);
  static var searchedUser;
  

  @override
  State<search> createState() => _search();
}

class _search extends State<search> {
  TextEditingController searchController = new TextEditingController();
  late QuerySnapshot searchResult;
  bool isLoading = false;
  bool haveUserSearched = false;
  //static late var searchedUser;
  var usersList = [];
  //var searchedUser;

  String name = "";
  String username = "";
  String uid = '';

  

  initiateSearch() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await getUserByUsername(searchController.text).then((snapshot) {
        searchResult = snapshot;

        searchResult.docs.forEach((element) {
          search.searchedUser = {"name": element["name"], "username": element["username"],"userID": element["userID"]};

          usersList.add(search.searchedUser);
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
        title: Text("البحث عن مستخدم"),
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
            onTap: () async{
              await ChatProvider()
                      .createChatRoom(
                    chatType: "NormalChat",
                    chatRoom: ChatRoomModel(
                      senderId: TaleedApp.loggedInUser.userID,
                      senderName: TaleedApp.loggedInUser.name,
                      isDonation: false,
                      donationUserName: user["name"],
                      donationUserId: user["userID"],
                      message: MessageModel(
                        message: '',
                        readed: false,
                      ),
                    ),
                  )
                      .then((v) async {
                    ChatRoomModel room;

                    room = ChatRoomModel(
                      senderId: TaleedApp.loggedInUser.userID,
                      senderName: TaleedApp.loggedInUser.name,
                      isDonation: false,
                      donationUserName: user["name"],
                      donationUserId: user["userID"],
                      message: MessageModel(
                        message: '',
                        readed: false,
                      ),
                    );

                    String fcmToken = await TaleedApp().getFCMUser(id: user["userID"]);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ChatScreen(
                                  room: room,
                                  isFromDonation: false,
                                  fcmToken: fcmToken,
                                )));
                  });
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
    return haveUserSearched
        ? ListView.builder(
            //shrinkWrap: true,
            itemCount: searchResult.docs.length,//2,
            itemBuilder: (BuildContext context, int index) {
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
 
}
