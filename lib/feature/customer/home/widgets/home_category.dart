import 'package:flutter/material.dart';

import '../../../../common/widgets/images/circle_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key, this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: AppSize.small),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleImage(
                  width: 75,
                  height: 75,
                  imageUrl: 'assets/images/icons/dog_walking_full.png',
                  imageColor: AppPallete.primary,
                  backgroundColor: AppPallete.primary.withAlpha(50),
                  padding: EdgeInsets.all(AppSize.medium),
                ),
                Text(
                  'Hoạt động ngoài trời',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.apply(color: AppPallete.primary),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
