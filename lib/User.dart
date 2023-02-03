//import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String name;
  late String username;
  late String age;
  late String userId;
  late String email;

  User({
    required this.name,
    required this.username,
    required this.age,
    required this.userId,
    required this.email
  });
  factory User.fromJson(DocumentSnapshot snapshot) {
    return User(
      name: snapshot["name"],
      username: snapshot["username"],
      age: snapshot["age"],
      userId:snapshot.id,
      email: snapshot["email"]


    );
    //WriterName:snapshot["WriterName"]);
  }
}
