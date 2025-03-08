import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/feature/customer/model/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = AuthenticationRepository.instance;

  Future<List<OrderModel>> getOrderByUserId(String userType) async {
    try {
      final user = _auth.authUser;

      if (user == null) {
        throw "Unable to find user.";
      }

      final userId = _auth.authUser!.uid;

      final snapshot = await _db.collection('Orders').where(userType, isEqualTo: userId).get();

      final listOrder = snapshot.docs.map((item) => OrderModel.fromSnapshot(item)).toList();

      return listOrder;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveOrder(OrderModel order) async {
    try {
      await _db.collection('Orders').doc().set(order.toJSON());
    } catch (e) {
      throw e.toString();
    }
  }
}