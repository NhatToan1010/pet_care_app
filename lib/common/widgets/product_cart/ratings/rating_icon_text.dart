import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/constants/colors.dart';

class RatingIconText extends StatelessWidget {
  const RatingIconText({
    super.key, this.iconSize = 16.0, this.fontColor = AppPallete.textPrimary,
  });

  final double iconSize;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_rounded,
            color: Colors.amber, size: iconSize),
        Text(' 4.5',
            style:
            Theme.of(context).textTheme.bodyLarge?.apply(color: fontColor)),
      ],
    );
  }
}