import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/common/widgets/layouts/grid_layout.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controller/order_controller.dart';
import '../../../model/services/dog_day_care.dart';

class DogDayCareService extends StatelessWidget {
  const DogDayCareService({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final dogDayCare = service as DogDayCare;
    final orderController = OrderController.instance;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(title: 'Lựa chọn hoạt động', showActionButton: false),
          SizedBox(height: AppSize.spaceBtwItems),
          GridLayout(
            mainAxisExtent: 50,
            itemCount: dogDayCare.activities.length,
            itemBuilder: (context, index) {
              final item = dogDayCare.activities[index];
              return Obx(
                () => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(item),
                  value: orderController.listActivity.contains(item),
                  onChanged: (isChecked) => orderController.onActivitySelected(item, isChecked!),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
