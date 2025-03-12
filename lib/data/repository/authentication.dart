import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care_app/data/repository/user.dart';
import 'package:pet_care_app/feature/authentication/views/login/login_screen.dart';
import 'package:pet_care_app/feature/customer/customer_navigation_menu.dart';
import 'package:pet_care_app/feature/employee/view/employee_navigation_menu.dart';
import 'package:pet_care_app/utils/storage/storage_utility.dart';

import '../../feature/authentication/views/onboarding/onboarding_screen.dart';
import '../../feature/employee/view/home/employee_home.dart';
import '../../utils/constants/enums.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;


  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    final user = authUser;

    if (user != null) {
      await LocalStorage.init(user.uid);
      final userData = await UserRepository.instance.getUser();
      print('-----------------------------------------------------${userData.userType}');

      if (userData.userType == UserType.customer.toString()) {
        Get.offAll(() => CustomerNavigationMenu());
      } else if (userData.userType == UserType.employee.toString()) {
        Get.offAll(() => EmployeeNavigationMenu());
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);

      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => OnboardingScreen());
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
