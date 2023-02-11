class MessageModel {
  String? messageId;
  String? message;
  String? idForLastUser;
  DateTime? dateTime;
  bool? readed;
  String? senderId;
  String? RecieverUserID;
  String? senderName;
  String? senderImg;
  String? RecieverUsername;
  String? donationUserImg;

  MessageModel(
      {this.message,
      this.idForLastUser,
      this.messageId,
      this.dateTime,
      this.senderId,
      this.RecieverUserID,
      this.senderName,
      this.senderImg,
      this.donationUserImg,
      this.RecieverUsername,
      this.readed});

  MessageModel.fromJson(Map<String, dynamic> json, String id) {
    messageId = id;
    message = json['message'];
    // dateTime = json['dateTime'];
    dateTime = json['dateTime'].toDate();
    readed = json['readed'];
    idForLastUser = json['idForLastUser'];
    senderId = json['senderId'];
    RecieverUserID = json['RecieverUserID'];
    senderName = json['senderName'];
    senderImg = json['senderImg'];
    RecieverUsername = json['RecieverUsername'];
    donationUserImg = json['donationUserImg'];
  }
}
