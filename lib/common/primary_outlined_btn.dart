import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxOutlinedButton extends StatelessWidget {
  const NxOutlinedButton({
    Key? key,
    this.bgColor,
    this.borderRadius,
    required this.label,
    this.prefix,
    this.suffix,
    this.labelColor,
    required this.onTap,
    this.padding,
    this.width,
    this.height,
    this.fontSize,
    this.borderColor,
    this.borderWidth,
    this.borderStyle,
  }) : super(key: key);

  final Color? bgColor;
  final double? borderRadius;
  final String label;
  final Color? labelColor;
  final Color? borderColor;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderWidth;
  final BorderStyle? borderStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? width,
      height: height ?? height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          elevation: Dimens.zero,
          backgroundColor: bgColor ?? Colors.transparent,
          primary: Colors.transparent,
          padding: padding ?? Dimens.edgeInsets8,
          side: BorderSide(
            color: borderColor ?? Theme.of(context).iconTheme.color!,
            width: borderWidth ?? Dimens.one,
            style: borderStyle ?? BorderStyle.solid,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? Dimens.four,
            ),
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
                color:
                    labelColor ?? Theme.of(context).textTheme.bodyText1!.color!,
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
