import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxListTile extends StatelessWidget {
  const NxListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.padding,
    this.bgColor,
    this.onTap,
    this.onLongPressed,
    this.trailing,
    this.borderRadius,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsets? padding;
  final Color? bgColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPressed;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPressed,
      child: Container(
        padding: padding ?? Dimens.edgeInsets12_0,
        width: Dimens.screenWidth,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(Dimens.zero),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null) leading!,
                  if (title != null || subtitle != null) Dimens.boxWidth16,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null) title!,
                        if (subtitle != null) Dimens.boxHeight2,
                        if (subtitle != null) subtitle!
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
