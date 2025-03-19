import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/feature/customer/model/order_model.dart';
import 'package:pet_care_app/feature/customer/view/order/widgets/infomation_card.dart';
import 'package:pet_care_app/feature/customer/view/order/widgets/price_infomation.dart';
import 'package:pet_care_app/feature/customer/view/order/widgets/service_infomation.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/helpers/cloud_helper_functions.dart';
import 'package:pet_care_app/utils/helpers/pricing_calculator.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/shimmers/horizontal_product_shimmer.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../controller/purchase_controller.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final purchaseController = Get.put(PurchaseController());
    final totalAmount = PricingCalculator.calculateTotalPrice(order.totalPrice);

    return Scaffold(
      appBar: CustomAppbar(
        title: Text('Thanh Toán'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.small),
        child: Column(
          children: [
            // --- Order Info
            FutureBuilder(
              future: userController.getSpecificUser(order.customerId),
              builder: (context, snapshot) {
                final response = CloudHelperFunctions.checkSingleStateRecord(snapshot: snapshot, shimmerEffect: HorizontalProductShimmerEffect());

                if (response != null) return response;

                final customer = snapshot.data!;

                return InfomationCard(
                  hideButton: true,
                  title: 'Thông tin đơn hàng',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${customer.fullName} | ${customer.phoneNumber}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: AppSize.small),
                      Text(
                        '49 Nguyễn Văn Trỗi, Xuân Khánh, Ninh Kiều, Cần Thơ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: AppSize.small),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Service Infomation
            ServiceInfomation(order: order),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Price Detail
            PriceInfomation(order: order),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSize.medium),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => purchaseController.makePayment(totalAmount, "USD"),
            child: Text('ĐẶT HÀNG'),
          ),
        ),
      ),
    );
  }
}


