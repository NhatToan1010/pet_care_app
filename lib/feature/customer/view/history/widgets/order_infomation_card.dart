import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class OrderInfomationCard extends StatelessWidget {
  const OrderInfomationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  'Dắt chó đi dạo',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Icon(Iconsax.more, size: 24),
              ],
            ),
            SizedBox(height: AppSize.extraSmall),
            Text(
              DateTime.now().toString(),
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
                    Text(
                      'Nhân viên',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: AppSize.extraSmall),
                    Text(
                      'Lý Hoàng Nam',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

                // --- Pet
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thú cưng',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: AppSize.small),
                    Text(
                      'Lucky',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Note
            Text(
              'Ghi chú',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: AppSize.extraSmall),
            Text(
              LocalTexts.onboardingSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}