import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:pet_care_app/common/widgets/images/circle_image.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/feature/personalization/user_controller.dart';
import 'package:pet_care_app/feature/personalization/view/profile/update_user_profile.dart';
import 'package:pet_care_app/feature/personalization/view/profile/widgets/profile_menu_item.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationRepository.instance;
    final userController = UserController.instance;
    final user = userController.user.value;
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
                      showBackArrow: true,
                      title: Text(
                        'Hồ Sơ Người Dùng',
                        style: textTheme.titleMedium
                            ?.apply(color: AppPallete.whiteColor),
                      ),
                    ),
                    CircleImage(
                      imageUrl: user.avatarURL!.isEmpty
                          ? 'assets/images/customers/default_avatar.jpg'
                          : user.avatarURL!,
                      fit: BoxFit.cover,
                      width: 72,
                      height: 72,
                    ),
                    SizedBox(height: AppSize.small),
                    TextButton(
                      onPressed: () => userController.uploadUserImage(),
                      child: Text(
                        'Cập Nhật Ảnh Đại Diện',
                        style: textTheme.labelLarge
                            ?.apply(color: AppPallete.whiteColor),
                      ),
                    ),
                    SizedBox(height: AppSize.spaceBtwItems),

                    TextButton(
                      onPressed: () => Get.offAll(() => UpdateUserProfileScreen()),
                      child: Text(
                        'Cập Nhật Thông Tin Cá Nhân',
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
                    subtitle: user.firstName,
                  ),
                  SizedBox(height: AppSize.spaceBtwItems),
                  ProfileMenuItem(
                      leadingIcon: Iconsax.direct,
                      title: 'Địa Chỉ Email',
                      subtitle: auth.authUser!.email.toString()),
                  SizedBox(height: AppSize.spaceBtwItems),
                  ProfileMenuItem(
                      leadingIcon: Iconsax.mobile,
                      title: 'Số Điện Thoại',
                      subtitle: user.phoneNumber),
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
