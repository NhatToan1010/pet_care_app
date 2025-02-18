import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/feature/customer/view/chat/chat_screen.dart';
import 'package:pet_care_app/feature/customer/view/history/history_booking_screen.dart';
import 'package:pet_care_app/feature/customer/view/home/home_screen.dart';
import 'package:pet_care_app/utils/constants/colors.dart';

import '../personalization/view/setting/setting_screen.dart';

class CustomerNavigationMenu extends StatelessWidget {
  const CustomerNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: AppPallete.whiteColor,
          indicatorColor: AppPallete.greyColor,
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
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
              icon: Icon(Iconsax.clock),
              label: 'Lịch Sử',
            ),

            NavigationDestination(
              icon: Icon(Iconsax.setting),
              label: 'Cài Đặt',
            ),
          ],
        ),
      ),

      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    HistoryBookingScreen(),
    SettingScreen(),
  ];
}
