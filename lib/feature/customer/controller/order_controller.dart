import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/data/repository/user.dart';
import 'package:pet_care_app/feature/personalization/model/user_model.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/image_strings.dart';
import 'package:pet_care_app/utils/popups/full_screen_loader.dart';

import '../../../data/repository/order.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/formatters/formatter.dart';
import '../../../utils/popups/loader.dart';
import '../model/order_model.dart';
import '../model/services/dog_day_care.dart';
import '../model/services/dog_walking_model.dart';
import '../model/services/pet_sitting_model.dart';
import '../model/services/pet_taxi_model.dart';
import '../view/order/purchase_screen.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final walkLocation = TextEditingController();
  final pickUpLocation = TextEditingController();
  final dropOffLocation = TextEditingController();

  final RxString selectedSize = PetSizes.small.toString().obs;
  final RxString dateStart = ''.obs;
  final RxString timeStart = ''.obs;
  final RxList<OrderModel> listOrder = <OrderModel>[].obs;
  final Rx<OrderModel> currentOrder = OrderModel.empty().obs;
  final Rx<ServiceModel> service = ServiceModel.empty().obs;
  final Rx<UserModel> employee = UserModel.empty().obs;

  final GlobalKey<FormState> serviceFormKey = GlobalKey<FormState>();

  final _orderRepo = Get.put(OrderRepository());

  @override
  void onInit() {
    fetchOrder();
    super.onInit();
  }

  Future<List<OrderModel>> fetchOrder() async {
    final user = await UserRepository.instance.getUser();

    if (user.userType == UserType.customer.toString()) {
      return fetchCustomerOrder();
    }

    if (user.userType == UserType.employee.toString()) {
      return fetchEmployeeOrder();
    }

    return [];
  }

  Future<List<OrderModel>> fetchCustomerOrder() async {
    try {
      final orders = await _orderRepo.getOrderByUserId("CustomerId");

      listOrder.assignAll(orders);

      return orders;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  Future<List<OrderModel>> fetchEmployeeOrder() async {
    try {
      final orders = await _orderRepo.getOrderByUserId("EmployeeId");

      listOrder.assignAll(orders);

      return orders;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  Future<void> saveOrderInfomation() async {
    try {
      if (service.value.name == 'Dắt Chó Đi Dạo' || service.value.name == 'Đưa Đón Thú Cưng') {
        if (!serviceFormKey.currentState!.validate()) {
          return;
        }
      }

      if (dateStart.value.isEmpty || timeStart.value.isEmpty) {
        CustomLoader.errorSnackBar(title: 'Error', message: 'Vui lòng chọn ngày và giờ');
        return;
      }

      if (employee.value.id.isEmpty) {
        CustomLoader.errorSnackBar(title: 'Error', message: 'Vui lòng chọn nhân viên');
        return;
      }

      final userId = AuthenticationRepository.instance.authUser!.uid;

      final order = OrderModel(
        customerId: userId,
        employeeId: employee.value.id,
        orderDate: Formatter.formatDate(DateTime.now()),
        dateStart: dateStart.value,
        timeStart: timeStart.value,
        status: OrderStatus.pending,
        serviceName: service.value.name,
        totalPrice: calculateTotalPrice(service.value, selectedSize.value),
        petSize: selectedSize.value,
        walkLocation: walkLocation.text.isEmpty ? null : walkLocation.text,
        dropOffLocation: dropOffLocation.text.isEmpty ? null : dropOffLocation.text,
        pickUpLocation: pickUpLocation.text.isEmpty ? null : pickUpLocation.text,
      );

      currentOrder(order);

      Get.to(() => PurchaseScreen(order: order));
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> saveOrderRecord() async {
    try {
      FullScreenLoader.openLoadingDialog('Đơn hàng đang được xử lý...', LocalImages.loadingAnim);

      await _orderRepo.saveOrder(currentOrder.value);

      FullScreenLoader.stopLoading();
    } catch (e) {
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void onPetSizeSelected(String petSize) {
    selectedSize.value = petSize;
  }

  double dogWalkingPrice(ServiceModel service, String petSizes) {
    final dogWalking = service as DogWalkingModel;
    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium.toString()) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large.toString()) {
      sizeMultiplier = 1.4;
    }
    return dogWalking.price * sizeMultiplier * (dogWalking.durationMinutes / 60);
  }

  double petTaxiPrice(ServiceModel service, String petSizes) {
    final petTaxi = service as PetTaxiModel;
    return petTaxi.price * (petTaxi.distanceKm * petTaxi.pricePerKm);
  }

  double petSittingPrice(ServiceModel service, String petSizes) {
    final petSitting = service as PetSittingModel;

    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium.toString()) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large.toString()) {
      sizeMultiplier = 1.4;
    }

    return petSitting.price * sizeMultiplier * petSitting.durationHours;
  }

  double dogDayCarePrice(ServiceModel service, String petSizes) {
    final dogDayCare = service as DogDayCare;

    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium.toString()) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large.toString()) {
      sizeMultiplier = 1.4;
    }

    return dogDayCare.price * sizeMultiplier;
  }

  double calculateTotalPrice(ServiceModel service, String selectedSize) {
    switch (service.name) {
      case "Dắt Chó Đi Dạo":
        return dogWalkingPrice(service, selectedSize);
      case "Chăm Sóc Thú Cưng Tại Nhà":
        return petSittingPrice(service, selectedSize);
      case "Đưa Đón Thú Cưng":
        return petTaxiPrice(service, selectedSize);
      case "Chăm Sóc Chó Tại Trung Tâm":
        return dogDayCarePrice(service, selectedSize);
      default:
        return 0.0;
    }
  }
}
