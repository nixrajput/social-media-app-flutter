import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = ThemeData.dark().dividerColor
    ..strokeWidth = Dimens.two
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
