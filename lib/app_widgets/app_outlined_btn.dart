import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';

class NxOutlinedButton extends StatelessWidget {
  const NxOutlinedButton({
    Key? key,
    this.bgColor,
    this.borderRadius,
    required this.label,
    this.prefix,
    this.suffix,
    this.labelColor,
    this.onTap,
    this.padding,
    this.width,
    this.height,
    this.fontSize,
    this.borderColor,
    this.borderWidth,
    this.labelStyle,
    this.borderStyle,
    this.minWidth,
    this.margin,
  }) : super(key: key);

  final Color? bgColor;
  final double? borderRadius;
  final String label;
  final Color? labelColor;
  final Color? borderColor;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderWidth;
  final double? minWidth;
  final BorderStyle? borderStyle;
  final TextStyle? labelStyle;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? Dimens.edgeInsets12_16,
        margin: margin,
        constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? ColorValues.primaryColor,
            width: borderWidth ?? Dimens.one,
            style: borderStyle ?? BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.twelve),
          color: bgColor ?? Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) prefix!,
            if (prefix != null) Dimens.boxWidth4,
            Text(
              label.toTitleCase(),
              style: labelStyle ??
                  AppStyles.style16Bold.copyWith(
                    color: labelColor ?? ColorValues.primaryColor,
                    fontSize: fontSize ?? Dimens.sixTeen,
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
