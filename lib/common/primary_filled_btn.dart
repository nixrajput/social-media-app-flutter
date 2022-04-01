import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxFilledButton extends StatelessWidget {
  const NxFilledButton({
    Key? key,
    this.bgColor,
    this.borderRadius,
    required this.label,
    this.prefix,
    this.suffix,
    this.labelColor,
    this.onTap,
    this.padding,
    this.fontSize,
    this.width,
    this.height,
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? Dimens.fiftyFour,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: Dimens.zero,
          padding: padding ?? Dimens.edgeInsets8,
          primary: bgColor ?? ColorValues.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? Dimens.four,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) Container(child: prefix),
            if (prefix != null) Dimens.boxWidth4,
            Text(
              label,
              style: TextStyle(
                color: labelColor ?? ColorValues.whiteColor,
                fontSize: fontSize ?? Dimens.fourteen,
              ),
            ),
            if (suffix != null) Dimens.boxWidth4,
            if (suffix != null) Container(child: suffix),
          ],
        ),
      ),
    );
  }
}
