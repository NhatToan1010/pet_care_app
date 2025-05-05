import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/popups/loader.dart';

import '../../../data/repository/review.dart';
import '../../../data/repository/service.dart';
import '../../../data/repository/user.dart';
import '../model/review_model.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();
  final reviewRepository = Get.put(ReviewRepository());
  final serviceRepository = Get.put(ServiceRepository());

  final comment = TextEditingController();
  final RxDouble rating = 0.0.obs;
  final listReview = <ReviewModel>[].obs;

  Future<void> getReviewsByService(String serviceId) async {
    try {
      final reviews = await reviewRepository.getReviewsByServiceId(serviceId);
      listReview.assignAll(reviews);
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  Future<List<ReviewModel>> getReviewsByUser(String userId) async {
    try {
      final reviews = await reviewRepository.getReviewsByUserId(userId);
      return reviews;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
      return [];
    }
  }

  Future<void> refreshData(String serviceId) async {
    getReviewsByService(serviceId);
  }

  double calculateAverageRating(List<ReviewModel> reviews) {
    try {
      double totalRating = 0.0;
      if (reviews.isEmpty) {
        return 0.0;
      } else {
        for (var review in reviews) {
          totalRating += review.ratingScore;
        }
      }
      return totalRating / reviews.length;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
      return 0.0;
    }
  }

  void creatReview(String serviceId) async {
    try {
      if (comment.text.isEmpty) {
        CustomLoader.errorSnackBar(title: 'Lỗi', message: 'Vui lòng nhập bình luận');
        return;
      }

      final user = await UserRepository.instance.getUser();
      final review = ReviewModel(
        serviceId: serviceId,
        userId: user.id,
        userName: user.fullName,
        avatar: user.avatarURL,
        comment: comment.text,
        ratingScore: rating.value,
        dateReview: DateTime.now(),
      );

      await reviewRepository.createReview(review);

      final reviews = listReview;

      Map<String, dynamic> dataField = {
        "AverageRating": calculateAverageRating(reviews),
        "RatingCount": reviews.length,
      };
      await serviceRepository.updateServiceField(serviceId, dataField);
      _clear();

      getReviewsByService(serviceId);

      Navigator.of(Get.overlayContext!).pop();
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  void _clear() {
    comment.clear();
    rating.value = 0.0;
  }

  void reviewDialog(String serviceId) =>
    showDialog(
      barrierDismissible: false,
      context: Get.overlayContext!,
      builder: (context) =>
      AlertDialog(

        alignment: Alignment.center,
        backgroundColor: AppPallete.whiteColor,
        title: Text('Gửi Đánh Giá'),
        titleTextStyle: TextStyle(fontSize: 20, color: AppPallete.textPrimary),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar.builder(
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                unratedColor: AppPallete.greyColor,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber, size: 12,),
                onRatingUpdate: (score) => rating.value = score,
            ),
            SizedBox(height: AppSize.spaceBtwItems),

            TextFormField(
              controller: comment,
              decoration: InputDecoration(
                hintText: 'Nhập bình luận',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Text('Hủy'),
          ),
          SizedBox(width: AppSize.small),
          TextButton(
            onPressed: () {creatReview(serviceId);},
            child: Text('Gửi'),
          ),
        ],
      ),
    );
}
