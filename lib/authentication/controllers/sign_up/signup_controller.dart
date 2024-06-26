import 'package:chat_app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../data/user/user_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../../models/user_model/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  /// SignUp
  Future<void> signUp() async {
    try {
      // Register User in the FireBase Authentication & save user data in the firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Save Authenticated User data in the firebase fire-store
      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: name.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show success message
      SLoaders.successSnackBar(title: 'Congratulations!', message: 'Your account has been created.');

      // Move to login screen
      Get.offAll(() => LoginScreen());
    } catch (e) {

      // Show some generic error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
