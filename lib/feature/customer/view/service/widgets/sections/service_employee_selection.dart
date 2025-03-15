import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/employee/employee_card_horizontal.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../personalization/controller/user_controller.dart';
import '../../../employee_info/list_employee.dart';

class ServiceEmployeeSelection extends StatelessWidget {
  const ServiceEmployeeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;

    return Column(
      children: [
        SectionHeading(title: 'Nhân Viên Thực Hiện', showActionButton: false),
        SizedBox(height: AppSize.spaceBtwItems),
        Obx(
          () {
            if (userController.selectedEmployee.value.id.isEmpty) {
              return ListTile(
                leading: Icon(Iconsax.add),
                title: Text('Chọn Nhân Viên'),
                onTap: () => Get.to(
                  () => Padding(
                    padding: const EdgeInsets.all(AppSize.defaultSpace),
                    child: ListEmployee(),
                  ),
                ),
              );
            }
            return EmployeeCardHorizontal(
              onTap: () => Get.to(
                () => Padding(
                  padding: const EdgeInsets.all(AppSize.defaultSpace),
                  child: ListEmployee(),
                ),
              ),
              employee: userController.selectedEmployee.value,
            );
          },
        ),
      ],
    );
  }
}
