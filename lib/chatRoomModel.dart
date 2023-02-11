import 'messages_model.dart';

class ChatRoomModel {
  String? id;
  String? senderId;
  String? RecieverUserID; //RecieverUserID
  String? senderName;
  String? senderImg;
  String? RecieverUsername; //RecieverUsername
  String? donationUserImg;
  bool? isDonation;
  String? donationId;
  MessageModel? message;

  ChatRoomModel({
    this.id,
    this.senderId,
    this.RecieverUserID,
    this.senderName,
    this.senderImg,
    this.donationUserImg,
    this.RecieverUsername,
    this.isDonation,
    this.donationId,
    this.message,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    RecieverUserID = json['RecieverUserID'];
    senderName = json['senderName'];
    senderImg = json['senderImg'];
    RecieverUsername = json['RecieverUsername'];
    donationUserImg = json['donationUserImg'];
    isDonation = json['isDonation'];
    donationId = json['donationId'];
    if (json['lastMessage'] != null) {
      message = MessageModel.fromJson(json['lastMessage'], '');
    }
  }
}
