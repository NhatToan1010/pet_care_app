import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../../common/widgets/images/rounded_rect_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../model/services/service_model.dart';

class ServiceImageDisplay extends StatelessWidget {
  const ServiceImageDisplay({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoundedRectImage(
          defaultRadius: false,
          borderRadius: BorderRadius.all(Radius.zero),
          imageUrl: service.imageUrl,
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 5,
          left: 0,
          right: 0,
          child: CustomAppbar(
            leadingColor: AppPallete.blackColor,
            showBackArrow: true,
            iconBackgroundColor: AppPallete.whiteColor,
            actions: [
              CircularIcon(
                icon: Iconsax.heart,
                iconColor: AppPallete.blackColor,
                backgroundColor: AppPallete.whiteColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
