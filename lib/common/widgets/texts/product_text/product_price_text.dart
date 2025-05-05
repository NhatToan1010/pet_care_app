import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/constants/colors.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currencySign = 'đ',
    required this.price,
    this.maxLines = 1,
    this.isLarge = true,
    this.lineThrough = false,
    this.textColor = AppPallete.textPrimary,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge, lineThrough;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      price + currencySign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.titleSmall!.apply(
              color: textColor,
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.bodyLarge!.apply(
              color: textColor,
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
