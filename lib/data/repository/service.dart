import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../feature/customer/model/services/service_model.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/services/local_firebase_storage_service.dart';

class ServiceRepository extends GetxController {
  static ServiceRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ServiceModel>> fetchServices() async {
    try {
      final snapshot = await _db.collection('Services').get();

      final services = snapshot.docs.map((doc) => ServiceModel.fromSnapshot(doc)).toList();

      return services;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateServiceField(String serviceId, Map<String, dynamic> dataField) async {
    try {
      await _db.collection("Services").doc(serviceId).update(dataField);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> upLoadService(List<ServiceModel> services) async {
    try {
      final storage = Get.put(LocalFirebaseStorageService());
      for (var item in services) {
        final thumbnail = await storage.getImageDataFromAssets(item.imageUrl);

        final url = await storage.uploadImageData('Services/Images', item.imageUrl, thumbnail);

        item.imageUrl = url;
        await _db.collection('Services').doc(item.id).set(item.toJSON());

      }
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    }
  }
}
