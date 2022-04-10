import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    Key? key,
    required this.user,
    this.bottomMargin,
    this.onTap,
  }) : super(key: key);

  final User user;
  final double? bottomMargin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: bottomMargin ?? Dimens.eight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProfileImage(user),
                  Dimens.boxWidth8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: Dimens.screenWidth * 0.5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${user.fname} ${user.lname}',
                              style: AppStyles.style16Normal,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            if (user.isVerified) Dimens.boxWidth4,
                            if (user.isVerified)
                              Icon(
                                CupertinoIcons.checkmark_seal,
                                color: ColorValues.primaryColor,
                                size: Dimens.sixTeen,
                              )
                          ],
                        ),
                      ),
                      Text(
                        user.uname,
                        style: TextStyle(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Dimens.boxWidth8,
            GetBuilder<AuthController>(
              builder: (auth) => NxOutlinedButton(
                label: auth.profileData.user!.following.contains(user.id)
                    ? StringValues.following
                    : StringValues.follow,
                bgColor: auth.profileData.user!.following.contains(user.id)
                    ? Colors.transparent
                    : Theme.of(context).textTheme.bodyText1!.color,
                labelColor: auth.profileData.user!.following.contains(user.id)
                    ? Theme.of(context).textTheme.bodyText1!.color
                    : Theme.of(context).scaffoldBackgroundColor,
                borderStyle: auth.profileData.user!.following.contains(user.id)
                    ? BorderStyle.solid
                    : BorderStyle.none,
                borderWidth: auth.profileData.user!.following.contains(user.id)
                    ? Dimens.one
                    : Dimens.zero,
                onTap: () => auth.followUnfollowUser(user.id),
                padding: Dimens.edgeInsets0_8,
                borderRadius: Dimens.twenty,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(User? user) {
    if (user != null && user.avatar != null && user.avatar?.url != null) {
      return NxCircleNetworkImage(
        imageUrl: user.avatar!.url!,
        radius: Dimens.twentyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.twentyFour,
    );
  }
}
