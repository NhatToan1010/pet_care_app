import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/order_controller.dart';
import '../../../order/purchase_screen.dart';

class ServiceBookingButton extends StatelessWidget {
  const ServiceBookingButton({
    super.key, required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.instance;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSpace, vertical: AppSize.small),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            orderController.service.value = service;

            orderController.saveOrderInfomation();
          },
          child: Text('Đặt Lịch Ngay'),
        ),
      ),
    );
  }
}
