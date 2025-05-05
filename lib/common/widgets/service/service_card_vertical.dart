import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:pet_care_app/common/widgets/icons/circular_icon.dart';
import 'package:pet_care_app/common/widgets/product_cart/ratings/rating_icon_text.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../images/rounded_rect_image.dart';
import '../texts/product_text/product_price_text.dart';
import '../texts/title_text.dart';

class ServiceCardVertical extends StatelessWidget {
  const ServiceCardVertical(
      {super.key, required this.onPressed, required this.service});

  final VoidCallback? onPressed;
  final ServiceModel service;

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
              imageUrl: service.imageUrl,
              fit: BoxFit.cover,
              radius: 10,
              height: 300,
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    AppPallete.transparentColor,
                    AppPallete.blackColor,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
                    title: service.name,
                    subtitle: service.description,
                    fontColor: AppPallete.textWhite,
                  ),
                  SizedBox(height: AppSize.extraSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingIconText(
                        ratingScore: service.averageRating?.roundToDouble(),
                        iconSize: 16,
                        fontColor: AppPallete.textWhite,
                      ),
                      Row(
                        children: [
                          ProductPriceText(
                            price: service.price.toString(),
                            isLarge: false,
                            currencySign: 'đ',
                            textColor: AppPallete.textWhite,
                          ),
                          Text(
                            '/Thú',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(color: AppPallete.textWhite),
                          )
                        ],
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
