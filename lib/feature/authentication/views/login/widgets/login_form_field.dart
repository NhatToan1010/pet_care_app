import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validations.dart';
import '../../../controllers/login_controller.dart';

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = LoginController.instance;

    return Form(
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
    );
  }
}