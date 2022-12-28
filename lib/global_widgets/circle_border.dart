import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxCircleBorder extends StatelessWidget {
  const NxCircleBorder({
    super.key,
    this.child,
    this.radius,
    this.color,
    this.borderColor,
    this.borderWidth,
  });

  final Widget? child;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius ?? Dimens.thirtyTwo,
      height: radius ?? Dimens.thirtyTwo,
      decoration: BoxDecoration(
        color: color ?? ColorValues.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? Theme.of(context).dividerColor,
          width: borderWidth ?? Dimens.one,
        ),
      ),
      child: Center(child: child),
    );
  }
}
