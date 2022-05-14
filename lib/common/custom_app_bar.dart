import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
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
  }) : super(key: key);

  final String? title;
  final bool? showDivider;
  final Widget? leading;
  final bool? showBackBtn;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: padding ?? Dimens.edgeInsets8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showBackBtn == true)
                  InkWell(
                    onTap: RouteManagement.goToBack,
                    child: CircleAvatar(
                      backgroundColor:
                          ColorValues.primaryColor.withOpacity(0.8),
                      radius: Dimens.fourteen,
                      child: Icon(
                        CupertinoIcons.left_chevron,
                        color: ColorValues.whiteColor,
                        size: Dimens.sixTeen,
                      ),
                    ),
                  ),
                if (showBackBtn == true) Dimens.boxWidth16,
                if (leading != null) leading!,
                if (leading != null) Dimens.boxWidth16,
                if (title != null && title!.isNotEmpty)
                  Text(
                    title!,
                    style: AppStyles.style20Bold,
                  )
              ],
            ),
          ),
          if (showDivider == true) Dimens.divider,
        ],
      ),
    );
  }
}
