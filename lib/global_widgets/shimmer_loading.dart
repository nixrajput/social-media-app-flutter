import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.circular = false,
    this.size,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final bool? circular;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circular == true ? size ?? Dimens.fourty : width,
      height: circular == true ? size ?? Dimens.fourty : height,
      decoration: circular == true
          ? BoxDecoration(
              color: color ?? ColorValues.grayColor.withOpacity(0.25),
              shape: BoxShape.circle,
            )
          : BoxDecoration(
              color: color ?? ColorValues.grayColor.withOpacity(0.25),
              borderRadius: BorderRadius.circular(borderRadius ?? Dimens.zero),
            ),
    )
        .animate(onPlay: (controller) => controller.repeat(), delay: 5000.ms)
        .shimmer(
          duration: 3000.ms,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        );
  }
}
