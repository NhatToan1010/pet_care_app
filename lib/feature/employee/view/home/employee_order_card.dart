import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../customer/model/order_model.dart';

class EmployeeOrderCard extends StatelessWidget {
  const EmployeeOrderCard({
    super.key, required this.order, this.onTap,
  });

  final OrderModel order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 7,
        shadowColor: AppPallete.greyColor,
        child: RoundedContainer(
          radius: AppSize.cardRadiusMedium,
          padding: EdgeInsets.all(AppSize.medium),
          backgroundColor: AppPallete.softGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- Service Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thông tin đơn hàng',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    order.orderStatusText(order),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              SizedBox(height: AppSize.spaceBtwItems),

              // --- Service Info
              Text(
                order.serviceName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: AppSize.small),

              Text(
                '${order.timeStart} - ${order.dateStart}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}