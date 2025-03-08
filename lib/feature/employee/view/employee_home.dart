import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/device/device_utility.dart';

import 'employee_order_card.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Text('Đơn hàng có thể nhận')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.small),
        child: SizedBox(
          height: DeviceUtils.getScreenHeight(),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: AppSize.medium),
            itemCount: 4,
            itemBuilder: (context, index) {
              return EmployeeOrderCard();
            },
          ),
        ),
      ),
    );
  }
}