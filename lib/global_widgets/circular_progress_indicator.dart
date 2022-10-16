import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxCircularProgressIndicator extends StatelessWidget {
  const NxCircularProgressIndicator({
    Key? key,
    this.size,
    this.strokeWidth,
    this.color,
    this.value,
  }) : super(key: key);

  final double? size;
  final double? strokeWidth;
  final Color? color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? Dimens.fourty,
      height: size ?? Dimens.fourty,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? Dimens.two,
        color: color ?? ColorValues.primaryColor,
        value: value,
      ),
    );
  }
}
