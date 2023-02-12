//import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  String id;
  late String title;
  //location loc;
  late int commentCount = 0;
  late String discreption;
  late int likecount;
  late Map likes;
  late DateTime date;
  late String writerid;
  late String writername;
  late String content;
  late String ARlink;
  late String region;
  late String writerUsername;

  Story(
      {required this.id,
      required this.title,
      required this.discreption,
      required this.date,
      required this.writername,
      required this.writerUsername,
      required this.writerid,
      required this.content,
      required this.ARlink,
      required this.region,
      required this.likes,
      required this.likecount,
      required this.commentCount});

  factory Story.fromJson(DocumentSnapshot snapshot) {
    return Story(
        id: snapshot.id,
        title: snapshot["Title"],
        discreption: snapshot["Discreption"],
        date: snapshot["Date"].toDate(),
        writername: snapshot["WriterName"],
        writerid: snapshot["WriterId"],
        content: snapshot["Content"],
        ARlink: snapshot["ARlink"],
        writerUsername: snapshot["WriterUsername"],
        region: snapshot["Region"],
        likes: snapshot["Like"],
        likecount: snapshot["LikeCount"],
        commentCount: snapshot["CommentCount"]);
    //WriterName:snapshot["WriterName"]);
  }
  updateLike(int a, Story st, String? id,bool tf) {
    FirebaseFirestore.instance
        .collection("Stories")
        .doc(st.id)
        .update({'Like.$id': tf, 'LikeCount': a});
  }

  
}
