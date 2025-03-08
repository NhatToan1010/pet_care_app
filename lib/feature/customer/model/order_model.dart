import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/feature/customer/model/services/dog_day_care.dart';
import 'package:pet_care_app/feature/customer/model/services/dog_walking_model.dart';
import 'package:pet_care_app/feature/customer/model/services/pet_sitting_model.dart';
import 'package:pet_care_app/feature/customer/model/services/pet_taxi_model.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/utils/constants/enums.dart';

class OrderModel {
  String? id;
  String customerId;
  String employeeId;
  String orderDate;
  String dateStart;
  String timeStart;
  String petSize;
  String serviceName;
  String? walkLocation;
  String? pickUpLocation;
  String? dropOffLocation;
  OrderStatus status;
  double totalPrice;

  OrderModel({
    this.id,
    required this.customerId,
    required this.employeeId,
    required this.orderDate,
    required this.dateStart,
    required this.timeStart,
    required this.status,
    required this.totalPrice,
    required this.petSize,
    required this.serviceName,
    this.walkLocation,
    this.pickUpLocation,
    this.dropOffLocation,
  });

  static OrderModel empty() {
    return OrderModel(
      id: '',
      customerId: '',
      employeeId: '',
      orderDate: '',
      dateStart: '',
      timeStart: '',
      serviceName: '',
      status: OrderStatus.pending,
      petSize: PetSizes.small.toString(),
      totalPrice: 0.0,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'CustomerId': customerId,
      'EmployeeId': employeeId,
      'OrderDate': orderDate,
      'DateStart': dateStart,
      'TimeStart': timeStart,
      'OrderStatus': status.name,
      'PetSize' : petSize,
      'SeviceName' : serviceName,
      'WalkLocation' : walkLocation,
      'PickUpLocation' : pickUpLocation,
      'DropOffLocation' : dropOffLocation,
      'TotalPrice' : totalPrice,
    };
  }

  Map<String, dynamic> routeService(ServiceModel service) {
    switch (service.name) {
      case 'Dắt Chó Đi Dạo':
        service as DogWalkingModel;
        return service.toJSON();
      case 'Chăm Sóc Thú Cưng Tại Nhà':
        service as PetSittingModel;
        return service.toJSON();
      case 'Đưa Đón Thú Cưng':
        service as PetTaxiModel;
        return service.toJSON();
      case 'Chăm Sóc Chó Tại Trung Tâm':
        service as DogDayCare;
        return service.toJSON();
      default:
        return {};
    }
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;

      return OrderModel(
        id: doc.id,
        customerId: data['CustomerId'],
        employeeId: data['EmployeeId'],
        orderDate: data['OrderDate'],
        dateStart: data['DateStart'],
        timeStart: data['TimeStart'],
        status: OrderStatus.values.firstWhere(
          (status) => status.name == data['status'],
          orElse: () => OrderStatus.pending,
        ),
        petSize: data['PetSize'],
        walkLocation: data['WalkLocation'],
        pickUpLocation: data['PickUpLocation'],
        dropOffLocation: data['DropOffLocation'],
        totalPrice: data['TotalPrice'],
        serviceName: data['SeviceName'],
      );
    } else {
      return OrderModel.empty();
    }
  }
}
