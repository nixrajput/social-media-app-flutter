import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';

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
    this.labelStyle,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? Dimens.fiftySix,
        padding: padding,
        constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.eight),
          color: bgColor ?? Theme.of(context).textTheme.bodyText1!.color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) prefix!,
            if (prefix != null) Dimens.boxWidth4,
            Text(
              label,
              style: labelStyle ??
                  AppStyles.style16Bold.copyWith(
                    color:
                        labelColor ?? Theme.of(context).scaffoldBackgroundColor,
                    fontSize: fontSize ?? Dimens.sixTeen,
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
