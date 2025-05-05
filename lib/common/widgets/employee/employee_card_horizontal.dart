import 'package:flutter/material.dart';

import '../../../feature/personalization/model/user_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/rounded_rect_image.dart';
import '../product_cart/ratings/custom_rating_bar_indicator.dart';
import '../texts/title_text.dart';

class EmployeeCardHorizontal extends StatelessWidget {
  const EmployeeCardHorizontal({
    super.key,
    required this.onTap,
    this.hideButton = false,
    required this.employee,
    this.onChatButtonTap,
  });

  final VoidCallback? onTap, onChatButtonTap;
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
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  radius: 10.0,
                ),
                SizedBox(width: AppSize.spaceBtwItems),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // --- Employee Information Section
                    SizedBox(
                      width: DeviceUtils.getScreenWidth() * 0.5,
                      child: TitleTextWidget(
                        title: employee.fullName,
                        subtitle: 'Nhân Viên Xuất Xắc',
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
                  onPressed: onChatButtonTap,
                  child: Text('Trò Chuyện Ngay'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
