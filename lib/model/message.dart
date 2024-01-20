import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String reciverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.reciverID,
    required this.message,
    required this.timestamp,
  });

  // convert it to a Map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'reciverID': reciverID,
      'message': message,
      'timestamp': timestamp
    };
  }

  Map<String, Object?> toJson() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'reciverID': reciverID,
      'message': message,
      'timestamp': timestamp
    };
  }

   Message.fromJson(Map<String, Object?> json)
      : this(
          senderID: json['senderID']! as String,
          senderEmail: json['senderEmail'] as String,
          reciverID: json['reciverID'] as String,
          message: json['message'] as String,
          timestamp: json['timestamp'] as Timestamp,
        );

}
