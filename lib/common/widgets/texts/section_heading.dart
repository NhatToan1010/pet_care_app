import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/constants/colors.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle = 'Xem thêm',
    this.onPressed,
    this.maxLines = 2,
    this.largeTitle = false,
  });

  final Color? textColor;
  final bool showActionButton, largeTitle;
  final String title, buttonTitle;
  final VoidCallback? onPressed;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: largeTitle
              ? Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: textColor)
              : Theme.of(context).textTheme.titleLarge!.apply(color: textColor),
          textAlign: TextAlign.start,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: AppPallete.primary),
              textAlign: TextAlign.end,
            ),
          ),
      ],
    );
  }
}
