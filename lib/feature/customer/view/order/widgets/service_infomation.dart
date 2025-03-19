import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../model/order_model.dart';
import 'infomation_card.dart';

class ServiceInfomation extends StatelessWidget {
  const ServiceInfomation({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfomationCard(
          hideButton: true,
          title: 'Thông tin dịch vụ',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.serviceName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: AppSize.small),

              // =---= Specific Service Information
              if (order.walkLocation != null && order.serviceName == 'Dắt Chó Đi Dạo') ... [
                Text(
                  order.walkLocation ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: AppSize.small),
              ],

              if (order.listActivity != null && (order.serviceName == 'Chăm Sóc Thú Cưng Tại Nhà' || order.serviceName == 'Chăm Sóc Chó Tại Trung Tâm')) ... [
                Text(
                  order.listActivity!.join(', '),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: AppSize.small),
              ],

              if (order.pickUpLocation != null && order.dropOffLocation != null && order.serviceName == 'Đưa Đón Thú Cưng') ... [
                Text(
                  '${order.pickUpLocation} - ${order.dropOffLocation}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: AppSize.small),
              ],

              // =---= Booking Date and Time
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
      ],
    );
  }
}
