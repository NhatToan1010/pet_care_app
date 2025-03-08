import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/feature/personalization/model/conversation_model.dart';

import '../../feature/personalization/model/message_model.dart';

class MessageRepository extends GetxController {
  static MessageRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createConversation(ConversationModel conversation) async {
    try {
      await _db
          .collection('Conversations')
          .doc(conversation.id)
          .set(conversation.toJSON());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ConversationModel>> getConversation(String userId) async {
    try {
      final snapshot = await _db
          .collection('Conversations')
          .where('Participants', arrayContains: userId)
          .orderBy('LastMessageTimeStamp', descending: true)
          .get();

      return snapshot.docs
          .map((item) => ConversationModel.fromSnapshot(item))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> sendMessage(String conversationId, MessageModel message) async {
    try {
      // Find conversation and message reference
      final conversationRef =
          _db.collection('Conversations').doc(conversationId);
      final messageRef = conversationRef.collection('Messages').doc();

      // Set message id
      message.id = messageRef.id;

      // Batch write to update both the message and conversation
      WriteBatch batch = _db.batch();

      // Add new message
      batch.set(messageRef, message.toJSON());

      // Update conversation last message and last timestamp
      batch.update(conversationRef, {
        "LastMessage": message.message,
        "LastMessageTimeStamp": message.timestamp,
        "UnreadMessages.${message.receiverId}": FieldValue.increment(1),
      });

      // Commit the batch wire
      await batch.commit();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<MessageModel>> getMessages(String conversationId) async {
    try {
      final snapshot = await _db
          .collection('Conversations')
          .doc(conversationId)
          .collection('Messages')
          .orderBy('Timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((item) => MessageModel.fromSnapshot(item))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> markMessageAsRead(String conversationId, String messageId, String receiverId) async {
    try {
      final conversationRef = _db.collection('Conversations').doc(conversationId);
      final messageRef = conversationRef.collection('Messages').doc(messageId);

      WriteBatch batch = _db.batch();

      batch.update(messageRef, {"IsRead": true});
      batch.update(conversationRef, {"UnreadMessages.$receiverId": FieldValue.increment(-1)});

      await batch.commit();
    } catch (e) {
      throw e.toString();
    }
  }
}
