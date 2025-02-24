import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/data/dummy_data.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';

import '../../../../data/repository/service.dart';
import '../../../customer/controller/service_controller.dart';
import '../profile/widgets/profile_menu_item.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServiceController());
    final serviceRepo = ServiceRepository.instance;
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          children: [
            ProfileMenuItem(
              onPressed: () => serviceRepo.upLoadService(DummyData.services),
              leadingIcon: Iconsax.arrow_up,
              title: 'Tải Lên Dịch Vụ',
              subtitle: '',
            ),
            SizedBox(height: AppSize.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
