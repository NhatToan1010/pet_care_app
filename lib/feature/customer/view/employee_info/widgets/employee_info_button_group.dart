import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/feature/personalization/model/user_model.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/view/message/message_screen.dart';


class EIButtonGroup extends StatelessWidget {
  const EIButtonGroup({
    super.key, required this.employee,
  });

  final UserModel employee;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // --- Call Button
        OutlinedButton(
          onPressed: () {},
          child: Wrap(
            spacing: AppSize.small,
            children: [Icon(Icons.phone, color: AppPallete.primary,), Text('Liên Hệ'),],
          ),
        ),
        SizedBox(width: AppSize.spaceBtwItems),

        // --- Chat Button
        OutlinedButton(
          onPressed: () => Get.to(() => MessageScreen(contactUser: employee,)),
          child: Wrap(
            spacing: AppSize.small,
            children: [Icon(Iconsax.message, color: AppPallete.primary,), Text('Nhắn Tin'),],
          ),
        ),
      ],
    );
  }
}