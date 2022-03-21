import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/routes/route_management.dart';

class NxAppBar extends StatelessWidget {
  const NxAppBar({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.screenWidth,
      child: Column(
        children: [
          Padding(
            padding: Dimens.edgeInsets8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => RouteManagement.goToBack(),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).dividerColor,
                    radius: Dimens.sixTeen,
                    child: const Icon(
                      CupertinoIcons.left_chevron,
                      color: ColorValues.whiteColor,
                    ),
                  ),
                ),
                Dimens.boxWidth16,
                Text(
                  title!,
                  style: AppStyles.style20Bold,
                )
              ],
            ),
          ),
          Divider(
            height: Dimens.zero,
            thickness: 0.3,
          ),
        ],
      ),
    );
  }
}
