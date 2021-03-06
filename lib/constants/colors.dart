import 'package:flutter/material.dart';

abstract class ColorValues {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF2878F0,
    {
      50: Color.fromRGBO(40, 120, 240, .1),
      100: Color.fromRGBO(40, 120, 240, .2),
      200: Color.fromRGBO(40, 120, 240, .3),
      300: Color.fromRGBO(40, 120, 240, .4),
      400: Color.fromRGBO(40, 120, 240, .5),
      500: Color.fromRGBO(40, 120, 240, .6),
      600: Color.fromRGBO(40, 120, 240, .7),
      700: Color.fromRGBO(40, 120, 240, .8),
      800: Color.fromRGBO(40, 120, 240, .9),
      900: Color.fromRGBO(40, 120, 240, 1),
    },
  );

  static const Color primaryColor = Color(0xFF2878F0);
  static const Color primaryLightColor = Color(0xFF72A3ED);
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

  static const Color lightBgColor = Color.fromRGBO(245, 245, 245, 1.0);
  static const Color darkBgColor = Color.fromRGBO(0, 27, 43, 1.0);
  static const Color darkColor = Color.fromARGB(255, 23, 39, 49);
}
