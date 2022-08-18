import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';

class NxCountWidget extends StatelessWidget {
  const NxCountWidget({
    Key? key,
    required this.title,
    required this.value,
    this.bgColor,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.titleStyle,
    this.valueStyle,
  }) : super(key: key);

  final String title;
  final TextStyle? titleStyle;
  final String value;
  final TextStyle? valueStyle;
  final Color? bgColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? Dimens.edgeInsets4,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.four),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: valueStyle ?? AppStyles.style16Bold,
            ),
            Dimens.boxHeight8,
            Text(
              title,
              style: titleStyle ??
                  AppStyles.style14Normal.copyWith(
                    color: ColorValues.grayColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
