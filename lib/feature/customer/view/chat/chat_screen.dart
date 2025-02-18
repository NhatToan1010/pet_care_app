import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/device/device_utility.dart';

import '../../../../common/widgets/employee/employee_card_horizontal.dart';
import '../employee_info/employee_info_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Text('Trao đổi với chúng tôi')),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: SizedBox(
          height: DeviceUtils.getScreenHeight(),
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (contaxt, index) => SizedBox(height: AppSize.spaceBtwItems),
            itemCount: 4,
            itemBuilder: (contaxt, index) => EmployeeCardHorizontal(onTap: () => Get.to(() => EmployeeInfoScreen()),),
          ),
        ),
      ),
    );
  }
}
