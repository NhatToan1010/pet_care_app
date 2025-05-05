import 'package:flutter/material.dart';
import 'package:pet_care_app/feature/customer/model/review_model.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/product_cart/ratings/custom_rating_bar_indicator.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
    required this.review,
  });

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            review.avatar ??
                'assets/images/customers/default_avatar.jpg',
          ),
        ),
        SizedBox(width: AppSize.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRatingBarIndicator(
              itemSize: 15.0,
              rating: review.ratingScore.toDouble(),
            ),
            SizedBox(height: AppSize.small),
            Text(
              review.userName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSize.small),
            Text(
              review.comment,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}