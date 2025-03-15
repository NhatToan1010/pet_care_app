import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/dog_day_care_service.dart';

import '../../../data/repository/service.dart';
import '../../../utils/constants/enums.dart';
import '../view/service/widgets/dog_walking_service.dart';
import '../view/service/widgets/pet_sitting_service.dart';
import '../view/service/widgets/pet_taxi_service.dart';

class ServiceController extends GetxController {
  static ServiceController get instance => Get.find();

  final RxList<ServiceModel> services = <ServiceModel>[].obs;

  final RxString selectedWalkLocation = 'Công viên Lưu Hữu Phước'.obs;

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
    } catch (e) {
      throw e.toString();
    }
  }

  Widget routeService(ServiceModel service) {
    switch (service.name) {
      case "Dắt Chó Đi Dạo":
        return DogWalkingService(service: service);
      case "Chăm Sóc Thú Cưng Tại Nhà":
        return PetSittingService(service: service);
      case "Đưa Đón Thú Cưng":
        return PetTaxiService(service: service);
      case "Chăm Sóc Chó Tại Trung Tâm":
        return DogDayCareService(service: service);
      default:
        return Center(
          child: Text('Không Tìm Thấy Dịch Vụ'),
        );
    }
  }

  String convertSize(String item) {
    if (item == PetSizes.small.toString()) {
      item = 'Nhỏ';
    } else if (item == PetSizes.medium.toString()) {
      item = 'Vừa';
    } else if (item == PetSizes.large.toString()) {
      item = 'Lớn';
    }

    return item;
  }
}
