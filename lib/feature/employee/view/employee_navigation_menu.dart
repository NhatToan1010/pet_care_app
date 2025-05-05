import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/feature/employee/view/chat/employee_chat_screen.dart';
import 'package:pet_care_app/feature/employee/view/home/employee_home.dart';
import 'package:pet_care_app/feature/personalization/view/setting/setting_screen.dart';

import '../../../utils/constants/colors.dart';

class EmployeeNavigationMenu extends StatelessWidget {
  const EmployeeNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeeNavigationController());

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            backgroundColor: AppPallete.whiteColor,
            indicatorColor: AppPallete.greyColor,
            height: 60,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                icon: Icon(Iconsax.home),
                label: 'Trang Chủ',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.message),
                label: 'Tin Nhắn',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.setting),
                label: 'Cài Đặt',
              ),
            ],
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
      ),
    );
  }
}

class EmployeeNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  List<Widget> screens = [
    EmployeeHomeScreen(),
    EmployeeChatScreen(),
    SettingScreen(),
  ];
}
