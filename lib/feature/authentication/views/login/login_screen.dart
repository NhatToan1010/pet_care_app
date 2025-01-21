import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/texts/title_text.dart';
import 'package:pet_care_app/feature/authentication/controllers/login_controller.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/constants/texts.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/validators/validations.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(LoginController());

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
                title: 'Đăng Nhập',
                subtitle: LocalTexts.onboardingSubtitle,
              ),

              // --- Form Field
              Form(
                key: controller.loginKey,
                child: Column(
                  children: [
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

              // --- Login Buttons
              Column(
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Bạn chưa có tài khoản?',
                        style: textTheme.titleSmall,
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => RegisterScreen()),
                        child: Text(
                          'Đăng ký',
                          style: textTheme.titleSmall?.apply(
                            color: AppPallete.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: AppSize.spaceBtwItems),

                  // --- Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.login(),
                      child: Text('Đăng Nhập'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
