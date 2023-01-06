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

  static const Color primaryColor = Color.fromARGB(255, 238, 113, 30);
  static const Color primaryLightColor = Color.fromARGB(255, 235, 146, 87);

  static const Color linkColor = Color.fromARGB(255, 56, 130, 240);

  static const Color lightChatBubbleColor = Color.fromARGB(255, 242, 242, 242);
  static const Color darkChatBubbleColor = Color.fromARGB(255, 18, 66, 148);

  static const Color successColor = Color.fromARGB(255, 76, 175, 80);
  static const Color errorColor = Color.fromARGB(255, 244, 67, 54);
  static const Color warningColor = Color.fromARGB(255, 240, 156, 0);

  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color blackColor = Color.fromARGB(255, 0, 0, 0);
  static const Color transparent = Color(0x00000000);

  static const Color grayColor = Color.fromARGB(255, 180, 180, 180);
  static const Color darkGrayColor = Color.fromARGB(255, 120, 120, 120);
  static const Color darkerGrayColor = Color.fromARGB(255, 80, 80, 80);
  static const Color lightGrayColor = Color.fromARGB(255, 210, 210, 210);

  static const Color darkDividerColor = Color.fromARGB(255, 60, 60, 60);
  static const Color lightDividerColor = Color.fromARGB(255, 220, 220, 220);

  static const Color lightBodyTextColor = Color.fromARGB(255, 40, 40, 40);
  static const Color lightSubtitleTextColor = Color.fromARGB(255, 92, 92, 92);
  static const Color lightSubtitle2TextColor =
      Color.fromARGB(255, 141, 141, 141);
  static const Color darkBodyTextColor = Color.fromARGB(255, 228, 228, 228);
  static const Color darkSubtitleTextColor = Color.fromARGB(255, 180, 180, 180);
  static const Color darkSubtitle2TextColor =
      Color.fromARGB(255, 124, 124, 124);

  static const Color lightBgColor = Color.fromARGB(255, 252, 252, 252);
  static const Color lightDialogColor = Color.fromARGB(255, 232, 232, 232);
  static const Color darkBgColor = Color.fromARGB(255, 18, 18, 30);
  static const Color darkDialogColor = Color.fromARGB(255, 40, 40, 50);

  static const Color lightShadowColor = Color.fromARGB(255, 0, 0, 0);
  static const Color darkShadowColor = Color.fromARGB(255, 50, 50, 50);

  static const primaryGrad = LinearGradient(
    colors: [primaryColor, primaryLightColor],
  );
}
