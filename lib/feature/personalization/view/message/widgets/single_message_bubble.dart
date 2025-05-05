import 'package:flutter/material.dart';

import '../../../../../data/repository/authentication.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../model/message_model.dart';
import '../../../model/user_model.dart';

class SingleMessageBubble extends StatelessWidget {
  const SingleMessageBubble({
    super.key,
    required this.contactUser,
    required this.message,
  });

  final UserModel contactUser;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthenticationRepository.instance.authUser!;
    final isCurrentUser = message.senderId == currentUser.uid;
    final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // --- Sender
          Text(
            isCurrentUser ? 'Bạn' : contactUser.fullName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: AppSize.extraSmall),

          // --- Message Content
          Container(
              padding: const EdgeInsets.all(12.0),
              alignment: alignment,
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? AppPallete.primary.withAlpha(75)
                    : AppPallete.greyColor.withAlpha(75),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(message.message, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
