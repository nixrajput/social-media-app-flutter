import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double? iconSize;
  final Color? bgColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final double? width;
  final bool? centerIcon;
  final double? height;

  const NxIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.bgColor,
    this.padding,
    this.iconSize,
    this.borderRadius,
    this.width,
    this.height,
    this.centerIcon = true,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius ?? Dimens.zero,
            ),
          ),
        ),
        child: centerIcon!
            ? Center(
                child: Icon(
                  icon,
                  size: iconSize ?? Dimens.twentyFour,
                  color: iconColor ?? Theme.of(context).iconTheme.color,
                ),
              )
            : Icon(
                icon,
                size: iconSize ?? Dimens.twentyFour,
                color: iconColor ?? Theme.of(context).iconTheme.color,
              ),
      ),
    );
  }
}
