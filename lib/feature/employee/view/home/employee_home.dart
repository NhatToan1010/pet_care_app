import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/utils/helpers/cloud_helper_functions.dart';
import 'package:pet_care_app/utils/popups/shimmers/horizontal_product_shimmer.dart';

import '../../../customer/controller/order_controller.dart';
import 'employee_order_card.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());

    return Scaffold(
      appBar: CustomAppbar(title: Text('Đơn hàng có thể nhận')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.small),
        child: Obx(
            () {
              final listOrder = orderController.listOrder;

              return SizedBox(
                height: DeviceUtils.getScreenHeight(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: AppSize.medium),
                  itemCount: listOrder.length,
                  itemBuilder: (context, index) {
                    return EmployeeOrderCard(
                      order: listOrder[index],
                      onTap: () => orderController.orderStatusSelectionDialog(order: listOrder[index]),
                    );
                  },
                ),
              );
            },
        ),
      ),
    );
  }
}
