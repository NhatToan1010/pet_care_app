import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:pet_care_app/common/widgets/icons/circular_icon.dart';
import 'package:pet_care_app/common/widgets/product_cart/ratings/rating_icon_text.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../images/rounded_rect_image.dart';
import '../texts/title_text.dart';

class ServiceCardVertical extends StatelessWidget {
  const ServiceCardVertical({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppPallete.greyColor,
      child: RoundedContainer(
        onTap: onPressed,
        radius: 10,
        child: Stack(
          children: [
            RoundedRectImage(
              imageUrl: 'assets/images/services/pet_sitting.jpg',
              fit: BoxFit.cover,
              radius: 10,
              height: 250,
            ),
            Opacity(
              opacity: 0.35,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      AppPallete.transparentColor,
                      AppPallete.blackColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  ),
                ),
              ),
            ),

            // --- Rating and Favorite Button
            Positioned(
              top: 0,
              right: 0,
              child: CircularIcon(
                icon: Iconsax.heart,
                iconColor: Colors.redAccent,
                size: 16,
                onPressed: () {},
              ),
            ),

            Positioned(
              bottom: 5,
              left: 8,
              right: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- Title
                  TitleTextWidget(
                    title: 'Dắt Chó Đi Dạo',
                    subtitle: 'Giúp thú cưng của bạn vui vẻ mỗi ngày',
                    fontColor: AppPallete.textWhite,
                  ),
                  SizedBox(height: AppSize.extraSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingIconText(
                        iconSize: 16,
                        fontColor: AppPallete.textWhite,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '150.000đ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.apply(color: AppPallete.textWhite),
                            ),
                            TextSpan(
                              text: '/Buổi',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.apply(color: AppPallete.textWhite),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.extraSmall),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
