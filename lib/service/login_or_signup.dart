import 'package:chat_app/authentication/controllers/login/login_controller.dart';
import 'package:chat_app/screen/create_account.dart';
import 'package:chat_app/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginOrSignUp extends StatefulWidget{
  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(onTap: togglePages);
    } else{
      return CreateAccountScreen(onTap: togglePages);
    }
  }
}