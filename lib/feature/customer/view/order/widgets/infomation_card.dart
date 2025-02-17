import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class InfomationCard extends StatelessWidget {
  const InfomationCard({
    super.key,
    this.hideButton = false,
    required this.title,
    required this.child,
  });


  final bool hideButton;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shadowColor: AppPallete.greyColor,
      child: RoundedContainer(
        padding: EdgeInsets.all(AppSize.medium),
        radius: AppSize.borderRadiusMedium,
        backgroundColor: AppPallete.softGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (hideButton == false)
                  OutlinedButton(onPressed: () {}, child: Text('Thay đổi'))
              ],
            ),
            SizedBox(height: AppSize.spaceBtwItems),
            child,
          ],
        ),
      ),
    );
  }
}