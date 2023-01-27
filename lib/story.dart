//import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  String id;
  late String title;
  //location loc;
  late List<String> comments = ['wow', 'amazing'];
  late String discreption;
  late int like = 0;
  late DateTime date;
  late String writer;
  late String content;
  // late String writerId;
  //late String WriterName;

  Story({
    required this.id,
    required this.title,
    required this.discreption,
    required this.date,
    required this.writer,
    //required this.writerId,
    required this.content,
    //required this.WriterName
  });

  factory Story.fromJson(DocumentSnapshot snapshot) {
    return Story(
      id: snapshot.id,
      title: snapshot["Title"],
      discreption: snapshot["Discreption"],
      date: snapshot["Date"].toDate(),
      writer: snapshot["Writer"],
      //writerId: snapshot["WriterId"],
      content: snapshot["Content"],
    );
    //WriterName:snapshot["WriterName"]);
  }

  void likeStory() {
    like++;
  }

  void removeLike() {
    like--;
  }

  // Future likeStory(Story s) async {
  //   int l = s.like;
  //   try {
  //     await FirebaseFirestore.instance.collection("Stories").doc().update({
  //       "Like": l++,
  //     });
  //   } catch (e) {
  //     print("Catch like story");
  //   }
  //   // like++;
  // }

  // Future removeLike(Story s) async {
  //   int l = s.like;
  //   try {
  //     await FirebaseFirestore.instance.collection("Stories").doc().update({
  //       "Like": l--,
  //     });
  //   } catch (e) {
  //     print("Catch like story");
  //   }
  //   // like++;
  // }

  void locateOrigin() {}
  void readStory() {}
  void viewLoc() {}

  //ARrepresentation interactiveWAR(){}
}
