import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/data/repository/user.dart';
import 'package:pet_care_app/feature/authentication/models/user_model.dart';
import 'package:pet_care_app/feature/authentication/views/login/login_screen.dart';
import 'package:pet_care_app/utils/popups/loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final _userRepo = UserRepository.instance;


  @override
  void onInit() {
    super.onInit();
    fetchUserData();
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

  // ----- Upload user's profile picture
  Future<void> uploadUserImage() async {
    try {
      // Open local device gallery to choose an image
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (image != null) {
        // Upload image into Firebase Storage
        final imageUrl = await _userRepo.uploadImage('Users/Images/Profile', image);

        // Upload image to Database
        Map<String, dynamic> profilePicture = {"ProfilePicture" : imageUrl};
        await _userRepo.updateSpecificUserField(profilePicture);

        // Set updated image to UI of local device
        user.value.avatarURL = imageUrl;
        user.refresh();

        // Show snack bar
        CustomLoader.successSnackBar(
            title: 'Congratulation!',
            message: 'Your avatar is successfully updated!'
        );
      } else {
      }
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
}