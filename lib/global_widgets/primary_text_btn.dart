import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';

class NxTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? labelStyle;
  final bool? enabled;

  const NxTextButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.padding,
    this.margin,
    this.labelStyle,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled == true ? onTap : () {},
      child: Container(
        padding: padding ?? Dimens.edgeInsets0,
        margin: margin ?? Dimens.edgeInsets0,
        child: Text(
          label,
          style: labelStyle ??
              AppStyles.style16Bold.copyWith(
                color: enabled == true
                    ? ColorValues.linkColor
                    : Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withAlpha(50),
              ),
        ),
      ),
    );
  }
}
