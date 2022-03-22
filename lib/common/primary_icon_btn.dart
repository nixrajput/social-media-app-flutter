import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double? iconSize;
  final Color? bgColor;
  final EdgeInsets? padding;
  final double? borderRadius;

  const NxIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.bgColor,
    this.padding,
    this.iconSize,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? Dimens.edgeInsets0,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius ?? Dimens.zero,
            ),
          ),
        ),
        child: Icon(
          icon,
          size: iconSize ?? Dimens.twentyFour,
          color: iconColor ?? Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
