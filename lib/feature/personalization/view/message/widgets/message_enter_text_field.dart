import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controller/message_controller.dart';
import '../../../model/user_model.dart';

class MessageEnterTextField extends StatelessWidget {
  const MessageEnterTextField({
    super.key,
    required this.contactUser,
  });

  final UserModel contactUser;

  @override
  Widget build(BuildContext context) {
    final messageController = MessageController.instance;

    return Row(
      children: [
        // =---= Message TextField
        Expanded(
          child: TextField(
            controller: messageController.message,
            decoration: InputDecoration(
              hintText: 'Nhập tin nhắn...',
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              labelStyle: Theme.of(context).textTheme.bodyLarge,
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
        ),
        SizedBox(width: AppSize.small),

        // =---= Send Message Button
        IconButton(
          icon: Icon(Icons.send),
          style: IconButton.styleFrom(
            backgroundColor: AppPallete.primary,
            foregroundColor: AppPallete.whiteColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            elevation: 8,
          ),
          onPressed: () => messageController.sendMessage(contactUser.id),
        ),
      ],
    );
  }
}
