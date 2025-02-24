import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.largeTitle = false,
    this.subtitleMaxLines = 2,
    this.fontColor = AppPallete.textPrimary,
  });

  final String title, subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final bool largeTitle;
  final int subtitleMaxLines;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title,
            style: largeTitle
                ? textTheme.titleLarge?.apply(color: fontColor)
                : textTheme.titleSmall?.apply(color: fontColor)),
        SizedBox(height: AppSize.extraSmall),
        Text(
          subtitle,
          style: textTheme.bodyMedium?.apply(color: fontColor),
          maxLines: subtitleMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
