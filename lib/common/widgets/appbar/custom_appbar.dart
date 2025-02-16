import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/icons/circular_icon.dart';
import 'package:pet_care_app/utils/constants/colors.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.leadingColor,
    this.centerTitle = false,
    this.iconBackgroundColor = AppPallete.transparentColor,
  });

  final Widget? title;
  final bool showBackArrow;
  final bool centerTitle;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? leadingColor, iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.medium),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Iconsax.arrow_circle_left),
                style: IconButton.styleFrom(
                    backgroundColor: iconBackgroundColor,
                    foregroundColor: leadingColor),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                    style: IconButton.styleFrom(
                        backgroundColor: iconBackgroundColor,
                        foregroundColor: leadingColor),
                  )
                : null,
        title: title,
        actions: actions,
        centerTitle: centerTitle,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppbarHeight());
}
