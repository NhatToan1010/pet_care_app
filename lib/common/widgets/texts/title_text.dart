import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.largeTitle = false,
  });

  final String title, subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final bool largeTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title, style: largeTitle ? textTheme.titleLarge : textTheme.titleSmall),
        SizedBox(height: AppSize.extraSmall),

        Text(
          subtitle,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
