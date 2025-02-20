import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/user.dart';
import 'package:pet_care_app/utils/network/network_manager.dart';

class GeneralBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserRepository());
  }

}