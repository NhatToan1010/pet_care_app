import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/feature/employee/view/chat/widgets/user_chat_card.dart';
import 'package:pet_care_app/utils/popups/shimmers/brand_shimmer.dart';

import '../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../data/repository/authentication.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../personalization/controller/message_controller.dart';
import '../../../personalization/controller/user_controller.dart';

class EmployeeChatScreen extends StatelessWidget {
  const EmployeeChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = Get.put(MessageController());
    final userController = Get.put(UserController());

    return Scaffold(
      appBar: CustomAppbar(title: Text('Danh sách tin nhắn')),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: messageController.getConversation(),
          builder: (context, snapshot) {
            final response = CloudHelperFunctions.checkSingleStateRecord(
                snapshot: snapshot,
                shimmerEffect: Center(child: BrandShimmerEffect()));
            if (response != null) return response;

            // --- Fetch list conversation
            final listConversations = snapshot.data!;

            return ListView.builder(
              itemCount: listConversations.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final conversation = listConversations[index];
                final contactUserId = conversation.participants.firstWhere((id) => id != AuthenticationRepository.instance.authUser!.uid);

                return FutureBuilder(
                    future: userController.getSpecificUser(contactUserId),
                    builder: (context, snapshot) {
                      final response =
                          CloudHelperFunctions.checkSingleStateRecord(
                              snapshot: snapshot,
                              shimmerEffect: Center(child: BrandShimmerEffect()),
                          );
                      if (response != null) return response;

                      // --- Fetch contactUser
                      final contactUser = snapshot.data!;

                      return UserChatCard(contactUser: contactUser, conversation: conversation);
                    });
              },
            );
          },
        ),
      ),
    );
  }
}


