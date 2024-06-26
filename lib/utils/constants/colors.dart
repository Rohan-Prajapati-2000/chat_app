import 'package:flutter/material.dart';

class SColors{
  SColors._();

  // App basic color
  static const Color primaryColor = Color(0xFFDA5A13);
  static const Color secondaryColor = Color(0xFF52AE4F);
  static const Color accent = Color(0xFFB0C7FF);


  // Gradient Color
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xffff9a9e),
        Color(0xfffad0c4),
        Color(0xfffad0c4),
      ]
  );




  // Text Color
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Color(0xFFffffff);

  // Background Color
  static const Color light = Color(0xFFf6f6f6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFf3f5ff);

  // Background Container Color
  static const Color black1 = Color(0xFF15141F);
  static  Color darkContainer = Colors.white.withOpacity(0.1);

  // Button Color
  static const Color buttonSecondary = Color(0xFFFEEEEB);
  static const Color buttonDisabled = Color(0xFFc4c4c4);

  // Border Color
  static const Color borderPrimary = Color(0xFFd9d9d9);
  static const Color borderSecondary = Color(0xFFe6e6e6);

  // Error and Validation Colors
  static const Color error = Color(0xFFFF6262);
  static const Color success = Color(0xFF40DD7F);
  static const Color warning = Color(0xFFFFBC1F);
  static const Color info = Color(0xFF1976d2);

  // Neutral Shade
  static const Color black = Color(0xFF000000);
  static const Color darkerGrey = Color(0xFF4f4f4f);
  static const Color darkGrey = Color(0xFF939393);
  static const Color lightGrey = Color(0xFFF9F9FA);
  static const Color grey = Color(0xFFb7b7b7);
  static const Color grey1 = Color(0xFFA2A0A8);
  static const Color grey2 = Color(0xFFDCDBE0);
  static const Color subTitleColor = Color(0xFFA2A0A8);
  static const Color white = Color(0xFFffffff);



}