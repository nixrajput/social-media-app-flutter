import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

const String kThemeModeBox = 'themeMode';
const String kThemeModeKey = 'themeMode';
const String kSystemMode = 'system';
const String kLightMode = 'light';
const String kDarkMode = 'dark';

class AppThemeController extends GetxController {
  static AppThemeController get find => Get.find();

  final _themeMode = kSystemMode.obs;

  String get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    getThemeMode();
  }

  void getSystemChromeData() {
    var themeBrightness = SchedulerBinding.instance.window.platformBrightness;

    AppUtility.log('themeBrightness: $themeBrightness, themeMode: $themeMode');

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
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: ColorValues.primaryColor,
      iconTheme: const IconThemeData(color: ColorValues.lightGrayColor),
      scaffoldBackgroundColor: ColorValues.lightBgColor,
      appBarTheme: const AppBarTheme(backgroundColor: ColorValues.lightBgColor),
      bottomAppBarColor: ColorValues.lightDialogColor,
      shadowColor: ColorValues.lightShadowColor.withOpacity(0.1),
      cardTheme: const CardTheme(color: ColorValues.lightBgColor),
      dialogTheme:
          const DialogTheme(backgroundColor: ColorValues.lightDialogColor),
      dialogBackgroundColor: ColorValues.lightDialogColor,
      errorColor: ColorValues.errorColor,
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: ColorValues.lightDialogColor,
      ),
      dividerColor: ColorValues.lightDividerColor,
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
          color: ColorValues.lightSubtitle2TextColor,
          fontFamily: 'Lato',
        ),
      ),
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData getDarkThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: ColorValues.primaryColor,
      iconTheme: const IconThemeData(color: ColorValues.darkGrayColor),
      scaffoldBackgroundColor: ColorValues.darkBgColor,
      shadowColor: ColorValues.darkShadowColor.withOpacity(0.1),
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
          color: ColorValues.darkSubtitle2TextColor,
          fontFamily: 'Lato',
        ),
      ),
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void setThemeMode(String mode) async {
    _themeMode.value = mode;
    await HiveService.put<String>(kThemeModeBox, kThemeModeKey, mode);
    getSystemChromeData();
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

    getSystemChromeData();
    update();
  }
}
