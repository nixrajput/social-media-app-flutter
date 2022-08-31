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
    dialogBackgroundColor: ColorValues.whiteColor,
    errorColor: ColorValues.errorColor,
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: ColorValues.whiteColor,
    ),
    dividerColor: ColorValues.grayColor,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ColorValues.whiteColor,
      contentTextStyle: TextStyle(
        color: ColorValues.darkColor,
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
        color: ColorValues.lightBodyTextColor,
        fontFamily: 'Lato',
      ),
      bodyText2: const TextStyle(
        color: ColorValues.lightBodyTextColor,
        fontFamily: 'Lato',
      ),
      subtitle1: const TextStyle(
        color: ColorValues.lightSubtitleTextColor,
        fontFamily: 'Lato',
      ),
      subtitle2: const TextStyle(
        color: ColorValues.lightSubtitleTextColor,
        fontFamily: 'Lato',
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
    dialogBackgroundColor: ColorValues.darkColor,
    errorColor: ColorValues.errorColor,
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: ColorValues.darkColor,
    ),
    dividerColor: ColorValues.darkGrayColor,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ColorValues.darkColor,
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
        color: ColorValues.darkBodyTextColor,
        fontFamily: 'Lato',
      ),
      bodyText2: const TextStyle(
        color: ColorValues.darkBodyTextColor,
        fontFamily: 'Lato',
      ),
      subtitle1: const TextStyle(
        color: ColorValues.darkSubtitleTextColor,
        fontFamily: 'Lato',
      ),
      subtitle2: const TextStyle(
        color: ColorValues.darkSubtitleTextColor,
        fontFamily: 'Lato',
      ),
    ),
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
