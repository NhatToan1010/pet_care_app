import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currencySign = 'đ',
    required this.price,
    this.maxLines = 1,
    this.isLarge = true,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      price + currencySign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.titleSmall!.apply(
          decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.bodyLarge!.apply(
          decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}