import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/authentication.dart';

import '../../../data/repository/message.dart';
import '../../../utils/popups/loader.dart';
import '../model/conversation_model.dart';
import '../model/message_model.dart';

class MessageController extends GetxController {
  static MessageController get instance => Get.find();

  final _messageRepo = Get.put(MessageRepository());

  final message = TextEditingController();

  final currentUser = AuthenticationRepository.instance.authUser!;

  Rx<List<ConversationModel>> conversations = Rx<List<ConversationModel>>([]);

  Rx<List<MessageModel>> messages = Rx<List<MessageModel>>([]);

  @override
  void onInit() {
    super.onInit();
    getConversation();
  }

  Future<void> createConversation(String contactUserId) async {
    try {
      final newConversation = ConversationModel(
        id: ConversationModel.getConversationId(currentUser.uid, contactUserId),
        participants: [currentUser.uid, contactUserId],
        lastMessage: '',
        lastMessageTimeStamp: DateTime.now(),
        unreadMessages: {contactUserId: 0},
      );

      await _messageRepo.createConversation(newConversation);
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  Future<List<ConversationModel>> getConversation() async {
    try {
      final list = await _messageRepo.getConversation(currentUser.uid);
      conversations.value.assignAll(list);

      return list;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
      return [];
    }
  }

  Future<void> sendMessage(String contactUserId) async {
    try {
      if (message.text.isEmpty) {
        return;
      }

      final messageId = UniqueKey().toString();

      final timeStamp = DateTime.now();

      final id = ConversationModel.getConversationId(currentUser.uid, contactUserId);

      final newMessage = MessageModel(
        senderId: currentUser.uid,
        receiverId: contactUserId,
        message: message.text,
        timestamp: timeStamp,
        isRead: false,
        id: messageId,
        image: '',
      );

      await _messageRepo.sendMessage(id, newMessage);

      getMessages(contactUserId);

      message.clear();
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  Future<void> getMessages(String contactUserId) async {
    try {
      final id = ConversationModel.getConversationId(currentUser.uid, contactUserId);

      await _messageRepo.getMessages(id).then((event) {
        // sort message to show the new one on top
        event.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        messages.value = event;
      });

      for (var message in messages.value) {
        if (message.receiverId == currentUser.uid && !message.isRead) {
          markMessageAsRead(message.id!, contactUserId);
        }
      }
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  Future<void> markMessageAsRead(String messageId, String contactUserId) async {
    try {
      final conversationId = ConversationModel.getConversationId(currentUser.uid, contactUserId);

      await _messageRepo.markMessageAsRead(conversationId, messageId, contactUserId);
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  @override
  void onClose() {
    message.dispose();
    super.onClose();
  }
}
