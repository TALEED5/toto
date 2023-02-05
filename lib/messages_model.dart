class MessageModel {
  String? messageId;
  String? message;
  String? idForLastUser;
  DateTime? dateTime;
  bool? readed;
  String? senderId;
  String? donationUserId;
  String? senderName;
  String? senderImg;
  String? donationUserName;
  String? donationUserImg;

  MessageModel(
      {this.message,
      this.idForLastUser,
      this.messageId,
      this.dateTime,
      this.senderId,
      this.donationUserId,
      this.senderName,
      this.senderImg,
      this.donationUserImg,
      this.donationUserName,
      this.readed});

  MessageModel.fromJson(Map<String, dynamic> json, String id) {
    messageId = id;
    message = json['message'];
    // dateTime = json['dateTime'];
    dateTime = json['dateTime'].toDate();
    readed = json['readed'];
    idForLastUser = json['idForLastUser'];
    senderId = json['senderId'];
    donationUserId = json['donationUserId'];
    senderName = json['senderName'];
    senderImg = json['senderImg'];
    donationUserName = json['donationUserName'];
    donationUserImg = json['donationUserImg'];
  }
}
