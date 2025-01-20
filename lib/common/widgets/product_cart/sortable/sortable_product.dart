import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';

class SortableProduct extends StatelessWidget {
  const SortableProduct({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        // ----- Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.sort),
            label: Text('Filter'),
            fillColor: Colors.transparent,
          ),
          focusColor: Colors.transparent,
          onChanged: (value) {},
          items: ['Name', 'Highest Price', 'Lowest Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: AppSize.spaceBtwSections),

        // ----- Grid Products
        Obx(
        () => GridLayout(
            mainAxisExtent: AppSize.productVerticalAxisExtent,
            itemCount: 1,
            itemBuilder: (_, index) {},
          ),
        )
      ],
    );
  }
}
