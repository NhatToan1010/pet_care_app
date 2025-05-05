import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/dog_walking_model.dart';
import 'package:pet_care_app/feature/customer/model/services/pet_sitting_model.dart';
import 'package:pet_care_app/feature/customer/model/services/pet_taxi_model.dart';
import 'package:pet_care_app/utils/constants/enums.dart';

import 'dog_day_care.dart';

class ServiceModel {
  final String id;
  final String name;
  final String description;
  String imageUrl;
  List<String> petSizes;
  num price;
  num? averageRating;
  num? ratingCount;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.petSizes,
    this.averageRating,
    this.ratingCount,
  });

  Map<String, dynamic> toJSON() {
    return {
      "Id": id,
      "Name": name,
      "Description": description,
      "Price": price,
      "ImageUrl": imageUrl,
      "PetSizes": petSizes,
      "AverageRating": averageRating,
      "RatingCount": ratingCount,
    };
  }

  factory ServiceModel.empty() {
    return ServiceModel(
      id: "",
      name: "",
      description: "",
      price: 0,
      imageUrl: "",
      petSizes: [],
    );
  }

  double calculateTotalPrice(PetSizes petSizes) {
    switch (petSizes) {
      case PetSizes.small:
        return price * 0.8;
      case PetSizes.medium:
        return price * 1.2;
      case PetSizes.large:
        return price * 1.5;
    }
  }

  factory ServiceModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final serviceType = doc.id;

      switch (serviceType) {
        case "SV001":
          return DogWalkingModel.fromSnapshot(doc);
        case "SV002":
          return PetSittingModel.fromSnapshot(doc);
        case "SV003":
          return PetTaxiModel.fromSnapshot(doc);
        case "SV004":
          return DogDayCare.fromSnapshot(doc);
        default:
          return DogWalkingModel.empty();
      }
    } else {
      return DogWalkingModel.empty();
    }
  }
}
