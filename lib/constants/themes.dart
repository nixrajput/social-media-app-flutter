import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/constants/colors.dart';

abstract class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: ColorValues.primarySwatch,
    ),
    iconTheme: const IconThemeData(color: ColorValues.grayColor),
    scaffoldBackgroundColor: ColorValues.lightBgColor,
    appBarTheme: const AppBarTheme(backgroundColor: ColorValues.lightBgColor),
    bottomAppBarColor: ColorValues.lightBgColor,
    shadowColor: ColorValues.lightGrayColor,
    cardTheme: const CardTheme(color: ColorValues.whiteColor),
    dialogTheme: const DialogTheme(backgroundColor: ColorValues.whiteColor),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: ColorValues.lightBgColor),
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
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ColorValues.primarySwatch,
    ),
    iconTheme: const IconThemeData(color: ColorValues.grayColor),
    scaffoldBackgroundColor: ColorValues.darkBgColor,
    shadowColor: ColorValues.lightGrayColor,
    appBarTheme: const AppBarTheme(backgroundColor: ColorValues.darkBgColor),
    bottomAppBarColor: ColorValues.darkBgColor,
    cardTheme: const CardTheme(color: ColorValues.darkBgColor),
    dialogTheme: const DialogTheme(backgroundColor: ColorValues.darkBgColor),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: ColorValues.darkBgColor),
    dividerColor: ColorValues.grayColor,
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
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

class AppThemeController extends GetxController {
  final themeData = GetStorage();

  final _themeMode = false.obs;
  bool get themeMode => _themeMode.value;

  @override
  void onInit() {
    themeData.writeIfNull('darkMode', false);
    getThemeMode();
    super.onInit();
  }

  void toggleThemeMode(value) {
    _themeMode(value);
    themeData.write('darkMode', value);
    update();
  }

  void getThemeMode() {
    bool isDarkMode = themeData.read('darkMode');
    _themeMode(isDarkMode);
    update();
  }
}
