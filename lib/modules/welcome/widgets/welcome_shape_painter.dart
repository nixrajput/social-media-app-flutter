import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = Theme.of(Get.context!).dialogTheme.backgroundColor!;

    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.5,
        size.width * 0.93, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.92, size.height * 0.15,
        size.width * 0.7, size.height * 0.08);
    path.lineTo(size.width * 0.45, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
