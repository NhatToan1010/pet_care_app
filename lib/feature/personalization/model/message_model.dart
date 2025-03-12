import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  String senderId;
  String receiverId;
  String message;
  String? image;
  DateTime timestamp;
  bool isRead;

  MessageModel({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.isRead,
    this.image,
  });

  Map<String, dynamic> toJSON() {
    return {
      'Id': id,
      'SenderId': senderId,
      'ReceiverId': receiverId,
      'Message': message,
      'Timestamp': timestamp,
      'IsRead': isRead,
      'Image': image,
    };
  }

  static MessageModel empty() {
    return MessageModel(
      id: '',
      senderId: '',
      receiverId: '',
      message: '',
      timestamp: DateTime.now(),
      isRead: false,
      image: '',
    );
  }

  factory MessageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    print("------------------------------------------------fromSnapshot called for doc ID: ${doc.id}");
    if (doc.data() != null) {

      final data = doc.data()!;
      print("-------------------------------------------------MessageModel created with ID: ${doc.id}");

      // Check if 'Timestamp' is of type Timestamp and handle potential nulls
      final timestampData = data['Timestamp'];
      DateTime? timestamp;

      if (timestampData is Timestamp) {
        timestamp = timestampData.toDate();
      }
      timestamp ??= DateTime.now();

      return MessageModel(
        id: doc.id,
        senderId: data['SenderId'] ?? '',
        receiverId: data['ReceiverId'] ?? '',
        message: data['Message'] ?? '',
        timestamp: timestamp,
        isRead: data['IsRead'] ?? '',
        image: data['Image'] ?? '',
      );
    } else {
      print("------------------------------------------------------fromSnapshot: Document data is null for doc ID: ${doc.id}");
      return empty();
    }
  }
}
