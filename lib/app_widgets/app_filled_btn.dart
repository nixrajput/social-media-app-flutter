import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';

class NxFilledButton extends StatelessWidget {
  const NxFilledButton({
    Key? key,
    required this.label,
    this.bgColor,
    this.borderRadius,
    this.prefix,
    this.suffix,
    this.labelColor,
    this.onTap,
    this.padding,
    this.fontSize,
    this.width,
    this.height,
    this.labelStyle,
    this.margin,
  }) : super(key: key);

  final Color? bgColor;
  final double? borderRadius;
  final String label;
  final Color? labelColor;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? Dimens.edgeInsets16,
        margin: margin,
        constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.twelve),
          color: bgColor ?? ColorValues.primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefix != null) prefix!,
            if (prefix != null) Dimens.boxWidth4,
            Text(
              label,
              style: labelStyle ??
                  AppStyles.p.copyWith(
                    color: labelColor ?? ColorValues.whiteColor,
                    fontSize: fontSize ?? Dimens.fourteen,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (suffix != null) Dimens.boxWidth4,
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}
