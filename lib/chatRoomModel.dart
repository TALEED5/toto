import 'messages_model.dart';

class ChatRoomModel {
  String? id;
  String? senderId;
  String? donationUserId;
  String? senderName;
  String? senderImg;
  String? donationUserName;
  String? donationUserImg;
  bool? isDonation;
  String? donationId;
  MessageModel? message;

  ChatRoomModel({
    this.id,
    this.senderId,
    this.donationUserId,
    this.senderName,
    this.senderImg,
    this.donationUserImg,
    this.donationUserName,
    this.isDonation,
    this.donationId,
    this.message,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    donationUserId = json['donationUserId'];
    senderName = json['senderName'];
    senderImg = json['senderImg'];
    donationUserName = json['donationUserName'];
    donationUserImg = json['donationUserImg'];
    isDonation = json['isDonation'];
    donationId = json['donationId'];
    if (json['lastMessage'] != null) {
      message = MessageModel.fromJson(json['lastMessage'], '');
    }
  }
}
