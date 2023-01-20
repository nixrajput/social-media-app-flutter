import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

const double _kDefaultAnimationAngle = 2 * 3.14;

class NxAnimatedIcon extends StatelessWidget {
  const NxAnimatedIcon({
    super.key,
    required this.icon,
    required this.controller,
    this.color,
    this.size,
    this.angle,
  });

  final IconData icon;
  final Color? color;
  final double? size;
  final double? angle;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, child) {
        return Transform.rotate(
          angle: controller.value * (angle ?? _kDefaultAnimationAngle),
          child: child,
        );
      },
      child: Icon(
        icon,
        size: size ?? Dimens.twentyFour,
        color: color ?? Theme.of(context).iconTheme.color,
      ),
    );
  }
}
