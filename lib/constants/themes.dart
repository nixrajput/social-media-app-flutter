import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/styles.dart';

abstract class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light().copyWith(
      primary: ColorValues.primarySwatch,
    ),
    iconTheme: const IconThemeData(color: ColorValues.darkGrayColor),
    scaffoldBackgroundColor: ColorValues.lightBgColor,
    appBarTheme: const AppBarTheme(backgroundColor: ColorValues.lightBgColor),
    bottomAppBarColor: ColorValues.lightDialogColor,
    shadowColor: ColorValues.blackColor.withOpacity(0.1),
    cardTheme: const CardTheme(color: ColorValues.lightDialogColor),
    dialogTheme:
        const DialogTheme(backgroundColor: ColorValues.lightDialogColor),
    dialogBackgroundColor: ColorValues.lightDialogColor,
    errorColor: ColorValues.errorColor,
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: ColorValues.lightDialogColor,
    ),
    dividerColor: ColorValues.lightDividerColor,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorValues.darkDialogColor,
      contentTextStyle: AppStyles.style14Normal.copyWith(
        color: ColorValues.darkBodyTextColor,
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
        color: ColorValues.lightSubtitle2TextColor,
        fontFamily: 'Lato',
      ),
    ),
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ColorValues.primarySwatch,
    ),
    iconTheme: const IconThemeData(color: ColorValues.darkGrayColor),
    scaffoldBackgroundColor: ColorValues.darkBgColor,
    shadowColor: ColorValues.blackColor.withOpacity(0.1),
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
      backgroundColor: ColorValues.lightDialogColor,
      contentTextStyle: TextStyle(
        color: ColorValues.lightBodyTextColor,
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
        color: ColorValues.darkSubtitle2TextColor,
        fontFamily: 'Lato',
      ),
    ),
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
