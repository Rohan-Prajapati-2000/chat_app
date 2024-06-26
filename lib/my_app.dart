import 'package:chat_app/screen/create_account.dart';
import 'package:chat_app/screen/home_screen.dart';
import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/service/login_or_signup.dart';
import 'package:chat_app/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';




class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        ensureScreenSize: true,
        designSize: const Size(375, 812),
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: SAppTheme.lightTheme,
            darkTheme: SAppTheme.darkTheme,

            home: (FirebaseAuth.instance.currentUser != null) ? HomeScreen() : LoginOrSignUp(),

          );
        }
    );
  }
}