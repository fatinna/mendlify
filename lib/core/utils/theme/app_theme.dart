import 'package:mendlify/core/utils/app_values_const.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: appPrimaryColorDarkColorLight,
      appBarTheme: AppBarTheme(
          backgroundColor: appBarBackgroundColorLight,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
          centerTitle: false),
      primaryColor: appPrimaryColorLight,
      primaryColorDark: appPrimaryColorDarkColorLight,
      textTheme: getTextThemeDataLight,
      inputDecorationTheme: inputDecorationTheme);

  static final darkTheme = ThemeData(
    brightness: Brightness.dark, // For dark theming
    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    appBarTheme: const AppBarTheme(
        backgroundColor: appBarBackgroundColorDark,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        centerTitle: false),
  );
}

//Text theme light
TextTheme get getTextThemeDataLight {
  return TextTheme(
    headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontStyle: FontStyle.normal,
        height: 1.2,
        letterSpacing: 0.4),
    headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontStyle: FontStyle.normal,
        height: 1.2,
        letterSpacing: 0.4),
    headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontStyle: FontStyle.normal,
        height: 1.2,
        letterSpacing: 0.4),
    labelLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    ),
    labelMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    ),
    labelSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    ),
  );
}

//Input Decoration Theme

InputDecorationTheme get inputDecorationTheme {
  return InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],
    labelStyle: getTextThemeDataLight.bodySmall,
    hintStyle: getTextThemeDataLight.bodySmall,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(commonCornerRadius.r),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(commonCornerRadius.r),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(commonCornerRadius.r),
      borderSide: BorderSide.none,
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(commonCornerRadius.r),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(commonCornerRadius.r),
      borderSide: BorderSide.none,
    ),
  );
}
