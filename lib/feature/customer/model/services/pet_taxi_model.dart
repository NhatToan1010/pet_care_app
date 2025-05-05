import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';


class PetTaxiModel extends ServiceModel {
  final String pickupLocation;
  final String dropoffLocation;
  final num distanceKm;
  final num pricePerKm;

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
      price: 0,
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
    return price * (distanceKm * pricePerKm).toDouble();
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
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

  factory PetTaxiModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;


      List<String> petSizes = [];
      if (data["PetSizes"] != null) {
        final dynamicList = data["PetSizes"] as List<dynamic>;
        petSizes = dynamicList.map((item) => item.toString()).toList();
      }

      return PetTaxiModel(
        id: doc.id,
        name: data["Name"] as String,
        description: data["Description"] as String,
        price: data["Price"] ?? 0,
        pickupLocation: data["PickupLocation"] as String,
        dropoffLocation: data["DropoffLocation"] as String,
        distanceKm: data["Distance"] ?? 0,
        pricePerKm: data["PricePerKm"].toDouble() ?? 0.0,
        imageUrl: data["ImageUrl"] as String,
        petSizes: petSizes,
        averageRating: data["AverageRating"] ?? 0.0,
        ratingCount: data["RatingCount"] ?? 0,
      );
    } else {
      return empty();
    }
  }
}
