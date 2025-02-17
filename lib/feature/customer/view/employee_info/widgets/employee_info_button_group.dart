import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';


class EIButtonGroup extends StatelessWidget {
  const EIButtonGroup({
    super.key,
  });

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
          onPressed: () {},
          child: Wrap(
            spacing: AppSize.small,
            children: [Icon(Iconsax.message, color: AppPallete.primary,), Text('Nhắn Tin'),],
          ),
        ),
      ],
    );
  }
}