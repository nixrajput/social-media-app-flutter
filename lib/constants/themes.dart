import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.sixTeen),
          topRight: Radius.circular(Dimens.sixTeen),
        ),
      ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.sixTeen),
          topRight: Radius.circular(Dimens.sixTeen),
        ),
      ),
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

const appThemeModes = {'System', 'Light', 'Dark'};

class AppThemeController extends GetxController {
  final themeData = GetStorage();

  final _themeMode = Rx(appThemeModes.first);

  String get themeMode => _themeMode.value;

  @override
  void onInit() {
    themeData.writeIfNull(StringValues.themeMode, appThemeModes.first);
    getThemeMode();
    super.onInit();
  }

  void setThemeMode(value) {
    _themeMode(value);
    themeData.write(StringValues.themeMode, value);
    update();
  }

  void getThemeMode() {
    String themeMode = themeData.read(StringValues.themeMode);
    _themeMode(themeMode);
    update();
  }
}
