import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  Rx<bool> isHidedPassword = true.obs;

  void login() {
    try {
      if (!loginKey.currentState!.validate()){
        return;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}