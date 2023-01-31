import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String comnt;
  String username;
  String name;
  Comment({
    required this.comnt,
    required this.name,
    required this.username,
  });

  factory Comment.fromJson(DocumentSnapshot snapshot) {
    return Comment(
      comnt: snapshot["Comment"],
      username: snapshot["Username"],
      name: snapshot["Name"],
    );
    //WriterName:snapshot["WriterName"]);
  }
}
