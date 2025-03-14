import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/data/repository/user.dart';
import 'package:pet_care_app/feature/personalization/model/user_model.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/image_strings.dart';
import 'package:pet_care_app/utils/helpers/pricing_calculator.dart';
import 'package:pet_care_app/utils/popups/full_screen_loader.dart';

import '../../../data/repository/order.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/formatters/formatter.dart';
import '../../../utils/popups/loader.dart';
import '../model/order_model.dart';
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
  final RxList<OrderModel> pendingOrderList = <OrderModel>[].obs;
  final RxList<OrderModel> successfulOrderList = <OrderModel>[].obs;
  final RxList<OrderModel> canceledOrderList = <OrderModel>[].obs;

  final Rx<OrderModel> currentOrder = OrderModel.empty().obs;
  final Rx<ServiceModel> service = ServiceModel.empty().obs;
  final Rx<UserModel> employee = UserModel.empty().obs;
  
  final Rx<OrderStatus> currentStatus = OrderStatus.pending.obs;

  final GlobalKey<FormState> serviceFormKey = GlobalKey<FormState>();

  final _orderRepo = Get.put(OrderRepository());

  // ============================ Methods ============================
  void onPetSizeSelected(String petSize) {
    selectedSize.value = petSize;
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrder();
  }

  // ------------------------- Get Order Data By UserType
  Future<void> fetchOrder() async {
    final user = await UserRepository.instance.getUser();

    if (user.userType == UserType.customer.toString()) fetchCustomerOrder();

    if (user.userType == UserType.employee.toString()) fetchOrderByEmployeeId();
  }

  Future<void> fetchCustomerOrder() async {
    try {
      final orders = await _orderRepo.getOrderByUserId("CustomerId");

      listOrder.assignAll(orders);

      pendingOrderList.assignAll(orders.where((order) => order.status == OrderStatus.pending));
      successfulOrderList.assignAll(listOrder.where((order) => order.status == OrderStatus.successful));
      canceledOrderList.assignAll(listOrder.where((order) => order.status == OrderStatus.canceled));
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  Future<void> fetchOrderByEmployeeId() async {
    try {
      final orders = await _orderRepo.getOrderByUserId("EmployeeId");

      listOrder.assignAll(orders);
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  // ------------------------- Save Order Information & Order Data To Database
  Future<void> saveOrderInfomation() async {
    try {
      _checkServiceForm();

      final userId = AuthenticationRepository.instance.authUser!.uid;

      final order = OrderModel(
        customerId: userId,
        employeeId: employee.value.id,
        orderDate: Formatter.formatDate(DateTime.now()),
        dateStart: dateStart.value,
        timeStart: timeStart.value,
        status: OrderStatus.pending,
        serviceName: service.value.name,
        totalPrice: PricingCalculator.calculateServicePrice(service.value, selectedSize.value),
        petSize: selectedSize.value,
        walkLocation: walkLocation.text.isEmpty ? null : walkLocation.text,
        dropOffLocation: dropOffLocation.text.isEmpty ? null : dropOffLocation.text,
        pickUpLocation: pickUpLocation.text.isEmpty ? null : pickUpLocation.text,
      );

      currentOrder(order);

      Get.to(() => PurchaseScreen(order: order));
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  Future<void> saveOrderRecord() async {
    try {
      FullScreenLoader.openLoadingDialog('Đơn hàng đang được xử lý...', LocalImages.loadingAnim);

      await _orderRepo.saveOrder(currentOrder.value);

      FullScreenLoader.stopLoading();
    } catch (e) {
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  // ------------------------- Update Order Status
  void updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      await _orderRepo.updateOrderStatus(order, newStatus);
      await fetchOrder();

      currentOrder.value.status = newStatus;
      Navigator.pop(Get.context!);
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  // ------------------------- Ultil Methods
  void _checkServiceForm() {
    if (service.value.name == 'Dắt Chó Đi Dạo' || service.value.name == 'Đưa Đón Thú Cưng' && !serviceFormKey.currentState!.validate()) return;

    if (dateStart.value.isEmpty || timeStart.value.isEmpty) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: 'Vui lòng chọn ngày và giờ');
      return;
    }

    if (employee.value.id.isEmpty) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: 'Vui lòng chọn nhân viên');
      return;
    }
  }

  void orderStatusSelectionDialog({required OrderModel order}) {
    Get.dialog(
      AlertDialog(
        alignment: Alignment.center,
        backgroundColor: AppPallete.whiteColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(AppSize.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // =---= Dialog Title
                Text(
                  'Chọn Trạng Thái Đơn Hàng',
                  style: Theme.of(Get.overlayContext!).textTheme.titleMedium,
                ),
                SizedBox(height: AppSize.spaceBtwItems),

                // =---= Pending Status
                Obx(
                  () => RadioListTile<OrderStatus>(
                    value: OrderStatus.pending,
                    groupValue: currentStatus.value,
                    onChanged: (selectedStatus) => currentStatus.value = selectedStatus!,
                    title: Text('Chờ xác nhận'),
                  ),
                ),
                SizedBox(height: AppSize.spaceBtwItems),

                // =---= Successful Status
                Obx(
                  () => RadioListTile<OrderStatus>(
                    value: OrderStatus.successful,
                    groupValue: currentStatus.value,
                    onChanged: (selectedStatus) => currentStatus.value = selectedStatus!,
                    title: Text('Đã xác nhận'),
                  ),
                ),
                SizedBox(height: AppSize.spaceBtwItems),

                // =---= Canceled Status
                Obx(
                  () => RadioListTile<OrderStatus>(
                    value: OrderStatus.canceled,
                    groupValue: currentStatus.value,
                    onChanged: (selectedStatus) => currentStatus.value = selectedStatus!,
                    title: Text('Hủy đơn hàng'),
                  ),
                ),
                SizedBox(height: AppSize.spaceBtwItems),

                // =---= Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(Get.overlayContext!).pop(),
                      child: Text('Hủy'),
                    ),
                    SizedBox(width: AppSize.small),
                    TextButton(
                      onPressed: () =>
                          updateOrderStatus(order, currentStatus.value),
                      child: Text('Xác nhận'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
