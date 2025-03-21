import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_appbar.dart';
import 'package:get/get.dart';

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
    final reviewController = Get.put(ReviewController());

    return Scaffold(
      appBar: CustomAppbar(
        title: Text('Đánh Giá Dịch Vụ'),
        showBackArrow: true,
      ),
      body: FutureBuilder(
        future: reviewController.getReviewsByService(service.id),
        builder: (context, snapshot) {
          final respone = CloudHelperFunctions.checkSingleStateRecord(snapshot: snapshot);
          if (respone != null) return respone;

          final listReview = snapshot.data!;

          return ListView.separated(
            padding: EdgeInsets.all(AppSize.defaultSpace),
            shrinkWrap: true,
            itemCount: listReview.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final review = listReview[index];
              return Row(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage(
                        review.avatar ?? 'assets/images/customers/default_avatar.jpg',
                      ),
                    ),
                  SizedBox(width: AppSize.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRatingBarIndicator(itemSize: 15.0, rating: review.ratingScore,),
                      SizedBox(height: AppSize.small),
                      Text(review.userName, style: Theme.of(context).textTheme.titleMedium,),
                      SizedBox(height: AppSize.small),

                      Text(review.comment, style: Theme.of(context).textTheme.bodyLarge,),
                    ],
                  ),

                ],
              );
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
    );

    // ListTile(
    //   leading: CircleAvatar(
    //     backgroundImage: AssetImage(
    //       review.avatar ?? 'assets/images/customers/default_avatar.jpg',
    //     ),
    //   ),
    //   title: Text(review.userName),
    //   subtitle: Text(review.comment),
    //   trailing: Row(
    //     children: [
    //       Icon(Icons.star_rounded, color: Colors.amber, size: 24),
    //       Text(' ${review.ratingScore.toString()}'),
    //     ],
    //   ),
    // );
  }
}


