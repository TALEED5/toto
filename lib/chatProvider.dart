import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'TaleedApp.dart';
import 'chatRoomModel.dart';
import 'messages_model.dart';

class ChatProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  markMessageAsReaded(
      {required String roomId,
      required String messageId,
      required String chatType}) {
    firestore
        .collection('ChatRooms')
        .doc(chatType)
        .collection("Chat")
        .doc(roomId)
        .update({'lastMessage.readed': true});
  }

  Future createChatRoom(
      {required ChatRoomModel chatRoom, required String chatType}) async {
    print("ff");
    await firestore
        .collection('ChatRooms')
        .doc(chatType)
        .collection("Chat")
        .doc('${chatRoom.senderId}-${chatRoom.RecieverUserID}')
        .set({
      'senderId': chatRoom.senderId,
      'senderName': chatRoom.senderName,
      'senderImg': chatRoom.senderImg ?? '',
      'donationId': chatRoom.donationId, /////////
      'RecieverUserID': chatRoom.RecieverUserID, //RecieverID
      'RecieverUsername': chatRoom.RecieverUsername, //Reciever username
      'donationUserImg': chatRoom.donationUserImg ?? '',
      'lastMessage': {
        'message': chatRoom.message!.message,
        'dateTime': Timestamp.now(),
        'isClient': true,  //no need
        'readed': false,
      }
    });
  }

  Future insertMessageDonationChat(
      {required String roomId, required MessageModel message}) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    DocumentReference reference = firestore
        .collection('ChatRooms')
        .doc("DonationChat")
        .collection("Chat")
        .doc(roomId);

    DocumentReference ref = firestore
        .collection('ChatRooms')
        .doc("DonationChat")
        .collection("Chat")
        .doc(roomId)
        .collection('messages')
        .doc();

    batch.update(reference, {
      'lastMessage': {
        'message': message.message,
        'dateTime': Timestamp.now(),
        'isClient': false,
        'idForLastUser': TaleedApp.loggedInUser.userID,
        'senderId': message.senderId,
        'RecieverUserID': message.RecieverUserID,
        'donationUserImg': message.donationUserImg,
        'RecieverUsername': message.RecieverUsername,
        'senderImg': message.senderImg,
        'senderName': message.senderName,
        'readed': message.readed,
      }
    });

    batch.set(ref, {
      'message': message.message,
      'idForLastUser': TaleedApp.loggedInUser.userID,
      'dateTime': Timestamp.now(),
      'isClient': false,
      'senderId': message.senderId,
      'readed': message.readed,
    });

    await batch.commit().catchError((e) {
      throw e;
    });
  }

  Future insertMessageNormalChat(
      {required String roomId, required MessageModel message}) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    DocumentReference reference = firestore
        .collection('ChatRooms')
        .doc("NormalChat")
        .collection("Chat")
        .doc(roomId);

    DocumentReference ref = firestore
        .collection('ChatRooms')
        .doc("NormalChat")
        .collection("Chat")
        .doc(roomId)
        .collection('messages')
        .doc();

    batch.update(reference, {
      'lastMessage': {
        'message': message.message,
        'dateTime': Timestamp.now(),
        'isClient': false,   //////////
        'idForLastUser': TaleedApp.loggedInUser.userID,
        'senderId': message.senderId,
        'RecieverUserID': message.RecieverUserID,
        'donationUserImg': message.donationUserImg,//////
        'RecieverUsername': message.RecieverUsername,
        'senderImg': message.senderImg,////////
        'senderName': message.senderName,
        'readed': message.readed,
      }
    });

    batch.set(ref, {
      'message': message.message,
      'idForLastUser': TaleedApp.loggedInUser.userID,
      'dateTime': Timestamp.now(),
      'isClient': false,////////
      'senderId': message.senderId,
      'readed': message.readed,
    });

    await batch.commit().catchError((e) {
      throw e;
    });
  }

  Stream<List<MessageModel>> messagesStream(
      {required String roomId, required bool isFromDonation}) {
    
      var snapshots = firestore
          .collection('ChatRooms')
          .doc("NormalChat")
          .collection("Chat")
          .doc(roomId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots();

      return snapshots.map((event) => event.docs
          .map((e) => MessageModel.fromJson(e.data(), e.id))
          .toList()
          .reversed
          .toList());
    
  }

  Stream<List<ChatRoomModel>> roomsStream(
      {required String id, required bool isClient, required String chatType}) {
    return firestore
        .collection('ChatRooms')
        .doc(chatType)
        .collection("Chat")
        .snapshots()
        .map((event) {
      List<ChatRoomModel> _list = [];

      List<ChatRoomModel> rooms =
          event.docs.map((e) => ChatRoomModel.fromJson(e.data())).toList();
      print(rooms.length);
      print("mee ${TaleedApp.loggedInUser.userID}");
      for (var element in rooms) {
        print("senderId: ${element.senderId}");
        print("RecieverUserID: ${element.RecieverUserID}");
        if (element.senderId == TaleedApp.loggedInUser.userID) {
          print("_list.length_1");
          _list.add(element);
        } else if (element.RecieverUserID == TaleedApp.loggedInUser.userID) {
          print("_list.length_2");
          _list.add(element);
        }
      }

      _list
          .sort((a, b) => a.message!.dateTime!.compareTo(b.message!.dateTime!));
      print(_list.length);
      return _list.reversed.toList();
    });
  }
}