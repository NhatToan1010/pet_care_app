import 'package:get/get.dart';

import '../../../utils/popups/loader.dart';
import '../../../utils/services/stripe_service.dart';
import 'order_controller.dart';

class PurchaseController extends GetxController {
  static PurchaseController get instance => Get.find();

  final orderController = OrderController.instance;
  bool isPaymentSuccess = false;

  Future<void> makePayment(double amount, String currency) async {
    try {
      await StripeService.instance.makePayment(amount, currency);
      isPaymentSuccess = true;
      _checkPayment();
    } catch (e) {
      isPaymentSuccess = false;
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    } finally {
      isPaymentSuccess = false;
    }
  }

  void _checkPayment() {
    if (isPaymentSuccess) {
      orderController.saveOrderRecord();
      CustomLoader.successSnackBar(title: 'Thành công', message: 'Đơn hàng của bạn đã hoàn tất');
    }
  }
}