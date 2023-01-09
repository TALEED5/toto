import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './readStory.dart';
import './story.dart';

class StoryList extends StatelessWidget {
  final List<Story> stories;

  StoryList(this.stories);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: null,
                        // disabledColor:
                        //     Colors.grey[600], //عجبني لكن مدري كيف استخدمه
                        icon: Icon(Icons.api_rounded,
                            color: Color.fromARGB(255, 184, 178, 110)),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 7),
                        child: Text(
                          stories[index].writer,
                          style: TextStyle(
                            color: Color.fromRGBO(86, 63, 2, 1),
                            fontFamily: "ElMessiri",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 20,
                          left: 5,
                          top: 7,
                        ),
                        child: Icon(
                          Icons.account_circle,
                          color: Color.fromRGBO(95, 120, 88, 1),
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(231, 226, 214, 1),
                  indent: 15,
                  endIndent: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      //--------------------------title--------------------
                      Text(
                        stories[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri",
                        ),
                      ),
                      //---------------------------discreption-------------
                      Text(
                        stories[index].discreption,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri",
                        ),
                      ),
                    ],
                  ),
                ),
                //-------------------------------icons---------------------
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: TextButton.icon(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Color.fromRGBO(154, 61, 33, 1),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReadStory(stories[index]),
                                ));
                          },
                          label: Text(
                            "المزيد",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ElMessiri",
                              color: Color.fromRGBO(154, 61, 33, 1),
                            ),
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(stories[index].like.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.favorite_rounded,
                                color: Color.fromRGBO(154, 61, 33, 1),
                              ),
                              VerticalDivider(
                                color: Color.fromRGBO(231, 226, 214, 1),
                              ),
                              Icon(
                                Icons.align_vertical_bottom_rounded,
                                color: Color.fromRGBO(154, 61, 33, 1),
                              ),
                              VerticalDivider(
                                color: Color.fromRGBO(231, 226, 214, 1),
                              ),
                              Text(
                                DateFormat.yMMMd().format(stories[index].date),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Color.fromRGBO(95, 120, 88, 1),
                              ),
                              VerticalDivider(
                                color: Color.fromRGBO(231, 226, 214, 1),
                              ),
                              // Text(st.loc),
                              IconButton(
                                icon: Icon(Icons.location_on_outlined),
                                onPressed: () {},
                                color: Color.fromRGBO(154, 61, 33, 1),
                              ),
                            ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: stories.length,
      ),
    );
  }
}
