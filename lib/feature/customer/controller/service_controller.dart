import 'package:get/get.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';

import '../../../data/repository/service.dart';

class ServiceController extends GetxController {
  static ServiceController get instance => Get.find();

  final RxList<ServiceModel> services = <ServiceModel>[].obs;

  final serviceRepo = Get.put(ServiceRepository());


  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<List<ServiceModel>> fetchServices() async {
    try {
      final serviceData = await serviceRepo.fetchServices();

      return serviceData;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> upLoadService(List<ServiceModel> services) async {
    try {
      await serviceRepo.upLoadService(services);
      print('---------------------------------------Service Upload Success');
    } catch (e) {
      throw e.toString();
    }
  }
}