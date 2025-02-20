import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? avatarURL;
  final String userType;
  final String? yearExperience;
  final String? serviceDone;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.avatarURL,
    required this.userType,
    required this.yearExperience,
    required this.serviceDone,
  });

  Map<String, dynamic> toJSON() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "PhoneNumber": phoneNumber,
      "AvatarURL": avatarURL ?? '',
      "UserType": userType,
      "YearExperience": yearExperience ?? '',
      "ServiceDone": serviceDone ?? '',
    };
  }

  @override
  String toString() {
    return 'UserModel{'
        ' id: $id,'
        ' firstName: $firstName,'
        ' lastName: $lastName,'
        ' phoneNumber: $phoneNumber,'
        ' avatarURL: $avatarURL,'
        ' userType: $userType,'
        ' yearExperience: $yearExperience,'
        ' serviceDone: $serviceDone,'
        '}';
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? avatarURL,
    String? userType,
    String? yearExperience,
    String? serviceDone,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarURL: avatarURL ?? this.avatarURL,
      userType: userType ?? this.userType,
      yearExperience: yearExperience ?? this.yearExperience,
      serviceDone: serviceDone ?? this.serviceDone,
    );
  }

  static UserModel empty() {
    return UserModel(
      id: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      avatarURL: '',
      userType: '',
      yearExperience: '',
      serviceDone: '',
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;

      return UserModel(
        id: doc.id,
        firstName: data["FirstName"],
        lastName: data["LastName"],
        phoneNumber: data["PhoneNumber"],
        avatarURL: data["AvatarURL"] ?? '',
        userType: data["UserType"],
        yearExperience: data["YearExperience"] ?? '',
        serviceDone: data["ServiceDone"] ?? '',
      );
    } else {
      return empty();
    }
  }

  // Helper Functions
  // ----- Full name
  String get fullName => '$firstName $lastName';

  // ----- Formatted Phone Number
  String get formattedPhoneNumber => Formatter.formatPhoneNumber(phoneNumber);

  // ----- Split full name into first name and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  // ----- Generate username form full name
  static String generateUserNameFormFullName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername =
        "$firstName$lastName"; // Combine of first name and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername";

    return usernameWithPrefix;
  }
}
