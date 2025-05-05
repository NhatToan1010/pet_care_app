import '../../feature/customer/model/services/dog_day_care.dart';
import '../../feature/customer/model/services/dog_walking_model.dart';
import '../../feature/customer/model/services/pet_sitting_model.dart';
import '../../feature/customer/model/services/pet_taxi_model.dart';
import '../../feature/customer/model/services/service_model.dart';
import '../constants/enums.dart';

class PricingCalculator {
  static double fee = 15000.0;

  // Calculate price based on tax and shipping
  static double calculateTotalPrice(double servicePrice) {
    return servicePrice + calculateFee(servicePrice);
  }

  static double getTaxRateForLocation(String location) {
    // Lookup the tax rate for the given location from a tax rate database or API.
    // Return the appropriate tax rate.
    return 0.10;
  }

  static double calculateFee(double price) {
    if (price - price * 0.9 <= fee) {
      return price * 0.1;
    } else {
      return fee;
    }
  }

  static double dogWalkingPrice(ServiceModel service, String petSizes) {
    final dogWalking = service as DogWalkingModel;
    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium.toString()) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large.toString()) {
      sizeMultiplier = 1.4;
    }
    return dogWalking.price * sizeMultiplier * (dogWalking.durationMinutes / 60);
  }

  static double petTaxiPrice(ServiceModel service, String petSizes) {
    final petTaxi = service as PetTaxiModel;
    return petTaxi.price * (petTaxi.distanceKm * petTaxi.pricePerKm).toDouble();
  }

  static double petSittingPrice(ServiceModel service, String petSizes, int numberOfActivity) {
    final petSitting = service as PetSittingModel;

    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium.toString()) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large.toString()) {
      sizeMultiplier = 1.4;
    }

    return (petSitting.price * numberOfActivity) * sizeMultiplier * petSitting.durationHours;
  }

  static double dogDayCarePrice(ServiceModel service, String petSizes, int numberOfActivity) {
    final dogDayCare = service as DogDayCare;

    double sizeMultiplier = 1.0;
    if (petSizes == PetSizes.medium.toString()) {
      sizeMultiplier = 1.2;
    } else if (petSizes == PetSizes.large.toString()) {
      sizeMultiplier = 1.4;
    }

    return (dogDayCare.price * numberOfActivity) * sizeMultiplier;
  }

  static double calculateServicePrice(ServiceModel service, String selectedSize) {
    switch (service.name) {
      case "Dắt Chó Đi Dạo":
        return dogWalkingPrice(service, selectedSize);
      case "Đưa Đón Thú Cưng":
        return petTaxiPrice(service, selectedSize);
      default:
        return 0.0;
    }
  }
}