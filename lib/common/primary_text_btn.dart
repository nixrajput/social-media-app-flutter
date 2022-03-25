import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? fontSize;
  final Color? textColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const NxTextButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.textColor,
    this.padding,
    this.margin,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? Dimens.edgeInsets0,
        margin: margin ?? Dimens.edgeInsets0,
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? Dimens.sixTeen,
            fontWeight: FontWeight.bold,
            color: textColor ?? ColorValues.primaryColor,
          ),
        ),
      ),
    );
  }
}
