import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../utils/popups/loaders.dart';

class LoginController extends GetxController{

  /// Variables
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Email and Password Signing
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Login user using Email & Password Authentication
      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

}
