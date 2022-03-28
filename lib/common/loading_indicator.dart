import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxLoadingIndicator extends StatefulWidget {
  final double? size;
  final Color? strokeColor;
  final bool? transparentCenter;

  const NxLoadingIndicator({
    Key? key,
    this.size,
    this.strokeColor,
    this.transparentCenter = true,
  }) : super(key: key);

  @override
  _NxLoadingIndicatorState createState() => _NxLoadingIndicatorState();
}

class _NxLoadingIndicatorState extends State<NxLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<dynamic> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween(
      begin: 1.0,
      end: 1.25,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, w) {
        return Transform.rotate(
          angle: _controller.status == AnimationStatus.forward
              ? (math.pi * 2) * _controller.value
              : -(math.pi * 2) * _controller.value,
          child: SizedBox(
            width: widget.size ?? Dimens.thirtyTwo,
            height: widget.size ?? Dimens.thirtyTwo,
            child: CustomPaint(
              painter: LoaderCanvas(
                transparentCenter: widget.transparentCenter,
                radius: _animation.value,
                strokeColor:
                    widget.strokeColor ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoaderCanvas extends CustomPainter {
  final double radius;
  final Color? strokeColor;
  final bool? transparentCenter;

  LoaderCanvas({
    required this.radius,
    required this.strokeColor,
    this.transparentCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var _arc = Paint()
      ..color = strokeColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    var _circle = Paint()
      ..color = transparentCenter!
          ? Colors.transparent
          : ColorValues.primaryColor.withOpacity(0.25)
      ..style = PaintingStyle.fill;

    var _center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(_center, size.width / 2, _circle);

    canvas.drawArc(
        Rect.fromCenter(
          center: _center,
          width: size.width * radius,
          height: size.height * radius,
        ),
        math.pi / 2,
        math.pi / 2,
        false,
        _arc);

    canvas.drawArc(
        Rect.fromCenter(
          center: _center,
          width: size.width * radius,
          height: size.height * radius,
        ),
        -math.pi / 2,
        -math.pi / 2,
        false,
        _arc);
  }

  @override
  bool shouldRepaint(LoaderCanvas oldDelegate) {
    return true;
  }
}
