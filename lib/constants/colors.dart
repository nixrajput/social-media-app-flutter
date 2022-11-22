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
  static const Color primaryLightColor = Color.fromARGB(255, 130, 170, 240);

  static const Color linkColor = Color(0xFF2878F0);

  static const Color lightChatBubbleColor = Color.fromARGB(255, 242, 242, 242);
  static const Color darkChatBubbleColor = Color.fromARGB(255, 18, 66, 148);

  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFF09C00);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);

  static const Color grayColor = Color(0xFFb4b4b4);
  static const Color darkGrayColor = Color(0xff787878);
  static const Color darkerGrayColor = Color(0xff505050);
  static const Color lightGrayColor = Color(0xffd2d2d2);

  static const Color darkDividerColor = Color(0xff707070);
  static const Color lightDividerColor = Color(0xffc2c2c2);

  static const Color lightBodyTextColor = Color(0xFF282828);
  static const Color lightSubtitleTextColor = Color(0xFF737373);
  static const Color darkBodyTextColor = Color(0xFFDCDCDC);
  static const Color darkSubtitleTextColor = Color(0xFFA0A0A0);

  static const Color lightBgColor = Color.fromRGBO(236, 236, 236, 1.0);
  static const Color lightDialogColor = Color.fromRGBO(250, 250, 250, 1.0);
  static const Color darkBgColor = Color.fromRGBO(18, 18, 30, 1.0);
  static const Color darkDialogColor = Color.fromARGB(255, 41, 42, 56);

  static const primaryGrad = LinearGradient(
    colors: [primaryColor, primaryLightColor],
  );
}
