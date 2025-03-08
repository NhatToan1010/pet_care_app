import 'package:flutter/material.dart';

import '../../../../../../common/widgets/texts/custom_read_more_text.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/services/service_model.dart';

class ServiceDescription extends StatelessWidget {
  const ServiceDescription({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(title: 'Mô tả dịch vụ', showActionButton: false),
        SizedBox(height: AppSize.spaceBtwItems),
        CustomReadMoreText(content: service.description, trimLines: 3),
      ],
    );
  }
}
