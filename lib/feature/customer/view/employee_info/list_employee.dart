import 'package:flutter/material.dart';

import '../../../../common/widgets/employee/employee_card_horizontal.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../personalization/controller/user_controller.dart';

class ListEmployee extends StatelessWidget {
  const ListEmployee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;

    return SizedBox(
      height: DeviceUtils.getScreenHeight(),
      width: double.infinity,
      child: FutureBuilder(
        future: userController.getEmployee(),
        builder: (context, snapshot) {
          final response =
              CloudHelperFunctions.checkSingleStateRecord(snapshot: snapshot);
          if (response != null) return response;

          final employees = snapshot.data!;

          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: AppSize.spaceBtwItems),
            itemCount: employees.length,
            itemBuilder: (context, index) => EmployeeCardHorizontal(
              onTap: () => userController.changeSelectedEmployee(employees[index]),
              employee: employees[index],
            ),
          );
        },
      ),
    );
  }
}
