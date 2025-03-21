import 'package:flutter/material.dart';

import '../../../../../../common/widgets/product_cart/ratings/rating_icon_text.dart';
import '../../../../../../common/widgets/texts/product_text/product_price_text.dart';
import '../../../../model/services/service_model.dart';

class ServiceRatingAndPrice extends StatelessWidget {
  const ServiceRatingAndPrice({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingIconText(ratingScore: service.averageRating, iconSize: 24),
            Row(
              children: [
                ProductPriceText(
                  price: service.price.toString(),
                  currencySign: 'đ',
                ),
                Text(
                  '/Thú',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}