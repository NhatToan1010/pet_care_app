import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/feature/customer/model/order_model.dart';
import 'package:pet_care_app/feature/personalization/controller/user_controller.dart';
import 'package:pet_care_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/orders/order_detail_screen.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class OrderInfomationCard extends StatelessWidget {
  const OrderInfomationCard({
    super.key,
    required this.listOrder,
  });

  final List<OrderModel> listOrder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listOrder.length,
      itemBuilder: (context, index) {
        final order = listOrder[index];
        final employee = UserController.instance.getSpecificUser(order.employeeId);
        return FutureBuilder(
          future: employee,
          builder: (context, snapshot) {
            final response = CloudHelperFunctions.checkSingleStateRecord(snapshot: snapshot);
            if (response != null) return response;

            final employee = snapshot.data!;

            return GestureDetector(
              onTap: () => Get.to(() => OrderDetailScreen(order: order, employee: employee)),
              child: Card(
                elevation: 7,
                shadowColor: AppPallete.greyColor,
                child: RoundedContainer(
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
                          Text(
                            order.serviceName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Icon(Iconsax.more, size: 24),
                        ],
                      ),
                      SizedBox(height: AppSize.extraSmall),
                      Text(
                        '${order.timeStart} - ${order.dateStart}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: AppSize.spaceBtwItems),

                      // --- Employee & Pet
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // --- Employee
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nhân viên', style: Theme.of(context).textTheme.titleSmall),
                              SizedBox(height: AppSize.extraSmall),
                              Text(
                                employee.fullName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),

                          // --- Pet
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Thú cưng', style: Theme.of(context).textTheme.titleSmall),
                              SizedBox(height: AppSize.small),
                              Text('Lucky', style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.spaceBtwItems),

                      // --- Note
                      Text('Ghi chú', style: Theme.of(context).textTheme.titleSmall),
                      SizedBox(height: AppSize.extraSmall),
                      Text('', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
