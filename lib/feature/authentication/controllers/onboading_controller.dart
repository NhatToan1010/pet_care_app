import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
      pageController.jumpToPage(0);
    } else {
      updatePageIndex(currentPageIndex.value + 1);
      pageController.jumpToPage(currentPageIndex.value);
    }
  }
}