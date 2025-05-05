import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/enums.dart';

class DogDayCare extends ServiceModel {
  final List<String> activities;

  DogDayCare({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.petSizes,
    required this.activities,
    super.averageRating,
    super.ratingCount,
  });

  static DogDayCare empty() {
    return DogDayCare(
      id: '',
      name: '',
      description: '',
      price: 0,
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

    return price * sizeMultiplier;
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      "Name": name,
      "Description": description,
      "Price": price,
      "ImageUrl": imageUrl,
      "PetSizes": super.petSizes,
      "Activities": activities,
      "AverageRating": averageRating,
      "RatingCount": ratingCount,
    };
  }

  factory DogDayCare.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;;

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

      return DogDayCare(
        id: doc.id,
        name: data["Name"] ?? '',
        description: data["Description"] ?? '',
        price: data["Price"] ?? 0,
        imageUrl: data["ImageUrl"] ?? '',
        petSizes: petSizes,
        activities: activities,
        averageRating: data["AverageRating"] ?? 0.0,
        ratingCount: data["RatingCount"] ?? 0,
      );
    } else {
      return empty();
    }
  }
}
