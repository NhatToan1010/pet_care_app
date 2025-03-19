import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/routine_model.dart';

class ServiceDateTimeSelection extends StatelessWidget {
  const ServiceDateTimeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateTimeController = Get.put(DateTimeController());

    return Column(
      children: [
        SectionHeading(title: 'Lựa chọn ngày và giờ', showActionButton: false),
        SizedBox(height: AppSize.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => dateTimeController.pickDate(context),
                    child: Text(
                      dateTimeController.selectedDate.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSize.small),
            Expanded(
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => dateTimeController.pickTime(context),
                    child: Text(dateTimeController.selectedTime.value,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
