import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = Theme.of(Get.context!).dialogTheme.backgroundColor!;

    var path = Path();

    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.68, size.height * 0.4);
    path.quadraticBezierTo(
        size.width, size.height * 0.33, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
