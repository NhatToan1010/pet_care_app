import 'package:flutter/material.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class EIDetail extends StatelessWidget {
  const EIDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- Infomation
        SectionHeading(title: 'Thông Tin Nhân Viên', showActionButton: false),
        SizedBox(height: AppSize.spaceBtwItems),

        // --- Year Experience
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Năm Kinh Nghiệm', style: Theme.of(context).textTheme.bodyMedium,),
            Text('4 Năm', style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 500),),
          ],
        ),
        SizedBox(height: AppSize.spaceBtwItems),

        // --- Pet Served
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thú Cưng Đã Chăm Sóc', style: Theme.of(context).textTheme.bodyMedium,),
            Text('400+', style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 500),),
          ],
        ),
        SizedBox(height: AppSize.spaceBtwSections),

        // --- Description
        SectionHeading(title: 'Tiểu Sử', showActionButton: false),
        SizedBox(height: AppSize.spaceBtwItems),

        Text(LocalTexts.onboardingSubtitle, style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}