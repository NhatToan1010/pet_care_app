import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/circle_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class EIAppBar extends StatelessWidget {
  const EIAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: Container(
        color: AppPallete.primary,
        padding: EdgeInsets.all(AppSize.small),
        child: Column(
          children: [
            CustomAppbar(
              centerTitle: true,
              title: Text(
                'Thông Tin Nhân Viên',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.apply(color: AppPallete.whiteColor),
              ),
              actions: [
                CircularIcon(
                  icon: Iconsax.heart,
                  iconColor: AppPallete.whiteColor,
                )
              ],
              showBackArrow: true,
              leadingColor: AppPallete.whiteColor,
            ),

            // --- Employee Avatar
            CircleImage(
              imageUrl: 'assets/images/employees/employee_3.jpg',
              backgroundColor: AppPallete.whiteColor,
              padding: EdgeInsets.all(AppSize.small),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),

            SizedBox(height: AppSize.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
