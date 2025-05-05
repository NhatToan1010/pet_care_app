import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/feature/customer/model/review_model.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_review_section.dart';

import '../../../../common/widgets/product_cart/ratings/custom_rating_bar_indicator.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controller/review_controller.dart';
import '../../model/services/service_model.dart';

class ServiceReviewScreen extends StatelessWidget {
  const ServiceReviewScreen({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final reviewController = ReviewController.instance;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: Text('Đánh Giá Dịch Vụ'),
          showBackArrow: true,
        ),
        body: Obx(
              () {
            return ListView.separated(
              padding: EdgeInsets.all(AppSize.defaultSpace),
              shrinkWrap: true,
              itemCount: reviewController.listReview.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final review = reviewController.listReview[index];
                return ReviewSection(review: review);
              },
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(AppSize.defaultSpace),
          child: ElevatedButton(
            onPressed: () => reviewController.reviewDialog(service.id),
            child: Text('Gửi Đánh Giá'),
          ),
        ),
      ),
    );
  }
}


