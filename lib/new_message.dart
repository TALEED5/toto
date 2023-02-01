// ignore_for_file: unused_element, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toto/searchUser.dart';

class newMessage extends StatefulWidget {
  const newMessage({Key? key}) : super(key: key);
  static late bool roomExist;

  @override
  State<newMessage> createState() => _newMessage();
}

class _newMessage extends State<newMessage> {
  final _controller =
      new TextEditingController(); //to clear the text field after sending the message
  var _enterdMessage = '';
  var roomID;
  var currentUserName;
  bool roomExist = newMessage.roomExist;
  var dbRef = FirebaseFirestore.instance.collection('Chat');
  final user = FirebaseAuth.instance.currentUser!;

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser!;
    //final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chats').add({
      'text': _enterdMessage,
      'timeStamp': Timestamp.now(),
      'userId': user.uid,
      // 'username': userData['username'],
    });
    _controller.clear();
  }

  String _getCurrentName() {
    //FocusScope.of(context).unfocus();
    //final user = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots().listen((userData){
      currentUserName = userData.data()!['name'];
    });
    return currentUserName;
    // roomID = createRoomId(user.uid, search.searchedUser['userID']);
    // var document = await dbRef.doc(roomID).get();
    // //roomExist = document.exists;

    // _controller.clear();
  }

  void notFirstTime (){
    FocusScope.of(context).unfocus();

    //if roomId exist before(its not the first time) --> just add to DB the messages and timestamp
      DocumentReference<Map<String, dynamic>> docObj = dbRef.doc(roomID);
      docObj.collection('messages').add({
        'text': _enterdMessage,
        'timeStamp': Timestamp.now(),
      });
    
    _controller.clear();

  }

  void firstTime(){
    DocumentReference<Map<String, dynamic>> docObj = dbRef.doc(roomID);
      var fieldsSet = {
        "roomID": roomID,
        "user1ID": user.uid,
        "user2ID": search.searchedUser['userID'],
        "user1name": _getCurrentName(),
        "user2name": search.searchedUser['name'],
      };
      //add fields into roomId doc
      docObj.set(fieldsSet);

      //add text into collection messages
      docObj.collection('messages').add({
        'text': _enterdMessage,
        'timeStamp': Timestamp.now(),
      });
      _controller.clear();

  }

  // String createRoomId(String a, String b) {
  //   if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
  //     return "$b\_$a";
  //   } else {
  //     return "$a\_$b";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _enterdMessage = value;
              });
            },
          )),
          IconButton(
              //onPressed: _enterdMessage.trim().isEmpty ? null : _sendMessage,
              onPressed: (){
                if(_enterdMessage.trim().isEmpty == true){
                  return null;
                }
                else{
                  if(roomExist==true){
                    notFirstTime();
                  }else{
                    if(roomExist==false){
                    firstTime();
                  }
                  }
                }
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
