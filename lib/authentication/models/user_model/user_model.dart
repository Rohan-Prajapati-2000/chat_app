import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing user data
class UserModel {
  // Keep those value final which don't want to update
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  /// Constructor for UserModel
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  // Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      name: '',
      email: '',
      phoneNumber: '',
  );

  /// Convert model to JSON structure for storing data in Firebase;
  Map<String, dynamic> toJson() {
    return {
      'Uid': id,
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['Name'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
      );
    } else {
      throw Exception('Document snapshot data is null');
    }
  }


}
