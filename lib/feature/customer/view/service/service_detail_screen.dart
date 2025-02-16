import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:pet_care_app/common/widgets/employee/employee_card_horizontal.dart';
import 'package:pet_care_app/common/widgets/images/rounded_rect_image.dart';
import 'package:pet_care_app/common/widgets/product_cart/ratings/rating_icon_text.dart';
import 'package:pet_care_app/common/widgets/texts/custom_read_more_text.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/dog_walking_service.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/constants/texts.dart';

import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../utils/constants/colors.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Stack(
                children: [
                  RoundedRectImage(
                    defaultRadius: false,
                    borderRadius: BorderRadius.all(Radius.zero),
                    imageUrl: 'assets/images/services/dog_walking.jpg',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    left: 0,
                    right: 0,
                    child: CustomAppbar(
                      leadingColor: AppPallete.blackColor,
                      showBackArrow: true,
                      iconBackgroundColor: AppPallete.whiteColor,
                      actions: [
                        CircularIcon(
                          icon: Iconsax.heart,
                          iconColor: AppPallete.blackColor,
                          backgroundColor: AppPallete.whiteColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            // --- Service Info Detail
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultSpace,
                vertical: AppSize.small,
              ),
              child: Column(
                children: [
                  // --- Title
                  SectionHeading(
                    title: 'Dắt chó đi dạo',
                    showActionButton: false,
                    largeTitle: true,
                  ),
                  SizedBox(height: AppSize.spaceBtwItems),

                  // --- Rating and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingIconText(iconSize: 24),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '50.000đ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextSpan(
                              text: '/Thú',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSize.small),
                  Divider(),
                  SizedBox(height: AppSize.small),

                  // --- Desciption
                  SectionHeading(title: 'Mô tả dịch vụ', showActionButton: false),
                  SizedBox(height: AppSize.spaceBtwItems),
                  
                  CustomReadMoreText(content: LocalTexts.onboardingSubtitle, trimLines: 3),
                  SizedBox(height: AppSize.spaceBtwSections),

                  // --- Service Info Selection
                  SectionHeading(
                    title: 'Lựa Chọn Cho Dịch Vụ',
                    showActionButton: false,
                  ),
                  SizedBox(height: AppSize.spaceBtwItems),

                  // --- Service Selection
                  DogWalkingService(),
                  SizedBox(height: AppSize.spaceBtwSections),
                  
                  // --- Employee Selection
                  SectionHeading(
                    title: 'Nhân Viên Thực Hiện',
                    showActionButton: false,
                  ),
                  SizedBox(height: AppSize.spaceBtwItems),
                  EmployeeCardHorizontal(onTap: () {}, hideButton: true,)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultSpace, vertical: AppSize.small),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () {}, child: Text('Đặt Lịch Ngay')),
        ),
      ),
    );
  }
}
