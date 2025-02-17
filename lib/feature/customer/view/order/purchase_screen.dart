import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/common/widgets/texts/product_text/product_price_text.dart';
import 'package:pet_care_app/feature/customer/view/order/widgets/infomation_card.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../utils/constants/enums.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentMethods paymentMethods = PaymentMethods.payDirectly;

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
              InfomationCard(
                title: 'Thông tin đơn hàng',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Từ Nhật Toàn | 0793960058',
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
                      'Dắt chó đi dạo',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: AppSize.small),
                    Text(
                      DateTime.now().toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: AppSize.small),
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
                        ProductPriceText(price: '150.000', isLarge: false),
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
                        ProductPriceText(price: '15.000', isLarge: false),
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
                        ProductPriceText(price: '165.000'),
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
            child: ElevatedButton(onPressed: () {}, child: Text('ĐẶT HÀNG')),
          ),
        ));
  }
}
