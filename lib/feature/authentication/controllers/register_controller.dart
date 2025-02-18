import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  Rx<bool> isHidedPassword = true.obs;

  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  void register() {
    try {
      if (!registerKey.currentState!.validate()) {
        return;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}