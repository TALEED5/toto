import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class messageBubble extends StatelessWidget {
  //const messageBubble({Key? key}) : super(key: key);

  messageBubble(this.message,this.isMe,);
  final String message;
  final bool isMe;
  //final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe? Color(0xffE7B25C):Color(0xffF8EED7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe? Radius.circular(0):Radius.circular(12),
              bottomRight: isMe? Radius.circular(0):Radius.circular(12)
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(message, style: TextStyle(color: Color(0xff000000)),),
        ),
      ],
      
    );
    
    
  }

  // void appBarr(){
  //   AppBar(
  //     backgroundColor: Color(0xfffffefa),
  //     title: Text(username),
  //     centerTitle: true,
  //   );
  // }
}