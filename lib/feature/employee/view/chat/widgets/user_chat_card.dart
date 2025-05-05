import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/repository/authentication.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/formatters/formatter.dart';
import '../../../../personalization/controller/message_controller.dart';
import '../../../../personalization/model/conversation_model.dart';
import '../../../../personalization/model/user_model.dart';
import '../../../../personalization/view/message/message_screen.dart';

class UserChatCard extends StatelessWidget {
  const UserChatCard({
    super.key,
    required this.contactUser,
    required this.conversation,
  });

  final UserModel contactUser;
  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthenticationRepository.instance.authUser!;
    final messageController = MessageController.instance;
    final contactUserId = conversation.participants.firstWhere((id) => id != currentUser.uid);
    final unreadMessages = conversation.unreadMessages;
    final numberOfUnreadMessages = unreadMessages[currentUser.uid];

    return ListTile(
      shape: RoundedRectangleBorder(side: BorderSide(color: AppPallete.greyColor, width: 1)),
      leading: CircleAvatar(backgroundImage: NetworkImage(contactUser.avatarURL!)),
      title: Text(contactUser.fullName, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              conversation.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(width: AppSize.small),
          Text(numberOfUnreadMessages! > 0 ? ' (Chưa đọc)' : '',)
        ],
      ),
      trailing: Text(
          Formatter.formatDateAndTime(conversation.lastMessageTimeStamp),
          style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () {
        messageController.getMessages(contactUserId);
        Get.to(() => MessageScreen(contactUser: contactUser));
      },
    );
  }
}
