import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/utils/services/local_firebase_storage_service.dart';

import '../../feature/customer/model/services/dog_day_care.dart';
import '../../feature/customer/model/services/dog_walking_model.dart';
import '../../feature/customer/model/services/pet_sitting_model.dart';
import '../../feature/customer/model/services/pet_taxi_model.dart';
import '../../feature/customer/model/services/service_model.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class ServiceRepository extends GetxController {
  static ServiceRepository get instance => Get.find();

  final RxList<ServiceModel> _services = <ServiceModel>[].obs;

  final _db = FirebaseFirestore.instance;

  void addService(ServiceModel service) {
    _services.add(service);
  }

  List<ServiceModel> get services => _services.toList();

  Future<List<ServiceModel>> fetchServices() async {
    try {
      final snapshot = await _db.collection('Services').get();

      final services = snapshot.docs.map((doc) => ServiceModel.fromSnapshot(doc)).toList();

      return services;
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> upLoadService(List<ServiceModel> services) async {
    try {
      // final storage = Get.put(LocalFirebaseStorageService());
      print('------------------------------------Go to upload');
      for (var item in services) {
        // print('------------------------------------Go to for loop');
        //
        // final thumbnail = await storage.getImageDataFromAssets(item.imageUrl);
        // print('------------------------------------Go to line 1');
        //
        // final url = await storage.uploadImageData('Services/Images', item.imageUrl, thumbnail);
        //
        // print('------------------------------------Go to line 2');
        //
        // item.imageUrl = url;
        //
        // print('------------------------------------Go to line 3');

        await _db.collection('Services').doc(item.id).set(item.toJSON());
        print('------------------------------------Upload success');
      }
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    }
  }
}
