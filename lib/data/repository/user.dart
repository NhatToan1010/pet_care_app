import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/data/repository/authentication.dart';
import 'package:pet_care_app/feature/personalization/model/user_model.dart';

import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createNewUser(UserModel user) async {
    try {
      _db.collection("Users").doc(user.id).set(user.toJSON());
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

  Future<void> updateAllUserField(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJSON());
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

  Future<void> updateSpecificUserField(Map<String, dynamic> dataField) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update(dataField);
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

  Future<UserModel> getUser() async {
    try {
      final snapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();

      return snapshot.exists
          ? UserModel.fromSnapshot(snapshot)
          : UserModel.empty();
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

  Future<List<UserModel>> getEmployee() async {
    try {
      final snapshot = await _db.collection("Users").where('UserType', isEqualTo: 'UserType.employee').get();
      final users = snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();

      return users;
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

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);

      await ref.putFile(File(image.path));

      final url = ref.getDownloadURL();

      return url;
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

  Future<UserModel> getSpecificUser(String userId) async {
    try {
      final snapshot = await _db.collection("Users").doc(userId).get();

      return UserModel.fromSnapshot(snapshot);
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    }
  }
}
