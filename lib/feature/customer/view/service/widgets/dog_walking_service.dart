import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/utils/constants/colors.dart';

import '../../../controller/order_controller.dart';
import '../../../model/services/dog_walking_model.dart';
import '../../../model/services/service_model.dart';

class DogWalkingService extends StatelessWidget {
  const DogWalkingService({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.instance;
    final dogWalkingService = service as DogWalkingModel;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Walk Location
          DropdownButtonFormField(
            focusColor: AppPallete.transparentColor,
            onChanged: (value) {
              orderController.selectedWalkLocation.value = value!;
              print(orderController.selectedWalkLocation.value);
            },
            decoration: InputDecoration(
              // label: Text('Vị Trí Đi Dạo'),
              prefixIcon: Icon(Iconsax.location),
              fillColor: AppPallete.transparentColor,
            ),
            hint: Text('Vị Trí Đi Dạo'),
            items: dogWalkingService.walkingLocation
                .map((location) => DropdownMenuItem(value: location, child: Text(location)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
