import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/enums.dart';

class DogWalkingModel extends ServiceModel {
  final int durationMinutes;
  final List<String> walkingLocation;

  DogWalkingModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required this.walkingLocation,
    required this.durationMinutes,
    required super.imageUrl,
    required super.petSizes,
    super.averageRating,
    super.ratingCount,
  });

  static DogWalkingModel empty() {
    return DogWalkingModel(
      id: '',
      name: '',
      description: '',
      price: 0.0,
      walkingLocation: [],
      durationMinutes: 0,
      imageUrl: '',
      petSizes: [],
    );
  }

  @override
  double calculateTotalPrice(PetSizes petSizes) {
    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large) {
      sizeMultiplier = 1.4;
    }
    return price * sizeMultiplier * (durationMinutes / 60);
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      "Name": name,
      "Description": description,
      "Price": price,
      "DurationMinutes": durationMinutes,
      "WalkingLocation": walkingLocation,
      "PetSizes": super.petSizes,
      "ImageUrl": imageUrl,
      "AverageRating": averageRating,
      "RatingCount": ratingCount,
    };
  }

  factory DogWalkingModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;

      List<String> petSizes = [];
      List<String> walkLocation = [];

      if (data["PetSizes"] != null) {
        final dynamicList = data["PetSizes"] as List<dynamic>;
        petSizes = dynamicList.map((item) => item.toString()).toList();
      }

      if (data["WalkingLocation"] != null) {
        final dynamicList = data["WalkingLocation"] as List<dynamic>;
        walkLocation = dynamicList.map((item) => item.toString()).toList();
      }

      return DogWalkingModel(
        id: doc.id,
        name: data["Name"] ?? '',
        description: data["Description"] ?? '',
        price: data["Price"] ?? 0,
        walkingLocation: walkLocation,
        durationMinutes: data["DurationMinutes"] ?? 0,
        imageUrl: data["ImageUrl"] ?? '',
        petSizes: petSizes,
        averageRating: data["AverageRating"] ?? 0.0,
        ratingCount: data["RatingCount"] ?? 0,
      );
    } else {
      return empty();
    }
  }
}
