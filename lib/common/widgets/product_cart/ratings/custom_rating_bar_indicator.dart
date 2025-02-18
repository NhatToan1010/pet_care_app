import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';

class CustomRatingBarIndicator extends StatelessWidget {
  const CustomRatingBarIndicator({
    super.key,
    required this.rating,
    required this.itemSize,
  });

  final double rating;
  final double itemSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemSize: itemSize,
          unratedColor: AppPallete.greyColor,
          itemBuilder: (_, __) => Icon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
        ),
        SizedBox(width: AppSize.small),
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    );
  }
}
