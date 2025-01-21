import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/common/widgets/texts/title_text.dart';
import 'package:pet_care_app/feature/authentication/controllers/login_controller.dart';
import 'package:pet_care_app/feature/authentication/views/login/widgets/login_button.dart';
import 'package:pet_care_app/feature/authentication/views/login/widgets/login_form_field.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/constants/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              LoginFormField(),

              // --- Login Buttons
              LoginButtonSection(),
            ],
          ),
        ),
      ),
    );
  }
}
