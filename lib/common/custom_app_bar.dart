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
  }) : super(key: key);

  final String? title;
  final bool? showDivider;

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
            padding: Dimens.edgeInsets8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: RouteManagement.goToBack,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).dividerColor,
                    radius: Dimens.fourteen,
                    child: Icon(
                      CupertinoIcons.left_chevron,
                      color: ColorValues.whiteColor,
                      size: Dimens.twenty,
                    ),
                  ),
                ),
                Dimens.boxWidth16,
                Text(
                  title!,
                  style: AppStyles.style18Bold,
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
