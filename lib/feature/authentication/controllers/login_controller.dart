import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/feature/personalization/controller/user_controller.dart';
import 'package:pet_care_app/utils/popups/full_screen_loader.dart';
import 'package:pet_care_app/utils/popups/loader.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/network/network_manager.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  Rx<bool> isHidedPassword = true.obs;

  final _auth = AuthenticationRepository.instance;

  Future<void> login() async {
    try {
      FullScreenLoader.openLoadingDialog('Vui Lòng Đợi...', LocalImages.loadingAnim);

      final isNetworkConnected = await NetworkManager.instance.isConnected();
      if (!isNetworkConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!loginKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      await _auth.signInWithEmailAndPassword(email.text.trim(), password.text.trim());
      Get.put(UserController());
      FullScreenLoader.stopLoading();

      await _auth.screenRedirect();

    } catch (e) {
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Error', message: e.toString());
      throw e.toString();
    }
  }
}