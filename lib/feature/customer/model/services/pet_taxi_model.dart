import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';


class PetTaxiModel extends ServiceModel {
  final String pickupLocation;
  final String dropoffLocation;
  final int distanceKm;
  final double pricePerKm;

  PetTaxiModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.petSizes,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.distanceKm,
    required this.pricePerKm,
    super.averageRating,
    super.ratingCount,
  });

  static PetTaxiModel empty() {
    return PetTaxiModel(
      id: '',
      name: '',
      description: '',
      price: 0.0,
      pickupLocation: '',
      dropoffLocation: '',
      distanceKm: 0,
      pricePerKm: 0.0,
      imageUrl: '',
      petSizes: [],
    );
  }

  @override
  double calculateTotalPrice(petSizes) {
    return price * (distanceKm * pricePerKm);
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      "Id": id,
      "Name": name,
      "Description": description,
      "Price": price,
      "PickupLocation": pickupLocation,
      "DropoffLocation": dropoffLocation,
      "Distance": distanceKm,
      "PricePerKm": pricePerKm,
      "ImageUrl": imageUrl,
      "PetSizes": super.petSizes,
      "AverageRating": averageRating,
      "RatingCount": ratingCount,
    };
  }

  factory PetTaxiModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;

      List<String> petSizes = [];
      if (data["PetSizes"] != null) {
        final dynamicList = data["PetSizes"] as List<dynamic>;
        petSizes = dynamicList.map((item) => item.toString()).toList();
      }

      return PetTaxiModel(
        id: doc.id,
        name: data["Name"] ?? '',
        description: data["Description"] ?? '',
        price: data["Price"] ?? 0,
        pickupLocation: data["PickupLocation"] ?? '',
        dropoffLocation: data["DropoffLocation"] ?? '',
        distanceKm: data["Distance"] ?? 0,
        pricePerKm: data["PricePerKm"] ?? 0,
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
