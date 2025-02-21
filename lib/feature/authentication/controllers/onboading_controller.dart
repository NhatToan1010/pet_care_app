import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care_app/feature/authentication/views/login/login_screen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndex(int newIndex) => currentPageIndex.value = newIndex;

  void dotNavigationClicked(int index) {
    updatePageIndex(index);
    pageController.jumpToPage(currentPageIndex.value);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);

      Get.offAll(() => LoginScreen());
    } else {
      updatePageIndex(currentPageIndex.value + 1);
      pageController.jumpToPage(currentPageIndex.value);
    }
  }
}