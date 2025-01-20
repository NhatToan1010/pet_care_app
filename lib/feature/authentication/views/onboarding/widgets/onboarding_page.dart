import 'package:flutter/material.dart';

import '../../../../../common/widgets/images/rounded_rect_image.dart';
import '../../../../../utils/constants/sizes.dart';

class OnboadingPage extends StatelessWidget {
  const OnboadingPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
  });

  final String title;
  final String imageUrl;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Title
        SizedBox(
          width: 400,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
            maxLines: 3,
          ),
        ),
        SizedBox(height: AppSize.spaceBtwItems),

        // --- Image
        Center(
          child: RoundedRectImage(
            imageUrl: imageUrl,
            height: 200,
          ),
        ),
        SizedBox(height: AppSize.spaceBtwItems),

        // --- Subtitle
        Expanded(
          child: Center(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ],
    );
  }
}
