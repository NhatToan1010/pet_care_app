import 'package:flutter/material.dart';
import 'package:pet_care_app/feature/customer/view/employee_info/widgets/employee_info_app_bar.dart';
import 'package:pet_care_app/feature/customer/view/employee_info/widgets/employee_info_button_group.dart';
import 'package:pet_care_app/feature/customer/view/employee_info/widgets/employee_info_detail.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../../common/widgets/texts/title_text.dart';
import '../../../personalization/model/user_model.dart';


class EmployeeInfoScreen extends StatelessWidget {
  const EmployeeInfoScreen({super.key, required this.employee});
  final UserModel employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            EIAppBar(employee: employee),

            // --- Detail Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
              child: Column(
                children: [
                  // --- Title
                  TitleTextWidget(
                    largeTitle: true,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    title: employee.fullName,
                    subtitle: 'Nhân Viên Của Năm',
                  ),
                  SizedBox(height: AppSize.spaceBtwItems),

                  // --- Buttons
                  EIButtonGroup(employee: employee),
                  SizedBox(height: AppSize.spaceBtwSections),

                  // --- Infomation Detail
                  EIDetail(employee: employee,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () {}, child: Text('Đặt Lịch Ngay')),
        ),
      ),
    );
  }
}






