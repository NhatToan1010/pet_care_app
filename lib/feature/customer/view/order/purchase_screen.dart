import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/common/widgets/texts/product_text/product_price_text.dart';
import 'package:pet_care_app/feature/customer/model/order_model.dart';
import 'package:pet_care_app/feature/customer/view/order/widgets/infomation_card.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/helpers/cloud_helper_functions.dart';
import 'package:pet_care_app/utils/helpers/pricing_calculator.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/shimmers/horizontal_product_shimmer.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../controller/purchase_controller.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    PaymentMethods paymentMethods = PaymentMethods.payDirectly;
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
                final response =
                    CloudHelperFunctions.checkSingleStateRecord(snapshot: snapshot, shimmerEffect: HorizontalProductShimmerEffect());

                if (response != null) return response;

                final customer = snapshot.data!;

                return InfomationCard(
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

            // --- Payment Method
            InfomationCard(
              title: 'Chọn hình thức thanh toán',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Thanh Toán Trực Tiếp'),
                    leading: Radio(
                        value: PaymentMethods.payDirectly,
                        groupValue: paymentMethods,
                        onChanged: (value) {}),
                  ),
                  ListTile(
                    title: Text('Visa'),
                    leading: Radio(
                        value: PaymentMethods.visa,
                        groupValue: paymentMethods,
                        onChanged: (value) {}),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Service Infomation
            InfomationCard(
              title: 'Thông tin dịch vụ',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.serviceName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: AppSize.small),
                  Row(
                    children: [
                      Text(
                        order.dateStart,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: AppSize.spaceBtwItems),
                      Text(
                        order.timeStart,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Price Detail
            InfomationCard(
              hideButton: true,
              title: 'Chi tiết thanh toán',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Giá dịch vụ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      ProductPriceText(
                          price: order.totalPrice.toString(), isLarge: false),
                    ],
                  ),
                  SizedBox(height: AppSize.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phí phụ thu',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      ProductPriceText(
                          price:
                              PricingCalculator.calculateFee(order.totalPrice)
                                  .toString(),
                          isLarge: false),
                    ],
                  ),
                  SizedBox(height: AppSize.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng thành tiền',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      ProductPriceText(price: totalAmount.toString()),
                    ],
                  ),
                ],
              ),
            ),
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
