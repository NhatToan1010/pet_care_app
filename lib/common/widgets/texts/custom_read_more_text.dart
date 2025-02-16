import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:readmore/readmore.dart';

class CustomReadMoreText extends StatelessWidget {
  const CustomReadMoreText({
    super.key,
    required this.content,
    required this.trimLines,
  });

  final String content;
  final int trimLines;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      textAlign: TextAlign.start,
      content,
      style: Theme.of(context).textTheme.bodyLarge,
      colorClickableText: AppPallete.primary,
      trimLines: trimLines,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' Nhiều hơn',
      trimExpandedText: ' Ít đi',
      moreStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppPallete.primary,
      ),
      lessStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppPallete.primary,
      ),
    );
  }
}
