import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String serviceId;
  String userId;
  String userName;
  String? avatar;
  String comment;
  double ratingScore;
  DateTime dateReview;

  ReviewModel({
    required this.serviceId,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.ratingScore,
    required this.dateReview,
    this.avatar,
  });

  Map<String, dynamic> toJSON() {
    return {
      "ServiceId": serviceId,
      "UserId": userId,
      "UserName": userName,
      "Comment": comment,
      "RatingScore": ratingScore,
      "DateReview": dateReview,
      "Avatar": avatar,
    };
  }

  static ReviewModel empty() {
    return ReviewModel(
      serviceId: '',
      userId: '',
      userName: '',
      comment: '',
      ratingScore: 0.0,
      dateReview: DateTime.now(),
    );
  }

  factory ReviewModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;

      final timestampData = data['DateReview'];
      DateTime? timestamp;

      if (timestampData is Timestamp) {
        timestamp = timestampData.toDate();
      }
      timestamp ??= DateTime.now();

      return ReviewModel(
        serviceId: data['ServiceId'],
        userId: data['UserId'],
        userName: data['UserName'],
        comment: data['Comment'],
        ratingScore: data['RatingScore'],
        dateReview: timestamp,
        avatar: data['Avatar'],
      );
    } else {
      return ReviewModel.empty();
    }
  }
}
