//import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  late String title;
  //location loc;
  late List<String> comments = ['wow', 'amazing'];
  late String discreption;
  late int like = 9;
  late DateTime date;
  late String writer;
  late String content;

  Story(
      {required this.title,
      required this.discreption,
      required this.date,
      required this.writer,
      required this.content});

  factory Story.fromJson(DocumentSnapshot snapshot) {
    return Story(
        title: snapshot["Title"],
        discreption: snapshot["Discreption"],
        date: snapshot["Date"].toDate(),
        writer: snapshot["Writer"],
        content: snapshot["Content"]);
  }

  Future likeStory() async {
try{


}catch(e){
  print("Catch like story");
}
    // like++;
  }

  void removeLike() {
    like--;
  }

  void locateOrigin() {}
  void readStory() {}
  void viewLoc() {}

  //ARrepresentation interactiveWAR(){}
}
