import 'package:chat_app/widgets/CustomTextField.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../authentication/controllers/login/login_controller.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key, this.onTap});

  final void Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message, size: 80),
              SizedBox(height: 24.h),
              Text('Login',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 12.h),
              CustomTextfield(hintText: 'Email', controller: controller.email),
              SizedBox(height: 12.h),
              CustomTextfield(hintText: 'Password', controller: controller.password, obscureText: true),
              SizedBox(height: 25.h),
              CustomButton(title: 'SignIn', onTap:()=> controller.emailAndPasswordSignIn(),),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account? ",
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Create Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                ],
              )




            ],
          ),
        ),
      ),
    );
  }
}