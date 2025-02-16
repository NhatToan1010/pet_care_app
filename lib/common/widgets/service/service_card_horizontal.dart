import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../utils/device/device_utility.dart';
import '../icons/circular_icon.dart';
import '../images/rounded_rect_image.dart';
import '../product_cart/ratings/custom_rating_bar_indicator.dart';
import '../texts/title_text.dart';

class ServiceCardHorizontal extends StatelessWidget {
  const ServiceCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppPallete.greyColor,
      child: RoundedContainer(
        radius: AppSize.cardRadiusMedium,
        child: Row(
          children: [
            // --- Service Image
            RoundedRectImage(
              imageUrl: 'assets/images/services/pet_grooming.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              radius: 10.0,
            ),
            SizedBox(width: AppSize.spaceBtwItems),

            // --- Service Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // --- Employee Infomation Section
                SizedBox(
                  width: DeviceUtils.getScreenWidth() * 0.62,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      TitleTextWidget(
                        title: 'Chăm Sóc Thú Tại Nhà',
                        subtitle: 'Dành những điều tốt đẹp đến cho người bạn nhiều lông',
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

                SizedBox(
                  width: DeviceUtils.getScreenWidth() * 0.62,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // --- Rating Bar
                      CustomRatingBarIndicator(rating: 4.5, itemSize: 10),
                      SizedBox(height: AppSize.small),

                      // --- Chat Now Button
                      SizedBox(
                        child: OutlinedButton(
                            onPressed: () {}, child: Text('Xem Thêm')),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
