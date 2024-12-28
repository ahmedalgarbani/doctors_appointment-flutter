import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

class AppThemeManager {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.primaryColor,
    brightness: Brightness.light,
    fontFamily: "Satoshi",
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color.fromARGB(0, 127, 65, 65),
      hintStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xff383838),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide:
            BorderSide(color: Color.fromARGB(255, 3, 2, 2), width: 0.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 21, 21, 21),
          width: 1.0,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColor.primaryColor,
    brightness: Brightness.dark,
    fontFamily: "Satoshi",
    scaffoldBackgroundColor: AppColor.darkBackground,
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xffA7A7A7),
      ),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.white, width: 0.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
            color: Color.fromARGB(255, 235, 235, 235), width: 1.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );

  static ThemeData? currentTheme;
}
