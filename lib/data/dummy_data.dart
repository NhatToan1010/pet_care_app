import 'package:pet_care_app/feature/customer/model/services/dog_day_care.dart';
import 'package:pet_care_app/feature/customer/model/services/dog_walking_model.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/texts.dart';

import '../feature/customer/model/services/pet_sitting_model.dart';
import '../feature/customer/model/services/pet_taxi_model.dart';
import '../utils/constants/enums.dart';

class DummyData {
  static List<ServiceModel> services = [
    DogWalkingModel(
      id: 'SV001',
      name: 'Dắt Chó Đi Dạo',
      description: LocalTexts.dogWalkingDesciption,
      price: 50000.0,
      walkingLocation: ['Công viên Lưu Hữu Phước', 'Công viên Hùng Vương', 'Công viên Tao Đàn'],
      durationMinutes: 120,
      imageUrl: 'assets/images/services/dog_walking.jpg',
      petSizes: [
        PetSizes.small.toString(),
        PetSizes.medium.toString(),
        PetSizes.large.toString()
      ],
    ),
    PetSittingModel(
      id: 'SV002',
      name: 'Chăm Sóc Thú Cưng Tại Nhà',
      description: LocalTexts.petSittingDescription,
      price: 50000.0,
      durationHours: 4,
      imageUrl: 'assets/images/services/pet_sitting.jpg',
      petSizes: [
        PetSizes.small.toString(),
        PetSizes.medium.toString(),
        PetSizes.large.toString()
      ],
      activities: ['Chải Lông', 'Tắm', 'Dọn Giường', 'Cho Ăn'],
    ),
    PetTaxiModel(
      id: 'SV003',
      name: 'Đưa Đón Thú Cưng',
      description: LocalTexts.petTaxiDescription,
      price: 50000.0,
      imageUrl: 'assets/images/services/pet_taxi.jpg',
      pickupLocation: '',
      dropoffLocation: '',
      distanceKm: 2,
      pricePerKm: 10000.0,
      petSizes: [
        PetSizes.small.toString(),
        PetSizes.medium.toString(),
        PetSizes.large.toString()
      ],
    ),

    DogDayCare(
      id: 'SV004',
      name: 'Chăm Sóc Chó Tại Trung Tâm',
      description: LocalTexts.dogDayCareDescription,
      price: 50000.0,
      imageUrl: 'assets/images/services/pet_grooming.jpg',
      petSizes: [
        PetSizes.small.toString(),
        PetSizes.medium.toString(),
        PetSizes.large.toString()
      ],
      activities: ['Tỉa Lông', 'Tắm', 'Vệ Sinh Móng', 'Vệ Sinh Tai'],
    ),
  ];
}