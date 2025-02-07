import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/icons/circular_icon.dart';
import 'package:pet_care_app/common/widgets/images/rounded_rect_image.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/common/widgets/texts/title_text.dart';
import 'package:pet_care_app/common/widgets/employee/employee_card_vertical.dart';
import 'package:pet_care_app/feature/customer/employee_info/employee_info_screen.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../common/widgets/images/circle_image.dart';
import '../../../common/widgets/search_bar/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleTextWidget(
                    title: 'Xin Chào, John',
                    subtitle: 'Hôm nay thú cưng của bạn thế nào?'),
                CircularIcon(
                  icon: Iconsax.notification,
                  backgroundColor: AppPallete.greyColor,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Search Bar
            CustomSearchBar(),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Banner
            RoundedRectImage(imageUrl: 'assets/images/pet/pet_banner.jpg'),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Categories
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>
                    SizedBox(width: AppSize.small),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleImage(
                        width: 75,
                        height: 75,
                        imageUrl: 'assets/images/icons/dog_walking_full.png',
                        imageColor: AppPallete.primary,
                        backgroundColor: AppPallete.primary.withAlpha(50),
                        padding: EdgeInsets.all(AppSize.medium),
                      ),
                      Text(
                        'Dắt Chó Đi Dạo',
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.apply(color: AppPallete.primary),
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Employees
            SectionHeading(title: 'Nhân Viên Ưu Tú'),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Employee Cards
            SizedBox(
              height: 220,
              width: double.infinity,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>
                    SizedBox(width: AppSize.medium),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return EmployeeCardVertical(onTap: () => Get.to(() => EmployeeInfoScreen()),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


