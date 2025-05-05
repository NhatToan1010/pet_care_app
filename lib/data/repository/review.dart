import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/feature/customer/model/review_model.dart';

class ReviewRepository extends GetxController {
  static ReviewRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createReview(ReviewModel review) async {
    try {
      await _db.collection('Reviews').doc().set(review.toJSON());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ReviewModel>> getReviewsByServiceId(String serviceId) async {
    try {
      final snapshot = await _db.collection('Reviews').where('ServiceId', isEqualTo: serviceId).get();
      return snapshot.docs.map((doc) => ReviewModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ReviewModel>> getReviewsByUserId(String userId) async {
    try {
      final snapshot = await _db.collection('Reviews').where('UserId', isEqualTo: userId).get();
      return snapshot.docs.map((doc) => ReviewModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}