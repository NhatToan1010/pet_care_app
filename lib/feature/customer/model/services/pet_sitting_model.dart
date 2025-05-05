import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/enums.dart';

class PetSittingModel extends ServiceModel {
  final num durationHours;
  final List<String> activities;

  PetSittingModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.petSizes,
    required this.durationHours,
    required this.activities,
    super.averageRating,
    super.ratingCount,
  });

  static PetSittingModel empty() {
    return PetSittingModel(
      id: '',
      name: '',
      description: '',
      price: 0,
      durationHours: 0,
      imageUrl: '',
      petSizes: [],
      activities: [],
    );
  }

  @override
  double calculateTotalPrice(petSizes) {
    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large) {
      sizeMultiplier = 1.4;
    }

    return price * sizeMultiplier * durationHours;
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      "Name": name,
      "Description": description,
      "Price": price,
      "DurationHours": durationHours,
      "PetSizes": super.petSizes,
      "ImageUrl": imageUrl,
      "Activities": activities,
      "AverageRating": averageRating,
      "RatingCount": ratingCount,
    };
  }

  factory PetSittingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;

      List<String> petSizes = [];
      List<String> activities = [];

      if (data["PetSizes"] != null) {
        final dynamicList = data["PetSizes"] as List<dynamic>;
        petSizes = dynamicList.map((item) => item.toString()).toList();
      }

      if (data["Activities"] != null) {
        final dynamicList = data["Activities"] as List<dynamic>;
        activities = dynamicList.map((item) => item.toString()).toList();
      }

      return PetSittingModel(
        id: doc.id,
        name: data["Name"] ?? '',
        description: data["Description"] ?? '',
        price: data["Price"] ?? 0,
        petSizes: petSizes,
        durationHours: data["DurationHours"] ?? 0,
        imageUrl: data["ImageUrl"] ?? '',
        activities: activities,
        averageRating: data["AverageRating"] ?? 0.0,
        ratingCount: data["RatingCount"] ?? 0,
      );
    } else {
      return empty();
    }
  }
}
