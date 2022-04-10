import 'package:flutter/material.dart';

abstract class ColorValues {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF02B290,
    {
      50: Color.fromRGBO(2, 178, 144, .1),
      100: Color.fromRGBO(2, 178, 144, .2),
      200: Color.fromRGBO(2, 178, 144, .3),
      300: Color.fromRGBO(2, 178, 144, .4),
      400: Color.fromRGBO(2, 178, 144, .5),
      500: Color.fromRGBO(2, 178, 144, .6),
      600: Color.fromRGBO(2, 178, 144, .7),
      700: Color.fromRGBO(2, 178, 144, .8),
      800: Color.fromRGBO(2, 178, 144, .9),
      900: Color.fromRGBO(2, 178, 144, 1),
    },
  );

  static const Color primaryColor = Color(0xFF02B290);
  static const Color primaryLightColor = Color(0xff61b6a6);
  static const Color primaryTextColor = Color(0xFF505050);

  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFF09C00);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);

  static const Color grayColor = Color(0xFFb4b4b4);
  static const Color darkGrayColor = Color(0xFF8d8d8d);
  static const Color darkerGrayColor = Color(0xff575757);
  static const Color lightGrayColor = Color(0xFFdbdbdb);

  static const Color lightBgColor = Color.fromRGBO(240, 240, 240, 1.0);
  static const Color darkBgColor = Color.fromRGBO(30, 30, 40, 1.0);
  static const Color darkColor = Color.fromRGBO(44, 44, 50, 1.0);
}
