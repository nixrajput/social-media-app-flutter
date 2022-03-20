import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxFilledButton extends StatelessWidget {
  final Color? bgColor;
  final double? borderRadius;
  final String label;
  final Color? labelColor;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double? fontSize;
  final bool? disabled;

  const NxFilledButton({
    Key? key,
    this.bgColor,
    this.borderRadius,
    required this.label,
    this.prefix,
    this.suffix,
    this.labelColor,
    required this.onTap,
    this.padding,
    this.fontSize,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled! ? null : onTap,
      child: Container(
        padding: padding ?? Dimens.edgeInsets16_8,
        decoration: BoxDecoration(
          color: bgColor != null
              ? disabled!
                  ? bgColor!.withOpacity(0.5)
                  : bgColor
              : disabled!
                  ? ColorValues.primaryColor.withOpacity(0.5)
                  : ColorValues.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? Dimens.thirtyTwo),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) Container(child: prefix),
            if (prefix != null) Dimens.boxWidth4,
            Text(
              label,
              style: TextStyle(
                color: labelColor != null
                    ? disabled!
                        ? labelColor!.withOpacity(0.5)
                        : labelColor
                    : disabled!
                        ? ColorValues.whiteColor.withOpacity(0.5)
                        : ColorValues.whiteColor,
                fontSize: fontSize ?? Dimens.sixTeen,
                fontWeight: FontWeight.bold,
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
