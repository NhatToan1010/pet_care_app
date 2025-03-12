import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/feature/customer/model/services/dog_walking_model.dart';

import '../../../../../utils/validators/validations.dart';
import '../../../controller/order_controller.dart';
import '../../../controller/service_controller.dart';
import '../../../model/services/service_model.dart';

class DogWalkingService extends StatelessWidget {
  const DogWalkingService({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dogWalkingService = service as DogWalkingModel;
    final serviceController = ServiceController.instance;
    final orderController = OrderController.instance;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Walk Location
          Form(
            key: orderController.serviceFormKey,
            child: TextFormField(
              controller: orderController.walkLocation,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.location, size: 24),
                label: Text('Địa điểm đi dạo', style: textTheme.bodyLarge),
              ),
              validator: (value) => Validator.validateEmptyText('Địa điểm đi dạo', value),
            ),
          ),
        ],
      ),
    );
  }
}
