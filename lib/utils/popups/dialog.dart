import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class CustomDialog {
  static alertDialog({required title, message, required onPressed}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Hủy'),
      ),
      confirm: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: AppPallete.primary),
        child: const Text('Tiếp Tục'),
      ),
    );
  }

  static deleteAccountWarningDialog({required onConfirmPressed}) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(AppSize.medium),
      title: 'Xóa Tài Khoản',
      middleText: 'Bạn có thật sự muốn xóa tài khoản này?',
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Hủy'),
      ),
      confirm: ElevatedButton(
        onPressed: onConfirmPressed,
        style: ElevatedButton.styleFrom(backgroundColor: AppPallete.errorColor),
        child: const Text('Tiếp Tục'),
      ),
    );
  }
}
