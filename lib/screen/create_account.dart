import 'package:chat_app/authentication/controllers/sign_up/signup_controller.dart';
import 'package:chat_app/widgets/CustomTextField.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatefulWidget {

  CreateAccountScreen({super.key, this.onTap});
  final void Function()? onTap;

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.message, size: 80),
                      SizedBox(height: 24.h),
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextfield(
                        hintText: 'Mobile Number',
                        controller: controller.phoneNumber,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextfield(
                        hintText: 'Name',
                        controller: controller.name,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextfield(
                        hintText: 'Email',
                        controller: controller.email,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextfield(
                        hintText: 'Password',
                        controller: controller.password,
                        obscureText: true,
                      ),
                      SizedBox(height: 12.h),
                      CustomButton(title: 'SignUp', onTap: ()=> controller.signUp()),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
