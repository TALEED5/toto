import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toto/searchUser.dart';
import 'TaleedApp.dart';
import 'chatProvider.dart';
import 'chatRoomModel.dart';
import 'chatView.dart';

class MainChatRooms extends StatefulWidget {
  const MainChatRooms({Key? key}) : super(key: key);

  @override
  State<MainChatRooms> createState() => _MainChatRoomsState();
}

class _MainChatRoomsState extends State<MainChatRooms> {
  bool flag = false;
  int count = -1;
  int requestsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
           IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0XFFd7ab65),
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => search()));
              },
            ),
          
        ],
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0XFFd7ab65),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            textAlign: TextAlign.center,
            'المحادثات',
            style: TextStyle(
                color: Color(0XFFd7ab65),
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontFamily: 'Tajawal'),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: StreamBuilder<List<dynamic>>(
                      stream: readRequests(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                            return getChatRoomItem(snapshot, false);
                          
                        } else if (snapshot.hasError) {
                          return Text(
                              "Some thing went wrong! ${snapshot.error}");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView getChatRoomItem(
      AsyncSnapshot<List<dynamic>> snapshot, bool isFromDonation) {
    final chatRooms = snapshot.data!;
    count = chatRooms.length;

    return ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          ChatRoomModel chatRoom = chatRooms[index];

          String nameUser = "";
          String nameId = "";
          String userImg = "";

          try {
            if (chatRoom.senderId == TaleedApp.loggedInUser.userID) {
              nameUser = chatRoom.donationUserName!;
              nameId = chatRoom.donationUserId!;
              userImg = chatRoom.donationUserImg!;
            } else {
              nameUser = chatRoom.senderName!;
              nameId = chatRoom.senderId!;
              userImg = chatRoom.senderImg!;
            }
          } catch (e) {
            print("eeee ${e}");
          }

          String date = "";
          try {
            DateTime dataBase = chatRoom.message!.dateTime!;
            DateTime dataNow = DateTime.now();
            if (dataBase.year == dataNow.year &&
                dataBase.month == dataNow.month &&
                dataBase.day == dataNow.day) {
              date = DateFormat.Hm().format(chatRoom.message!.dateTime!);
            } else if (dataBase.year == dataNow.year &&
                dataBase.month == dataNow.month &&
                dataBase.day == dataNow.subtract(const Duration(days: 1)).day) {
              date = "الأمس";
            } else {
              date = DateFormat.yMd().format(chatRoom.message!.dateTime!);
            }

            //
          } catch (e) {
            date = "اليوم";
          }

          return InkWell(
            onTap: () async {
              
                await ChatProvider().markMessageAsReaded(
                    roomId: '${chatRoom.senderId}-${chatRoom.donationUserId}',
                    messageId: "${chatRoom.message?.messageId}",
                    chatType: "NormalChat");
              

              String fcmToken = await TaleedApp().getFCMUser(id: nameId);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ChatScreen(
                            room: chatRoom,
                            isFromDonation: isFromDonation,
                            fcmToken: fcmToken,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(55, 187, 187, 187),
                      offset: Offset.zero,
                      blurRadius: 20.0,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 15, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          userImg.isNotEmpty
                              ? userImg
                              : "https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars.png",
                          width: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  nameUser,
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                if (chatRoom.message!.message != null &&
                                    chatRoom.message!.message! != "")
                                  Row(
                                    children: [
                                      if (chatRoom.message!.idForLastUser !=
                                              null &&
                                          chatRoom.message!.idForLastUser ==
                                              TaleedApp.loggedInUser.userID)
                                        Text(
                                          "أنا: ",
                                          style: const TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      Text(
                                        chatRoom.message!.message!,
                                        style: const TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!(chatRoom.message!.readed!) &&
                                    chatRoom.message!.idForLastUser != null &&
                                    chatRoom.message!.idForLastUser !=
                                        TaleedApp.loggedInUser.userID)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      color: Color.fromARGB(128, 227, 162, 17),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${date}",
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Stream<List<ChatRoomModel>> readRequests() {
    
      return ChatProvider().roomsStream(
          chatType: 'NormalChat', id: TaleedApp.loggedInUser.userID!, isClient: true);
    
  }
}
