import 'package:flutter/cupertino.dart';

class UserModel {
  late String? name;
  late String? username;
  late String? age;
  late String? userID;
  late String? fcmToken;

  UserModel({
    this.name,
     this.username,
     this.age,
     this.userID,
     this.fcmToken,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'],
      username: map['username'],
      age: map['age'],
      userID: map['userID'],
      fcmToken: map['fcmToken'],
    );
  }
}