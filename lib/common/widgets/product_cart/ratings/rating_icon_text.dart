import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/constants/colors.dart';

class RatingIconText extends StatelessWidget {
  const RatingIconText({
    super.key,
    this.iconSize = 16.0,
    this.fontColor = AppPallete.textPrimary,
    this.ratingScore,
  });

  final double iconSize;
  final double? ratingScore;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (ratingScore! > 0)
          Icon(Icons.star_rounded, color: Colors.amber, size: iconSize),
        Text(
          ' ${ratingScore! > 0 ? ratingScore.toString() : '0 đánh giá'}',
          style: ratingScore! > 0 ? Theme.of(context).textTheme.titleSmall?.apply(color: fontColor) : Theme.of(context).textTheme.bodyMedium?.apply(color: fontColor),
        ),
      ],
    );
  }
}
