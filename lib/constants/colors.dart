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
  static const Color transparent = Color(0x00000000);

  static const Color grayColor = Color(0xFFb4b4b4);
  static const Color darkGrayColor = Color(0xff787878);
  static const Color darkerGrayColor = Color(0xff505050);
  static const Color lightGrayColor = Color(0xffd2d2d2);

  static const Color darkDividerColor = Color(0xff707070);
  static const Color lightDividerColor = Color.fromARGB(255, 192, 192, 192);

  static const Color lightBodyTextColor = Color(0xFF282828);
  static const Color lightSubtitleTextColor = Color.fromARGB(255, 92, 92, 92);
  static const Color lightSubtitle2TextColor =
      Color.fromARGB(255, 141, 141, 141);
  static const Color darkBodyTextColor = Color.fromARGB(255, 228, 228, 228);
  static const Color darkSubtitleTextColor = Color.fromARGB(255, 180, 180, 180);
  static const Color darkSubtitle2TextColor =
      Color.fromARGB(255, 124, 124, 124);

  static const Color lightBgColor = Color.fromARGB(255, 250, 250, 250);
  static const Color lightDialogColor = Color.fromARGB(255, 236, 236, 236);
  static const Color darkBgColor = Color.fromARGB(255, 18, 18, 30);
  static const Color darkDialogColor = Color.fromARGB(255, 40, 40, 50);

  static const Color lightShadowColor = Color.fromARGB(255, 0, 0, 0);
  static const Color darkShadowColor = Color.fromARGB(255, 200, 200, 200);

  static const primaryGrad = LinearGradient(
    colors: [primaryColor, primaryLightColor],
  );
}
