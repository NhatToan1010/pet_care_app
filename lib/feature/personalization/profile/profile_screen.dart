import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:pet_care_app/common/widgets/images/circle_image.dart';
import 'package:pet_care_app/feature/personalization/profile/widgets/profile_menu_item.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Container(
                color: AppPallete.primary,
                padding: EdgeInsets.all(AppSize.small),
                child: Column(
                  children: [
                    CustomAppbar(
                      title: Text(
                        'Hồ Sơ Người Dùng',
                        style: textTheme.titleMedium
                            ?.apply(color: AppPallete.whiteColor),
                      ),
                    ),
                    CircleImage(
                      imageUrl: 'assets/images/customers/customer_1_(crop).png',
                      fit: BoxFit.cover,
                      width: 72,
                      height: 72,
                    ),
                    SizedBox(height: AppSize.small),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Cập Nhật Ảnh Đại Diện',
                        style: textTheme.labelLarge
                            ?.apply(color: AppPallete.whiteColor),
                      ),
                    ),
                    SizedBox(height: AppSize.spaceBtwSections),
                  ],
                ),
              ),
            ),

            // --- Infomation Sections
            Padding(
              padding: EdgeInsets.all(AppSize.defaultSpace),
              child: Column(
                children: [
                  ProfileMenuItem(
                    onPressed: () {},
                    leadingIcon: Iconsax.user,
                    title: 'Tên Người Dùng',
                    subtitle: 'John Doe',
                  ),
                  SizedBox(height: AppSize.spaceBtwItems),

                  ProfileMenuItem(
                      leadingIcon: Iconsax.direct,
                      title: 'Địa Chỉ Email',
                      subtitle: 'jd@gmail.com'),
                  SizedBox(height: AppSize.spaceBtwItems),

                  ProfileMenuItem(
                      leadingIcon: Iconsax.mobile,
                      title: 'Số Điện Thoại',
                      subtitle: '0912345678'),
                  SizedBox(height: AppSize.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
