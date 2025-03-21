import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/feature/personalization/controller/user_controller.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/device/device_utility.dart';
import 'package:pet_care_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/employee/employee_card_horizontal.dart';
import '../../../../utils/popups/shimmers/horizontal_product_shimmer.dart';
import '../../../personalization/controller/message_controller.dart';
import '../../../personalization/view/message/message_screen.dart';
import '../employee_info/employee_info_screen.dart';

class CustomerChatScreen extends StatelessWidget {
  const CustomerChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final messageController = Get.put(MessageController());

    return Scaffold(
      appBar: CustomAppbar(title: Text('Trao đổi với chúng tôi')),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: SizedBox(
          height: DeviceUtils.getScreenHeight(),
          width: double.infinity,
          child: FutureBuilder(
            future: userController.getEmployee(),
            builder: (context, snapshot) {
              final response = CloudHelperFunctions.checkSingleStateRecord(
                snapshot: snapshot,
                shimmerEffect: HorizontalProductShimmerEffect(),
              );
              if (response != null) return response;

              final employees = snapshot.data!;

              // =---= Return list employee
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: AppSize.spaceBtwItems),
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];

                  EmployeeCardHorizontal(
                    onChatButtonTap: () {
                      messageController.createConversation(employee.id);
                      messageController.getMessages(employee.id);
                      Get.to(() => MessageScreen(contactUser: employee));
                    },
                    onTap: () => Get.to(() => EmployeeInfoScreen()),
                    employee: employee,
                    hideButton: true,
                  );
                  return null;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
