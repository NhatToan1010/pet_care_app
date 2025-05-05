import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  String id;
  List<String> participants;
  String lastMessage;
  DateTime lastMessageTimeStamp;
  Map<String, dynamic> unreadMessages;

  ConversationModel({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTimeStamp,
    required this.unreadMessages,
  });

  Map<String, dynamic> toJSON() {
    return {
      'Id': id,
      'Participants': participants,
      'LastMessage': lastMessage,
      'LastMessageTimeStamp': lastMessageTimeStamp,
      'UnreadMessages': unreadMessages,
    };
  }

  static ConversationModel empty() {
    return ConversationModel(
      id: '',
      participants: [],
      lastMessage: '',
      lastMessageTimeStamp: DateTime.now(),
      unreadMessages: {},
    );
  }

  factory ConversationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;

      return ConversationModel(
        id: doc.id,
        participants: List<String>.from(data['Participants']),
        lastMessage: data['LastMessage'],
        lastMessageTimeStamp: (data['LastMessageTimeStamp'] as Timestamp).toDate(),
        unreadMessages: Map<String, dynamic>.from(data['UnreadMessages']),
      );
    } else {
      return empty();
    }
  }

  static String getConversationId(String customerId, String employeeId) {
    List<String> ids = [customerId, employeeId]..sort();
    return '${ids[0]}_${ids[1]}';
  }
}
