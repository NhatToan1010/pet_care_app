import 'package:flutter/material.dart';

import '../../../../common/widgets/images/rounded_rect_image.dart';
import '../../../../common/widgets/texts/title_text.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppPallete.greyColor.withValues(alpha: 0.5),
      child: Container(
        width: 175,
        decoration: BoxDecoration(
            color: AppPallete.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(AppSize.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Employee's Avatar
            RoundedRectImage(
              imageUrl:
              'assets/images/employees/employee_1_(crop).png',
              width: 175,
              fit: BoxFit.cover,
              borderRadius: 5.0,
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
                Row(
                  children: [
                    Icon(Icons.star_rounded,
                        color: Colors.amber, size: 15),
                    Text(' 4.5',
                        style:
                        Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
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