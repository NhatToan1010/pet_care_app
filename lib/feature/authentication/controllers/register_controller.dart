import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/data/repository/user.dart';
import 'package:pet_care_app/feature/authentication/models/user_model.dart';
import 'package:pet_care_app/feature/authentication/views/login/login_screen.dart';
import 'package:pet_care_app/feature/customer/customer_navigation_menu.dart';
import 'package:pet_care_app/utils/constants/enums.dart';
import 'package:pet_care_app/utils/constants/image_strings.dart';
import 'package:pet_care_app/utils/network/network_manager.dart';
import 'package:pet_care_app/utils/popups/full_screen_loader.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNo = TextEditingController();

  Rx<bool> isHidedPassword = true.obs;

  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  final _auth = AuthenticationRepository.instance;
  final userRepo = Get.put(UserRepository());

  Future<void> register() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Vui Lòng Đợi...', LocalImages.loadingAnim);

      final isNetworkConnected = await NetworkManager.instance.isConnected();
      if (!isNetworkConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!registerKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await _auth.registerWithEmailAndPassword(
          email.text.toString().trim(), password.text.toString().trim());

      final user = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.toString().trim(),
        lastName: lastName.text.toString().trim(),
        phoneNumber: phoneNo.text.toString().trim(),
        avatarURL: '',
        userType: UserType.customer.toString(),
        yearExperience: '',
        serviceDone: '',
      );

      userRepo.createNewUser(user);
      print("User Creation Successful");

      FullScreenLoader.stopLoading();

      if (user.id.isNotEmpty) {
        Get.offAll(() => CustomerNavigationMenu());
      } else {
        Get.offAll(() => LoginScreen());
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      throw e.toString();
    }
  }
}
