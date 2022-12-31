//import 'package:flutter/foundation.dart';

class Story {
  late String title;
  //location loc;
  late List<String> comments;
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

  void likeStory() {}
  void locateOrigin() {}
  void readStory() {}
  void viewLoc() {}
  //ARrepresentation interactiveWAR(){}
}
