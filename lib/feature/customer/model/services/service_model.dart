import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/dog_walking_model.dart';
import 'package:pet_care_app/feature/customer/model/services/pet_sitting_model.dart';
import 'package:pet_care_app/feature/customer/model/services/pet_taxi_model.dart';
import 'package:pet_care_app/utils/constants/enums.dart';

import 'dog_day_care.dart';

abstract class ServiceModel {
  final String id;
  final String name;
  final String description;
  String imageUrl;
  List<String> petSizes;
  final double price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.petSizes,
  });

  Map<String, dynamic> toJSON();

  double calculateTotalPrice(PetSizes petSizes);

  // static ServiceModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   print('---------------------------Go to snapshot');
  //   if (doc.data() != null) {
  //     final data = doc.data()!;
  //     final serviceType = data["Name"];
  //
  //     print('---------------------------Go to switch');
  //     print('---------------------------$serviceType');
  //     switch (serviceType) {
  //       case "Dắt Chó Đi Dạo":
  //         print('---------------------------1');
  //         return DogWalkingModel.fromSnapshot(doc);
  //       case "Chăm Sóc Thú Cưng Tại Nhà":
  //         print('---------------------------2');
  //         return PetSittingModel.fromSnapshot(doc);
  //       case "Đưa Đón Thú Cưng":
  //         print('---------------------------3');
  //         return PetTaxiModel.fromSnapshot(doc);
  //       case "Chăm Sóc Chó Tại Trung Tâm":
  //         print('---------------------------4');
  //         return DogDayCare.fromSnapshot(doc);
  //       default:
  //         return DogWalkingModel.empty();
  //     }
  //   } else {
  //     return DogWalkingModel.empty();
  //   }
  // }

  factory ServiceModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;
      final serviceType = data["Name"];

      switch (serviceType) {
        case "Dắt Chó Đi Dạo":
          return DogWalkingModel.fromSnapshot(doc);
        case "Chăm Sóc Thú Cưng Tại Nhà":
          return PetSittingModel.fromSnapshot(doc);
        case "Đưa Đón Thú Cưng":
          return PetTaxiModel.fromSnapshot(doc);
        case "Chăm Sóc Chó Tại Trung Tâm":
          return DogDayCare.fromSnapshot(doc);
        default:
          return DogWalkingModel.empty();
      }
    } else {
      return DogWalkingModel.empty();
    }
  }
}
