import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toto/User.dart';

class Comment {
  String comnt;
  String userid;
  String name;
  String username;
  Comment({
    required this.comnt,
    required this.userid,
    required this.username,
    required this.name
  });

  factory Comment.fromJson(DocumentSnapshot snapshot) {
    return Comment(
      comnt: snapshot["Comment"],
      userid: snapshot["Userid"],
      username: snapshot["Username"],
      name: snapshot["Name"],

      
    );
  }
}
