import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/feature/customer/model/order_model.dart';
import 'package:pet_care_app/feature/personalization/model/user_model.dart';
import 'package:pet_care_app/utils/popups/dialog.dart';

import '../../../feature/customer/controller/order_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen(
      {super.key, required this.order, required this.employee});

  final OrderModel order;
  final UserModel employee;

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.instance;

    return Scaffold(
      appBar: CustomAppbar(
        title: Text('Chi Tiết Đơn Hàng'),
        showBackArrow: true,
      ),
      body: RoundedContainer(
        radius: AppSize.borderRadiusMedium,
        padding: EdgeInsets.all(AppSize.medium),
        backgroundColor: AppPallete.softGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Service Name + Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Tên dịch vụ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: AppSize.extraSmall),
                    Text(
                      order.serviceName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Giá tiền dịch vụ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: AppSize.extraSmall),
                    Text(
                      order.totalPrice.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thời gian đặt hàng',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: AppSize.extraSmall),
                Text(
                  '${order.timeStart} - ${order.dateStart}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            if (order.walkLocation != null && order.serviceName == 'Dắt Chó Đi Dạo') ... [
              Text(
                'Địa điểm đi dạo',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: AppSize.extraSmall),
              Text(
                order.walkLocation ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            if (order.listActivity != null && (order.serviceName == 'Chăm Sóc Thú Cưng Tại Nhà' || order.serviceName == 'Chăm Sóc Chó Tại Trung Tâm')) ... [
              Text(
                'Danh sách hoạt động',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: AppSize.extraSmall),

              Text(
                order.listActivity!.join(', '),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            if (order.pickUpLocation != null && order.dropOffLocation != null && order.serviceName == 'Đưa Đón Thú Cưng') ... [
              Text(
                'Địa điểm đón và trả thú cưng',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: AppSize.extraSmall),

              Text(
                '${order.pickUpLocation} - ${order.dropOffLocation}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            SizedBox(height: AppSize.spaceBtwItems),


            // --- Employee & Pet
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- Employee
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nhân viên',
                        style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: AppSize.extraSmall),
                    Text(
                      employee.fullName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

                // --- Pet
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Thú cưng',
                        style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: AppSize.small),
                    Text('Lucky',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Note
            Text('Ghi chú', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: AppSize.extraSmall),
            Text('Không có ghi chú', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
      bottomNavigationBar: order.status == OrderStatus.pending
          ? Padding(
            padding: const EdgeInsets.all(AppSize.medium),
            child: OutlinedButton(
                onPressed: () => CustomDialog.alertDialog(
                      title: 'Hủy Đơn Hàng',
                      message: 'Bạn có chắc chắn muốn hủy đơn hàng này?',
                      onPressed: () => orderController.updateOrderStatus(order, OrderStatus.canceled)
                    ),
                child: Text('Hủy Đơn Hàng')),
          )
          : null,
    );
  }
}
