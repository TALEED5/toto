//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toto/messageBubble.dart';

import 'chat_screen.dart';

class messages extends StatelessWidget {
  messages({Key? key}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<User>(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (context, futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
      }
           return StreamBuilder <QuerySnapshot>(
      stream: firestore.collection('chats').orderBy('timeStamp', descending: true).snapshots(),
      builder:(ctx, chatSnapshot){
      if(chatSnapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      final chatdocs = chatSnapshot.data!.docs;
      
      //i think here is where we check if they have the same roomid or not
      return ListView.builder(
        reverse: true,
        itemCount: chatdocs.length, 
        itemBuilder: (ctx, index) => messageBubble(
          chatdocs[index]['text'],
          chatdocs[index]['userId'] == futureSnapshot.data!.uid, //this is the error- udemy 335 minute 7:26
          //chatdocs[index]['username'],
          ),
          
        
        );
        }
        );
    } );
  }
}