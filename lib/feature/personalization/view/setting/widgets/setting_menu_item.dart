import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SettingMenuItem extends StatelessWidget {
  const SettingMenuItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onPressed,
  });

  final IconData leadingIcon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSize.medium,
            children: [
              Container(
                padding: EdgeInsets.all(AppSize.small),
                decoration: BoxDecoration(
                  color: AppPallete.greyColor.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(leadingIcon),
              ),
              Text(
                title,
                style: textTheme.bodyMedium,
              )
            ],
          ),
          Icon(Icons.arrow_forward_ios_sharp),
        ],
      ),
    );
  }
}
