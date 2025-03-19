import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controller/order_controller.dart';
import '../../../model/services/pet_sitting_model.dart';

class PetSittingService extends StatelessWidget {
  const PetSittingService({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final petSitting = service as PetSittingModel;
    final orderController = OrderController.instance;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(title: 'Lựa chọn hoạt động', showActionButton: false),
          SizedBox(height: AppSize.spaceBtwItems),
          GridLayout(
            mainAxisExtent: 50,
            itemCount: petSitting.activities.length,
            itemBuilder: (context, index) {
              final item = petSitting.activities[index];
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
