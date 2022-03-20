import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

abstract class AppStyles {
  static var defaultTextColor = const TextTheme().titleLarge?.color;

  static TextStyle style12Normal = TextStyle(
    fontSize: Dimens.twelve,
    color: defaultTextColor,
  );

  static TextStyle style12Bold = TextStyle(
    fontSize: Dimens.twelve,
    fontWeight: FontWeight.bold,
    color: defaultTextColor,
  );

  static TextStyle style14Normal = TextStyle(
    fontSize: Dimens.fourteen,
    color: defaultTextColor,
  );

  static TextStyle style14Bold = TextStyle(
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.bold,
    color: defaultTextColor,
  );

  static TextStyle style16Normal = TextStyle(
    fontSize: Dimens.sixTeen,
    color: defaultTextColor,
  );

  static TextStyle style16Bold = TextStyle(
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.bold,
    color: defaultTextColor,
  );

  static TextStyle style18Normal = TextStyle(
    fontSize: Dimens.eighteen,
    color: defaultTextColor,
  );

  static TextStyle style18Bold = TextStyle(
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.bold,
    color: defaultTextColor,
  );

  static TextStyle style20Normal = TextStyle(
    fontSize: Dimens.twenty,
    color: defaultTextColor,
  );

  static TextStyle style20Bold = TextStyle(
    fontSize: Dimens.twenty,
    fontWeight: FontWeight.bold,
    color: defaultTextColor,
  );

  static TextStyle style24Normal = TextStyle(
    fontSize: Dimens.twentyFour,
    color: defaultTextColor,
  );

  static TextStyle style24Bold = TextStyle(
    fontSize: Dimens.twentyFour,
    fontWeight: FontWeight.bold,
    color: defaultTextColor,
  );

  static TextStyle style32Normal = TextStyle(
    fontSize: Dimens.thirtyTwo,
    color: defaultTextColor,
  );

  static TextStyle style32Bold = TextStyle(
    fontSize: Dimens.thirtyTwo,
    fontWeight: FontWeight.bold,
    color: defaultTextColor,
  );
}
