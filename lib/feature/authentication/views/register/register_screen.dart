import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/feature/authentication/controllers/register_controller.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/title_text.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/validators/validations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(RegisterController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultSpace),
        child: SizedBox(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // --- Title
              TitleTextWidget(
                title: 'Tạo Tài Khoản',
                subtitle: LocalTexts.onboardingSubtitle,
              ),

              // --- Form Field
              Form(
                key: controller.registerKey,
                child: Column(
                  children: [
                    // --- First & Last name
                    TextFormField(
                      controller: controller.fullName,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.profile_2user),
                        label: Text(
                          'Tên Khách Hàng',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      validator: (value) =>
                          Validator.validateEmptyText('Tên Khách Hàng', value),
                    ),
                    SizedBox(height: AppSize.spaceBtwInputField),

                    // --- Email
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.direct),
                        label: Text(
                          'Email',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      validator: (value) => Validator.validateEmail(value),
                    ),
                    SizedBox(height: AppSize.spaceBtwInputField),

                    // --- Phone Number
                    TextFormField(
                      controller: controller.phoneNo,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        label: Text(
                          'Số Điện Thoại',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      validator: (value) => Validator.validatePhoneNumber(value),
                    ),
                    SizedBox(height: AppSize.spaceBtwInputField),

                    // --- Password
                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () => controller.isHidedPassword.value =
                                !controller.isHidedPassword.value,
                            icon: Icon(
                              controller.isHidedPassword.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                            ),
                          ),
                          label: Text(
                            'Mật Khẩu',
                            style: textTheme.bodyMedium,
                          ),
                        ),
                        obscureText: controller.isHidedPassword.value,
                        validator: (value) => Validator.validatePassword(value),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.register(),
                  child: Text('Đăng Ký'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
