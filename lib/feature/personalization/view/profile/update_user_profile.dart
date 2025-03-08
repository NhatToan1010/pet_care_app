import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/feature/personalization/controller/user_controller.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

class UpdateUserProfileScreen extends StatelessWidget {
  const UpdateUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userController = UserController.instance;

    return Scaffold(
      appBar: CustomAppbar(
        title: Text('Cập nhật thông tin người dùng'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          children: [
            // --- First & Last name
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: AppSize.spaceBtwInputField,
              direction: Axis.horizontal,
              children: [
                TextFormField(
                  controller: userController.newFirstName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.profile_2user),
                    label: Text(
                      'Tên',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
                TextFormField(
                  controller: userController.newLastName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.profile_2user),
                    label: Text(
                      'Họ và tên đệm',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwInputField),

            // --- Phone Number
            TextFormField(
              controller: userController.newPhoneNumer,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.mobile),
                label: Text(
                  'Số điện thoại',
                  style: textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: AppSize.spaceBtwInputField),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  userController.updateUserProfile();
                },
                child: Text('Cập nhật'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
