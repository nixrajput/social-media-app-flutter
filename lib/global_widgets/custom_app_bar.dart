import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/routes/route_management.dart';

class NxAppBar extends StatelessWidget {
  const NxAppBar({
    Key? key,
    this.title,
    this.showDivider = false,
    this.leading,
    this.showBackBtn = true,
    this.padding,
    this.titleStyle,
    this.bgColor,
    this.backBtnColor,
  }) : super(key: key);

  final String? title;
  final TextStyle? titleStyle;
  final bool? showDivider;
  final Widget? leading;
  final Color? backBtnColor;
  final bool? showBackBtn;
  final EdgeInsets? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.screenWidth,
      color: bgColor ?? Colors.transparent,
      child: Padding(
        padding: padding ?? Dimens.edgeInsets8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBackBtn == true)
              GestureDetector(
                onTap: RouteManagement.goToBack,
                child: Icon(
                  CupertinoIcons.arrow_left,
                  color: backBtnColor ??
                      Theme.of(context).textTheme.bodyText1!.color,
                  size: Dimens.twentyFour,
                ),
              ),
            if (showBackBtn == true) Dimens.boxWidth16,
            if (leading != null) leading!,
            if (leading != null && title != null) Dimens.boxWidth16,
            if (title != null && title!.isNotEmpty)
              Text(
                title!,
                style: titleStyle ??
                    AppStyles.style18Bold.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      height: 1.0,
                    ),
              )
          ],
        ),
      ),
    );
  }
}
