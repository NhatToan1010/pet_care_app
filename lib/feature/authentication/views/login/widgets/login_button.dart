import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/login_controller.dart';
import '../../register/register_screen.dart';

class LoginButtonSection extends StatelessWidget {
  const LoginButtonSection({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = LoginController.instance;

    return Column(
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
        )
      ],
    );
  }
}