import 'package:flutter/material.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class EmployeeOrderCard extends StatelessWidget {
  const EmployeeOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  'Đang xử lý',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Service Info
            Text(
              'Dắt chó đi dạo',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: AppSize.small),

            Text(
              DateTime.now().toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}