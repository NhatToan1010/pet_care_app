import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validations.dart';

class DogWalkingService extends StatelessWidget {
  const DogWalkingService({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      child: Column(
        children: [

          // --- Walk Location
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.location, size: 24,),
              label: Text(
                'Địa điểm đi dạo',
                style: textTheme.bodyLarge,
              ),
            ),
            validator: (value) => Validator.validateEmptyText('Địa điểm đi dạo', value),
          ),
          SizedBox(height: AppSize.spaceBtwInputField),

          // --- Pet Size
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.pet, size: 24,),
              label: Text(
                'Kích thước chó nuôi',
                style: textTheme.bodyLarge,
              ),
            ),
            validator: (value) => Validator.validateEmptyText('Kích thước chó nuôi', value),
          ),
        ],
      ),
    );
  }
}
