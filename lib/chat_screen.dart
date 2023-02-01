import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toto/messages.dart';
import 'package:toto/new_message.dart';

class ChatScreen extends StatelessWidget{
  final user = FirebaseAuth.instance.currentUser!;
  final String chatWithName;
  ChatScreen(this.chatWithName);
  //final userData = FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(chatWithName), centerTitle: true,),

      body: Container(
        child: 
        Column(
          children: <Widget>[
             Expanded(
               child: messages()),
              newMessage(),
          ],
        ) ,),
       
    );
  }
}