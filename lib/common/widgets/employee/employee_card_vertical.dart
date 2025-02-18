import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/containers/rounded_container.dart';

import '../images/rounded_rect_image.dart';
import '../product_cart/ratings/rating_icon_text.dart';
import '../texts/title_text.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class EmployeeCardVertical extends StatelessWidget {
  const EmployeeCardVertical({
    super.key, required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppPallete.greyColor.withValues(alpha: 0.5),
      child: RoundedContainer(
        width: 175,
        radius: AppSize.borderRadiusMedium,
        backgroundColor: AppPallete.whiteColor,
        padding: EdgeInsets.all(AppSize.small),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Employee's Avatar
            RoundedRectImage(
              imageUrl:
              'assets/images/employees/employee_1_(crop).png',
              width: 175,
              fit: BoxFit.cover,
              radius: 5.0,
            ),
            SizedBox(height: AppSize.small),

            // --- Employee's Name
            TitleTextWidget(
                title: 'Lý Hoàng Nam',
                subtitle: 'Nhân Viên Xuất Sắc'),
            SizedBox(height: AppSize.small),

            // --- Rating and Year Experience
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingIconText(),
                Row(
                  children: [
                    Icon(Icons.badge_rounded,
                        color: AppPallete.primary, size: 15),
                    Text(' 4 Năm',
                        style:
                        Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

