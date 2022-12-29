import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class LinearProgressPainter extends CustomPainter {
  const LinearProgressPainter({
    required this.valueColor,
    required this.value,
    required this.textDirection,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final Color valueColor;
  final double value;
  final TextDirection textDirection;
  final double? borderRadius;
  final double? borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = borderColor ?? ColorValues.lightDividerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth ?? Dimens.one;

    final valuePaint = Paint()
      ..color = backgroundColor ?? ColorValues.transparent
      ..style = PaintingStyle.fill;

    valuePaint.color = valueColor;

    void drawBorder(double x, double width) {
      if (width <= 0.0) {
        return;
      }

      final double left;
      switch (textDirection) {
        case TextDirection.rtl:
          left = size.width - width - x;
          break;
        case TextDirection.ltr:
          left = x;
          break;
      }

      canvas.drawRRect(
        RRect.fromRectAndRadius(Offset(left, 0.0) & Size(width, size.height),
            Radius.circular(borderRadius ?? Dimens.four)),
        borderPaint,
      );
    }

    void drawBar(double x, double width) {
      if (width <= 0.0) {
        return;
      }

      final double left;
      switch (textDirection) {
        case TextDirection.rtl:
          left = size.width - width - x;
          break;
        case TextDirection.ltr:
          left = x;
          break;
      }

      canvas.drawRRect(
          RRect.fromRectAndRadius(Offset(left, 0.0) & Size(width, size.height),
              Radius.circular(borderRadius ?? Dimens.four)),
          valuePaint);
    }

    drawBorder(0.0, size.width);
    drawBar(0.0, value.clamp(0.0, 1.0) * size.width);
  }

  @override
  bool shouldRepaint(LinearProgressPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueColor != valueColor ||
        oldDelegate.value != value ||
        oldDelegate.textDirection != textDirection;
  }
}
