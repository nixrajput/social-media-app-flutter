import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/services/hive_service.dart';

const String kThemeModeBox = 'themeMode';
const String kThemeModeKey = 'themeMode';
const String kSystemMode = 'system';
const String kLightMode = 'light';
const String kDarkMode = 'dark';
const String kDefaultFontFamily = 'Poppins';

class AppThemeController extends GetxController {
  final _themeMode = kSystemMode.obs;

  @override
  void onInit() {
    super.onInit();
    getThemeMode();
  }

  static AppThemeController get find => Get.find();

  String get themeMode => _themeMode.value;

  void getSystemChromeData() {
    var themeBrightness = SchedulerBinding.instance.window.platformBrightness;

    if (themeMode == kLightMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ColorValues.lightBgColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: ColorValues.lightBgColor,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else if (themeMode == kDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ColorValues.darkBgColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: ColorValues.darkBgColor,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      if (themeBrightness == Brightness.light) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: ColorValues.lightBgColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: ColorValues.lightBgColor,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: ColorValues.darkBgColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: ColorValues.darkBgColor,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        );
      }
    }
  }

  ThemeData getLightThemeData() {
    getSystemChromeData();
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: ColorValues.primaryColor,
      iconTheme: const IconThemeData(color: ColorValues.lightGrayColor),
      scaffoldBackgroundColor: ColorValues.lightBgColor,
      appBarTheme: const AppBarTheme(backgroundColor: ColorValues.lightBgColor),
      bottomAppBarColor: ColorValues.lightDialogColor,
      shadowColor: ColorValues.shadowColor.withAlpha(12),
      cardTheme: const CardTheme(color: ColorValues.lightDialogColor),
      dialogTheme:
          const DialogTheme(backgroundColor: ColorValues.lightDialogColor),
      dialogBackgroundColor: ColorValues.lightDialogColor,
      errorColor: ColorValues.errorColor,
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: ColorValues.lightDialogColor,
      ),
      dividerColor: ColorValues.lightDividerColor,
      disabledColor: ColorValues.lightGrayColor,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorValues.darkBgColor,
        contentTextStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.darkBodyTextColor,
        ),
        actionTextColor: ColorValues.primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: const ButtonStyle().copyWith(
          backgroundColor: MaterialStateProperty.all(ColorValues.primaryColor),
          foregroundColor: MaterialStateProperty.all(ColorValues.whiteColor),
          elevation: MaterialStateProperty.all(0.0),
        ),
      ),
      fontFamily: kDefaultFontFamily,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorValues.lightDialogColor,
        constraints: BoxConstraints(
          minHeight: Dimens.fiftySix,
          maxWidth: Dimens.screenWidth,
        ),
        labelStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.lightBodyTextColor,
        ),
        floatingLabelStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.lightBodyTextColor.withAlpha(140),
        ),
        hintStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.lightBodyTextColor.withAlpha(140),
        ),
        errorStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.errorColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.lightDividerColor,
            width: Dimens.pointFour,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.lightDividerColor.withAlpha(20),
            width: Dimens.pointFour,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.lightDividerColor,
            width: Dimens.pointFour,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.primaryColor,
            width: Dimens.pointEight,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.errorColor,
            width: Dimens.pointEight,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.errorColor,
            width: Dimens.pointEight,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
      ),
      textTheme: const TextTheme().copyWith(
        bodyText1: const TextStyle(
          color: ColorValues.lightBodyTextColor,
        ),
        bodyText2: const TextStyle(
          color: ColorValues.lightBodyTextColor,
        ),
        subtitle1: TextStyle(
          color: ColorValues.lightBodyTextColor.withAlpha(180),
        ),
        subtitle2: TextStyle(
          color: ColorValues.lightBodyTextColor.withAlpha(140),
        ),
      ),
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData getDarkThemeData() {
    getSystemChromeData();
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: ColorValues.primaryColor,
      iconTheme: const IconThemeData(color: ColorValues.darkGrayColor),
      scaffoldBackgroundColor: ColorValues.darkBgColor,
      shadowColor: ColorValues.shadowColor.withAlpha(12),
      appBarTheme: const AppBarTheme(backgroundColor: ColorValues.darkBgColor),
      bottomAppBarColor: ColorValues.darkDialogColor,
      cardTheme: const CardTheme(color: ColorValues.darkDialogColor),
      dialogTheme:
          const DialogTheme(backgroundColor: ColorValues.darkDialogColor),
      dialogBackgroundColor: ColorValues.darkDialogColor,
      errorColor: ColorValues.errorColor,
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: ColorValues.darkDialogColor,
      ),
      dividerColor: ColorValues.darkDividerColor,
      disabledColor: ColorValues.darkGrayColor,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: ColorValues.lightBgColor,
        contentTextStyle: TextStyle(
          color: ColorValues.lightBodyTextColor,
        ),
        actionTextColor: ColorValues.primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: const ButtonStyle().copyWith(
          backgroundColor: MaterialStateProperty.all(ColorValues.primaryColor),
          foregroundColor: MaterialStateProperty.all(ColorValues.whiteColor),
          elevation: MaterialStateProperty.all(0.0),
        ),
      ),
      fontFamily: kDefaultFontFamily,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorValues.darkDialogColor,
        constraints: BoxConstraints(
          minHeight: Dimens.fiftySix,
          maxWidth: Dimens.screenWidth,
        ),
        labelStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.darkBodyTextColor,
        ),
        floatingLabelStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.darkBodyTextColor.withAlpha(140),
        ),
        hintStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.darkBodyTextColor.withAlpha(140),
        ),
        errorStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.errorColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.darkDividerColor,
            width: Dimens.pointFour,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.darkDividerColor,
            width: Dimens.pointFour,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.darkDividerColor,
            width: Dimens.pointFour,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.primaryColor,
            width: Dimens.pointEight,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.errorColor,
            width: Dimens.pointEight,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorValues.errorColor,
            width: Dimens.pointEight,
          ),
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
      ),
      textTheme: const TextTheme().copyWith(
        bodyText1: const TextStyle(
          color: ColorValues.darkBodyTextColor,
        ),
        bodyText2: const TextStyle(
          color: ColorValues.darkBodyTextColor,
        ),
        subtitle1: TextStyle(
          color: ColorValues.darkBodyTextColor.withAlpha(180),
        ),
        subtitle2: TextStyle(
          color: ColorValues.darkBodyTextColor.withAlpha(140),
        ),
      ),
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void setThemeMode(String mode) async {
    _themeMode.value = mode;
    await HiveService.put<String>(kThemeModeBox, kThemeModeKey, mode);
    update();
  }

  void getThemeMode() async {
    var themeMode = await HiveService.get<String>(kThemeModeBox, kThemeModeKey);

    switch (themeMode) {
      case kSystemMode:
        _themeMode.value = kSystemMode;
        break;
      case kLightMode:
        _themeMode.value = kLightMode;
        break;
      case kDarkMode:
        _themeMode.value = kDarkMode;
        break;
      default:
        _themeMode.value = kSystemMode;
        break;
    }
    update();
  }
}
