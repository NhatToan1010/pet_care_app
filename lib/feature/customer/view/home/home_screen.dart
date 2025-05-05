import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_care_app/common/widgets/icons/circular_icon.dart';
import 'package:pet_care_app/common/widgets/images/rounded_rect_image.dart';
import 'package:pet_care_app/common/widgets/layouts/grid_layout.dart';
import 'package:pet_care_app/common/widgets/service/service_card_vertical.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/common/widgets/texts/title_text.dart';
import 'package:pet_care_app/feature/personalization/controller/user_controller.dart';

import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/search_bar/search_bar.dart';
import '../../controller/service_controller.dart';
import '../service/service_detail_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final user = userController.user.value;
    final serviceController = Get.put(ServiceController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleTextWidget(
                    title: 'Xin Chào, ${user.firstName}',
                    subtitle: 'Hôm nay thú cưng của bạn thế nào?'),
                CircularIcon(
                  icon: Iconsax.notification,
                  backgroundColor: AppPallete.greyColor,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Search Bar
            CustomSearchBar(),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Banner
            RoundedRectImage(
              imageUrl: 'assets/images/pet/pet_banner_2.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Service List
            SectionHeading(title: 'Dịch Vụ Nổi Bật'),
            SizedBox(height: AppSize.spaceBtwItems),

            // --- Service Cards
            FutureBuilder(
              future: serviceController.fetchServices(),
              builder: (context, snapshot) {
                final response = CloudHelperFunctions.checkSingleStateRecord(snapshot: snapshot);

                if (response != null) return response;

                final data = snapshot.data!;

                return GridLayout(
                  itemCount: data.length,
                  itemBuilder: (context, index) => ServiceCardVertical(
                    service: data[index],
                    onPressed: () => Get.to(
                      () => ServiceDetailScreen(
                        service: data[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
