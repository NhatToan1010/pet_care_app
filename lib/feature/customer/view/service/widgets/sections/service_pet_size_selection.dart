import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pet_care_app/common/widgets/texts/title_text.dart';

import '../../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/order_controller.dart';
import '../../../../controller/service_controller.dart';
import '../../../../model/services/service_model.dart';

class ServicePetSizeSelection extends StatelessWidget {
  const ServicePetSizeSelection({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final serviceController = ServiceController.instance;
    final orderController = OrderController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: 'Kích thước thú cưng', showActionButton: false),
        SizedBox(height: AppSize.spaceBtwItems),
        Obx(
          () => Wrap(
            spacing: AppSize.small,
            children: service.petSizes.map(
              (item) {
                final isSelected = orderController.selectedSize.value == item;

                final convertItem = serviceController.convertSize(item);
                return CustomChoiceChip(
                  label: convertItem,
                  selected: isSelected,
                  onSelected: (selectedItem) =>
                      orderController.onPetSizeSelected(item),
                );
              },
            ).toList(),
          ),
        ),
        SizedBox(height: AppSize.spaceBtwItems),
        TitleTextWidget(
          title: 'Phân loại kích thước',
          subtitle: 'Nhỏ: dưới 3kg\nVừa: từ 3kg đến 5kg\nLớn: trên 5kg',
          subtitleMaxLines: 3,
        ),
      ],
    );
  }
}
