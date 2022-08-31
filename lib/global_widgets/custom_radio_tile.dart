import 'package:flutter/material.dart';
import 'package:social_media_app/constants/styles.dart';

class NxRadioTile extends StatelessWidget {
  const NxRadioTile(
      {Key? key,
      required this.onChanged,
      this.value,
      this.groupValue,
      required this.title,
      this.margin,
      this.padding,
      this.titleStyle,
      this.activeColor,
      this.onTap,
      this.bgColor,
      this.borderRadius})
      : super(key: key);

  final Function(dynamic) onChanged;
  final dynamic value;
  final dynamic groupValue;
  final String title;
  final TextStyle? titleStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? activeColor;
  final Function()? onTap;
  final Color? bgColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.zero),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: titleStyle ?? AppStyles.style14Bold,
              ),
            ),
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor:
                  activeColor ?? Theme.of(context).textTheme.bodyText1!.color,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
