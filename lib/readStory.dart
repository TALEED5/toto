import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './comments.dart';
import './story.dart';

class ReadStory extends StatefulWidget {
  final Story st;

  ReadStory(this.st);

  @override
  State<ReadStory> createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover),
          ),
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.centerRight,
              child: IconButton(
                //alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 20),
                icon: Icon(Icons.arrow_forward),
                onPressed: (() {
                  Navigator.pop(context);
                }),
                color: Color.fromRGBO(67, 60, 49, 1),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            alignment: Alignment.centerLeft,
                            onPressed: null,
                            disabledColor:
                                Colors.grey[600], //عجبني لكن مدري كيف استخدمه
                            icon: Icon(Icons.api_rounded,
                                color: Color.fromARGB(255, 184, 178, 110)),
                          ),
                          Text(
                            widget.st.title,
                            style: TextStyle(
                                color: Color.fromRGBO(67, 60, 49, 1),
                                fontFamily: "ElMessiri",
                                fontSize: 24,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    width: width * .3,
                    margin: EdgeInsets.only(right: 20),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.align_vertical_bottom_rounded,
                            color: Color.fromRGBO(154, 61, 33, 1),
                          ),
                          VerticalDivider(
                            color: Color.fromRGBO(231, 226, 214, 1),
                          ),
                          Text(
                            widget.st.writer,
                            style: TextStyle(
                              color: Color.fromRGBO(67, 60, 49, 1),
                              fontFamily: "ElMessiri",
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(95, 120, 88, 1),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ])),
            SizedBox(
              height: height * .03,
            ),
            Flexible(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Color.fromRGBO(249, 242, 237, 1),
                ),
                child: Stack(children: [
                  Container(
                    height: height * .62,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.st.content,
                      style: TextStyle(
                        color: Color.fromRGBO(67, 60, 49, 1),
                        fontFamily: "ElMessiri",
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                        color: Color.fromARGB(255, 174, 169, 157),
                        thickness: 1.5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            label: Text(widget.st.like.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(67, 60, 49, 1),
                                )),
                            onPressed: () {
                              setState(() {
                                like = !like;
                                if (like)
                                  widget.st.likeStory();
                                else
                                  widget.st.removeLike();
                              });
                            },
                            icon: Icon(
                              (like)
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_rounded,
                              color: Color.fromRGBO(154, 61, 33, 1),
                            ),
                          ),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => comments(widget.st),
                                    ));
                              },
                              icon: Icon(
                                Icons.chat,
                                color: Color.fromRGBO(67, 60, 49, 1),
                              ),
                              label: Text(widget.st.comments.length.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(83, 63, 2, 1),
                                  ))),
                          Row(children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Color.fromRGBO(95, 120, 88, 1),
                            ),
                            Text(DateFormat.y().format(widget.st.date),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(67, 60, 49, 1),
                                ))
                          ]),
                          Icon(
                            Icons.location_on_outlined,
                            color: Color.fromRGBO(154, 61, 33, 1),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
              ),
            ),
          ]),
        ));
  }
}
