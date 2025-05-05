
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/data/repository/user.dart';
import 'package:pet_care_app/feature/personalization/model/user_model.dart';
import 'package:pet_care_app/feature/authentication/views/login/login_screen.dart';
import 'package:pet_care_app/utils/popups/loader.dart';

import '../../customer/controller/order_controller.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final _userRepo = UserRepository.instance;

  final orderController = Get.put(OrderController());

  final newFirstName = TextEditingController();
  final newLastName = TextEditingController();
  final newPhoneNumer = TextEditingController();

  final selectedEmployee = UserModel.empty().obs;

  final currentUser = UserModel.empty().obs;

  @override
  void onReady() {
    super.onReady();
    fetchUserData();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

    newFirstName.text = user.value.firstName;
    newLastName.text = user.value.lastName;
    newPhoneNumer.text = user.value.phoneNumber;
  }

  Future<void> fetchUserData() async {
    try {
      final userData = await _userRepo.getUser();

      if (userData.id.isNotEmpty) {
        user(userData);
      }
    } catch (e) {
      user(UserModel.empty());
      CustomLoader.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<List<UserModel>> getEmployee() async {
    try {
      final employees = await _userRepo.getEmployee();
      return employees;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  // ----- Upload user's profile picture
  Future<void> uploadUserImage() async {
    try {
      // Open local device gallery to choose an image
      // final image = await ImagePicker().pickImage(
      //   source: ImageSource.gallery,
      //   imageQuality: 70,
      //   maxWidth: 512,
      //   maxHeight: 512,
      // );
      //
      // if (image != null) {
      //   // Upload image into Firebase Storage
      //   final imageUrl = await _userRepo.uploadImage('Users/Images/Profile', image);
      //
      //   // Upload image to Database
      //   Map<String, dynamic> profilePicture = {"ProfilePicture" : imageUrl};
      //   await _userRepo.updateSpecificUserField(profilePicture);
      //
      //   // Set updated image to UI of local device
      //   user.value.avatarURL = imageUrl;
      //   user.refresh();
      //
      //   // Show snack bar
      //   CustomLoader.successSnackBar(
      //       title: 'Congratulation!',
      //       message: 'Your avatar is successfully updated!'
      //   );
      // } else {
      // }
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> updateUserProfile() async {
    try {
      if (newFirstName.text != user.value.firstName || newLastName.text != user.value.lastName) {
        Map<String, dynamic> updateName = {
          'FirstName': newFirstName.text,
          'LastName': newLastName.text,
        };

        await _userRepo.updateSpecificUserField(updateName);
      }

      if (newPhoneNumer.text != user.value.phoneNumber) {
        Map<String, dynamic> updatePhone = {
          'PhoneNumber': newPhoneNumer.text,
        };

        await _userRepo.updateSpecificUserField(updatePhone);
      }

      CustomLoader.successSnackBar(
        title: 'Congratulation!',
        message: 'Your profile is successfully updated!',
      );

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await AuthenticationRepository.instance.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void changeSelectedEmployee(UserModel newEmployee) {
    try{
      if (newEmployee.id.isNotEmpty) {
        selectedEmployee(newEmployee);
        orderController.employee(newEmployee);
        Get.back();
      }
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void resetSelectedEmployee() {
    selectedEmployee(UserModel.empty());
  }

  Future<UserModel> getSpecificUser(String userId) async {
    try {
      final user = await _userRepo.getSpecificUser(userId);
      currentUser(user);

      return user;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return UserModel.empty();
    }
  }

  void getSender(String userId) async {
    try {
      final user = await _userRepo.getSpecificUser(userId);
      currentUser(user);
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}