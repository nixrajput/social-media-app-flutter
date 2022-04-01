import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';

abstract class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: ColorValues.primarySwatch,
    ),
    iconTheme: const IconThemeData(color: ColorValues.darkGrayColor),
    scaffoldBackgroundColor: ColorValues.lightBgColor,
    appBarTheme: const AppBarTheme(backgroundColor: ColorValues.lightBgColor),
    bottomAppBarColor: ColorValues.lightBgColor,
    shadowColor: ColorValues.lightGrayColor,
    cardTheme: const CardTheme(color: ColorValues.whiteColor),
    dialogTheme: const DialogTheme(backgroundColor: ColorValues.whiteColor),
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: ColorValues.whiteColor,
    ),
    dividerColor: ColorValues.grayColor,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ColorValues.darkBgColor,
      contentTextStyle: TextStyle(
        color: ColorValues.whiteColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: const ButtonStyle().copyWith(
        backgroundColor: MaterialStateProperty.all(ColorValues.primaryColor),
        foregroundColor: MaterialStateProperty.all(ColorValues.whiteColor),
        elevation: MaterialStateProperty.all(0.0),
      ),
    ),
    textTheme: const TextTheme().copyWith(
      bodyText1: const TextStyle(
        color: ColorValues.darkBgColor,
      ),
      subtitle1: const TextStyle(
        color: ColorValues.darkGrayColor,
      ),
    ),
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ColorValues.primarySwatch,
    ),
    iconTheme: const IconThemeData(color: ColorValues.darkGrayColor),
    scaffoldBackgroundColor: ColorValues.darkBgColor,
    shadowColor: ColorValues.lightGrayColor,
    appBarTheme: const AppBarTheme(backgroundColor: ColorValues.darkBgColor),
    bottomAppBarColor: ColorValues.darkBgColor,
    cardTheme: const CardTheme(color: ColorValues.darkColor),
    dialogTheme: const DialogTheme(backgroundColor: ColorValues.darkColor),
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: ColorValues.darkColor,
    ),
    dividerColor: ColorValues.darkerGrayColor,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ColorValues.lightBgColor,
      contentTextStyle: TextStyle(
        color: ColorValues.blackColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: const ButtonStyle().copyWith(
        backgroundColor: MaterialStateProperty.all(ColorValues.primaryColor),
        foregroundColor: MaterialStateProperty.all(ColorValues.whiteColor),
        elevation: MaterialStateProperty.all(0.0),
      ),
    ),
    textTheme: const TextTheme().copyWith(
      bodyText1: const TextStyle(
        color: ColorValues.lightBgColor,
      ),
      subtitle1: const TextStyle(
        color: ColorValues.grayColor,
      ),
    ),
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
