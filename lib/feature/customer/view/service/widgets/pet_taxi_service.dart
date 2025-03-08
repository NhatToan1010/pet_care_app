import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validations.dart';
import '../../../controller/order_controller.dart';
import '../../../controller/service_controller.dart';
import '../../../model/services/pet_taxi_model.dart';

class PetTaxiService extends StatelessWidget {
  const PetTaxiService({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final petTaxiService = service as PetTaxiModel;
    final serviceController = ServiceController.instance;
    final orderController = OrderController.instance;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Walk Location
          Form(
            key: orderController.serviceFormKey,
            child: Column(
              children: [
                // --- Pick Up Location
                TextFormField(
                  controller: orderController.pickUpLocation,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.location, size: 24),
                    label: Text('Địa điểm đón', style: textTheme.bodyLarge),
                  ),
                  validator: (value) => Validator.validateEmptyText('Địa điểm đón', value),
                ),
                SizedBox(height: AppSize.spaceBtwInputField),

                // --- Drop Off Location
                TextFormField(
                  controller: orderController.dropOffLocation,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.location, size: 24),
                    label: Text('Địa điểm trả', style: textTheme.bodyLarge),
                  ),
                  validator: (value) => Validator.validateEmptyText('Địa điểm trả', value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
