import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care_app/feature/authentication/views/login/login_screen.dart';
import 'package:pet_care_app/utils/storage/storage_utility.dart';

import '../../feature/authentication/views/onboarding/onboarding_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;


  @override
  void onReady() {
    super.onReady();
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    final user = authUser;

    if (user != null) {
      await LocalStorage.init(user.uid);
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);

      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => OnboardingScreen());
    }
  }
}
