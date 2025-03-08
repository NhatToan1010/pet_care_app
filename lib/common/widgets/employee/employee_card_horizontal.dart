import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../feature/authentication/models/user_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../icons/circular_icon.dart';
import '../images/rounded_rect_image.dart';
import '../product_cart/ratings/custom_rating_bar_indicator.dart';
import '../texts/title_text.dart';

class EmployeeCardHorizontal extends StatelessWidget {
  const EmployeeCardHorizontal({
    super.key,
    required this.onTap,
    this.hideButton = false, required this.employee,
  });

  final VoidCallback onTap;
  final bool hideButton;
  final UserModel employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppPallete.greyColor,
      child: RoundedContainer(
        radius: AppSize.borderRadiusMedium,
        padding: EdgeInsets.all(AppSize.small),
        backgroundColor: AppPallete.whiteColor,
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                // --- Employee Image
                RoundedRectImage(
                  imageUrl: employee.avatarURL ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  radius: 10.0,
                ),
                SizedBox(width: AppSize.spaceBtwItems),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // --- Employee Infomation Section
                    SizedBox(
                      width: DeviceUtils.getScreenWidth() * 0.62,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleTextWidget(
                            title: employee.fullName,
                            subtitle: 'Nhân Viên Xuất Xắc',
                          ),
                          CircularIcon(
                            icon: Iconsax.heart,
                            size: 24,
                            iconColor: AppPallete.primary,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: AppSize.small),

                    // --- Rating Bar
                    CustomRatingBarIndicator(rating: 4.5, itemSize: 10),
                    SizedBox(height: AppSize.small),
                  ],
                )
              ],
            ),
            SizedBox(height: AppSize.small),

            // --- Chat Now Button
            if (hideButton)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {}, child: Text('Trò Chuyện Ngay')),
              ),
          ],
        ),
      ),
    );
  }
}
