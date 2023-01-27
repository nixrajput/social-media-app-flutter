import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

abstract class AppStyles {
  static String get defaultFontFamily => 'Poppins';

  static String get mugeFontFamily => 'Muge';

  static double get defaultHeight => 1.25;

  static const Color kShadowColor = Color.fromARGB(255, 0, 0, 0);

  static List<BoxShadow> get defaultShadow => [
        BoxShadow(
          color: kShadowColor.withAlpha(14),
          blurRadius: Dimens.four,
          spreadRadius: Dimens.zero,
          offset: Offset(Dimens.zero, Dimens.three),
        ),
        BoxShadow(
          color: kShadowColor.withAlpha(12),
          blurRadius: Dimens.three,
          spreadRadius: -Dimens.two,
          offset: Offset(Dimens.zero, Dimens.three),
        ),
        BoxShadow(
          color: kShadowColor.withAlpha(2),
          blurRadius: Dimens.eight,
          spreadRadius: Dimens.zero,
          offset: Offset(Dimens.zero, Dimens.one),
        ),
      ];

  static TextStyle style10Normal = TextStyle(
    fontSize: Dimens.ten,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style10Bold = TextStyle(
    fontSize: Dimens.ten,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style11Normal = TextStyle(
    fontSize: Dimens.eleven,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style11Bold = TextStyle(
    fontSize: Dimens.eleven,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style12Normal = TextStyle(
    fontSize: Dimens.twelve,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style12Bold = TextStyle(
    fontSize: Dimens.twelve,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style13Normal = TextStyle(
    fontSize: Dimens.thirteen,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style13Bold = TextStyle(
    fontSize: Dimens.thirteen,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style13Black = TextStyle(
    fontSize: Dimens.thirteen,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style14Normal = TextStyle(
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style14Bold = TextStyle(
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style14Black = TextStyle(
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style15Normal = TextStyle(
    fontSize: Dimens.fifteen,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style15Bold = TextStyle(
    fontSize: Dimens.fifteen,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style15Black = TextStyle(
    fontSize: Dimens.fifteen,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style16Normal = TextStyle(
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style16Bold = TextStyle(
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style16Black = TextStyle(
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style18Normal = TextStyle(
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style18Bold = TextStyle(
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style20Normal = TextStyle(
    fontSize: Dimens.twenty,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style20Bold = TextStyle(
    fontSize: Dimens.twenty,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style20Black = TextStyle(
    fontSize: Dimens.twenty,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style24Normal = TextStyle(
    fontSize: Dimens.twentyFour,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style24Bold = TextStyle(
    fontSize: Dimens.twentyFour,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style24Black = TextStyle(
    fontSize: Dimens.twentyFour,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style28Normal = TextStyle(
    fontSize: Dimens.twentyEight,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style28Bold = TextStyle(
    fontSize: Dimens.twentyEight,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style32Normal = TextStyle(
    fontSize: Dimens.thirtyTwo,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style32Bold = TextStyle(
    fontSize: Dimens.thirtyTwo,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style32Black = TextStyle(
    fontSize: Dimens.thirtyTwo,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style36Normal = TextStyle(
    fontSize: Dimens.thirtySix,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style36Bold = TextStyle(
    fontSize: Dimens.thirtySix,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style36Black = TextStyle(
    fontSize: Dimens.thirtySix,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style40Normal = TextStyle(
    fontSize: Dimens.fourty,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style40Bold = TextStyle(
    fontSize: Dimens.fourty,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style40Black = TextStyle(
    fontSize: Dimens.fourty,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style48Normal = TextStyle(
    fontSize: Dimens.fourtyEight,
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style48Bold = TextStyle(
    fontSize: Dimens.fourtyEight,
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );

  static TextStyle style48Black = TextStyle(
    fontSize: Dimens.fourtyEight,
    fontWeight: FontWeight.w900,
    fontFamily: defaultFontFamily,
    height: defaultHeight,
  );
}
