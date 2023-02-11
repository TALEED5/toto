import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'TaleedApp.dart';
import 'chatProvider.dart';
import 'chatRoomModel.dart';
import 'mainChatRooms.dart';
import 'messages_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required this.room,
      required this.fcmToken,
      required this.isFromDonation})
      : super(key: key);

  final ChatRoomModel room;
  final String fcmToken;
  final bool isFromDonation;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController? _controller;
  Stream<List<MessageModel>>? _stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _stream = ChatProvider().messagesStream(
        roomId: '${widget.room.senderId}-${widget.room.RecieverUserID}',
        isFromDonation: widget.isFromDonation);
  }

  @override
  Widget build(BuildContext context) {
    String nameUser = "";
    String userImg = "";

    try {
      if (widget.room.senderId == TaleedApp.loggedInUser.userID) {
        nameUser = widget.room.RecieverUsername!;
        userImg = widget.room.donationUserImg!;
      } else {
        nameUser = widget.room.senderName!;
        userImg = widget.room.senderImg!;
      }
    } catch (e) {
      print("eeee ${e}");
    }

    double heightTemp = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 244, 240),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 67, 63, 54),//Color(0XFFd7ab65),
            ),
            onPressed: () => Navigator.of(context).pop(),//Navigator.push(context, MaterialPageRoute(builder: (context) => MainChatRooms()))
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 50,
              ),
             
              Text(
                '${nameUser}',
                style: TextStyle(
                    color: Color.fromARGB(255, 67, 63, 54),//Color(0XFFd7ab65),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Tajawal'),
              ),
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width * 0.95,
              child: StreamBuilder<List<MessageModel>>(
                stream: _stream,
                builder: (c, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                      ),
                    );
                  }

                  List<MessageModel> messages = snap.data!;

                  if (messages != null) {
                    return Container(
                      height: heightTemp * .55,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (c, i) {
                          return messages[i].idForLastUser ==
                                  TaleedApp.loggedInUser.userID
                              ? MyMessageWidget(
                                  message: messages[i],
                                  myImg: widget.room.senderImg,
                                  myName: widget.room.senderName,
                                )
                              : DonationIdMessageWidget(
                                  message: messages[i],
                                  donationName: widget.room.RecieverUsername,
                                  donationImg: widget.room.donationUserImg,
                                );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          try {
                            if (DateFormat.yMMMd()
                                    .format(messages[index].dateTime!) !=
                                DateFormat.yMMMd()
                                    .format(messages[index - 1].dateTime!)) {
                              print("sss " + " ${messages[index].dateTime!}");
                              print("sssLast " +
                                  "${messages[index - 1].dateTime!}");
                              return buildContainerDate(messages, index);
                            } else {
                              return SizedBox();
                            }
                          } catch (e) {
                            print("eee $e");
                            if (e
                                .toString()
                                .contains("Not in inclusive range 0..1: -1")) {
                              return buildContainerDate(messages, index);
                            }
                            return SizedBox();
                          }
                        },
                      ),
                    );
                  }

                  ///Malas
                  return Container();
                },
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color(0XFFd7ab65), width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color(0XFFd7ab65), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color(0XFFd7ab65), width: 1.5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Color(0XFFd7ab65),
                          ),
                          onPressed: () {
                            // sendNotification
                            print("ddddd ${widget.fcmToken}");
                            // if(widget.fcmToken != null && widget.fcmToken != "null"){
                            //   String body = "" ;
                            //   if(widget.isFromDonation){
                            //     body = "لديك رسالة جديدة بخصوص التبرع" ;
                            //   } else{
                            //     body = "لديك رسالة جديدة" ;
                            //   }
                            //   YusrApp().sendNotification(
                            //       body:  body,
                            //       fcmToken: widget.fcmToken
                            //   );
                            // }

                            if (_controller!.text.isNotEmpty) {
                              if (widget.isFromDonation) {
                                ChatProvider().insertMessageDonationChat(
                                  message: MessageModel(
                                    message: _controller!.text,
                                    senderId: widget.room.senderId,
                                    RecieverUserID: widget.room.RecieverUserID,
                                    donationUserImg:
                                        widget.room.donationUserImg,
                                    RecieverUsername:
                                        widget.room.RecieverUsername,
                                    senderImg: widget.room.senderImg,
                                    senderName: widget.room.senderName,
                                    // isClient: true,
                                    readed: false,
                                  ),
                                  roomId:
                                      '${widget.room.senderId}-${widget.room.RecieverUserID}',
                                );
                              } else {
                                ChatProvider().insertMessageNormalChat(
                                  message: MessageModel(
                                    message: _controller!.text,
                                    senderId: widget.room.senderId,
                                    RecieverUserID: widget.room.RecieverUserID,
                                    donationUserImg:
                                        widget.room.donationUserImg,
                                    RecieverUsername:
                                        widget.room.RecieverUsername,
                                    senderImg: widget.room.senderImg,
                                    senderName: widget.room.senderName,
                                    // isClient: true,
                                    readed: false,
                                  ),
                                  roomId:
                                      '${widget.room.senderId}-${widget.room.RecieverUserID}',
                                  // roomId: '${widget.room.senderId}-${widget.room.donationId}',
                                );
                              }

                              // ChatProvider().sendNotifcation(
                              //   id: widget.room.techId,
                              //   isClient: true,
                              //   token: authProvider.tokenEntity.accessToken,
                              //   message: _controller.text,
                              // );
                            } else {}
                            _controller!.clear();
                          })),
                  controller: _controller,
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildContainerDate(List<MessageModel> messages, int index) {
    return Container(
      child: Center(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text(DateFormat.yMMMd().format(messages[index].dateTime!),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Tajawal',
                          fontSize: 14,
                        )),
              ))),
    );
  }
}

class MyMessageWidget extends StatelessWidget {
  final MessageModel? message;
  final String? myName;
  final String? myImg;

  const MyMessageWidget({Key? key, this.myImg, this.myName, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              getMessageClient(context),
              SizedBox(
                width: 5,
              ),
              Text(
                "${DateFormat.Hm().format(message!.dateTime!)}",
                maxLines: 20,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getMessageClient(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * .7,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(128, 239, 197, 99),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "${message!.message}",
          maxLines: 20,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class DonationIdMessageWidget extends StatelessWidget {
  final MessageModel? message;
  final String? donationName;
  final String? donationImg;

  const DonationIdMessageWidget(
      {Key? key, this.donationName, this.donationImg, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${DateFormat.Hm().format(message!.dateTime!)}",
                maxLines: 20,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              getMessageClient(context),
            ],
          ),
        ],
      ),
    );
  }

  Container getMessageClient(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * .7,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(128, 231, 220, 199),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "${message!.message}",
          maxLines: 20,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}