import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/feature/personalization/profile/profile_screen.dart';
import 'package:pet_care_app/feature/personalization/setting/widgets/setting_menu_item.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../common/widgets/appbar/custom_appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text(
          'Cài Đặt',
          style: textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          children: [
            // --- Account Setting Sections
            SectionHeading(title: 'Cài Đặt Tài Khoản', showActionButton: false),
            SizedBox(height: AppSize.spaceBtwItems),

            SettingMenuItem(
              onPressed: () => Get.to(() => ProfileScreen()),
              leadingIcon: Iconsax.user,
              title: 'Tài Khoản',
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            SettingMenuItem(
              leadingIcon: Iconsax.clock,
              title: 'Lịch Sử Đặt Dịch Vụ',
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            SettingMenuItem(
              leadingIcon: Iconsax.location,
              title: 'Quản Lý Địa Chỉ',
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            SettingMenuItem(
              leadingIcon: Iconsax.card_coin,
              title: 'Phương Thức Thanh Toán',
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Help Sections
            SectionHeading(title: 'Giúp Đỡ', showActionButton: false),
            SizedBox(height: AppSize.spaceBtwItems),

            SettingMenuItem(
              leadingIcon: Iconsax.call,
              title: 'Liên Hệ',
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            SettingMenuItem(
              leadingIcon: Iconsax.lifebuoy,
              title: 'FAQ',
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: () {}, child: Text('Đăng Xuất')),
            )
          ],
        ),
      ),
    );
  }
}
