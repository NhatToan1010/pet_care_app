import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/icons/circular_icon.dart';
import 'package:pet_care_app/common/widgets/images/rounded_rect_image.dart';
import 'package:pet_care_app/common/widgets/layouts/grid_layout.dart';
import 'package:pet_care_app/common/widgets/service/service_card_vertical.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/common/widgets/texts/title_text.dart';
import 'package:pet_care_app/common/widgets/employee/employee_card_vertical.dart';
import 'package:pet_care_app/feature/customer/view/home/widgets/home_category.dart';
import 'package:pet_care_app/feature/personalization/user_controller.dart';

import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../../common/widgets/search_bar/search_bar.dart';
import '../category/category_screen.dart';
import '../employee_info/employee_info_screen.dart';
import '../service/service_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final user = userController.user.value;

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
                    title: 'Xin Chào, ${user.firstName}',
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
            HomeCategory(
              onPressed: () => Get.to(() => CategoryScreen()),
            ),
            SizedBox(height: AppSize.spaceBtwSections),

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
                  return EmployeeCardVertical(
                    onTap: () => Get.to(() => EmployeeInfoScreen()),
                  );
                },
              ),
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Service List
            SectionHeading(title: 'Dịch Vụ Nổi Bật'),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Service Cards
            GridLayout(
              itemCount: 4,
              itemBuilder: (context, index) => ServiceCardVertical(
                onPressed: () => Get.to(() => ServiceDetailScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
