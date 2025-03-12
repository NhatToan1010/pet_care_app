import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/feature/personalization/model/message_model.dart';
import 'package:pet_care_app/feature/personalization/model/user_model.dart';
import 'package:pet_care_app/feature/personalization/view/message/widgets/single_message_bubble.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../common/widgets/images/circle_image.dart';
import '../../../../data/repository/authentication.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/message_controller.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key, required this.contactUser});

  final UserModel contactUser;

  @override
  Widget build(BuildContext context) {
    final messageController = MessageController.instance;

    return Scaffold(
      appBar: CustomAppbar(
        backgroundColor: AppPallete.primary,
        leadingColor: AppPallete.whiteColor,
        showBackArrow: true,
        title: Row(
          children: [
            CircleImage(
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              imageUrl: contactUser.avatarURL!,
            ),
            SizedBox(width: AppSize.small),
            SectionHeading(
              title: contactUser.fullName,
              textColor: AppPallete.textWhite,
              showActionButton: false,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.all(AppSize.small),
        child: Obx(
          () {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: messageController.messages.value.length,
              itemBuilder: (context, index) {
                final message = messageController.messages.value[index];

                // --- Single message bubble
                return SingleMessageBubble(contactUser: contactUser, message: message);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSize.medium, horizontal: AppSize.small),
        child: MessageEnterTextField(contactUser: contactUser),
      ),
    );
  }
}

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
        Expanded(
          child: TextField(
            controller: messageController.message,
            decoration: InputDecoration(
              hintText: 'Nhập tin nhắn...',
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              labelStyle: Theme.of(context).textTheme.bodyLarge,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
        ),
        SizedBox(width: AppSize.small),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppPallete.primary,
            foregroundColor: AppPallete.whiteColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            elevation: 8,
          ),
          onPressed: () => messageController.sendMessage(contactUser.id),
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}


