// lib/design_system/theme.dart

import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText1: TextStyle(fontSize: 16, color: Colors.black),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.orange,
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
    iconTheme: IconThemeData(color: Colors.black),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkAppBarBg,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText1: TextStyle(fontSize: 16, color: Colors.white),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkBackground,
    ),
    buttonTheme: ButtonThemeData(buttonColor: AppColors.darkButton),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
