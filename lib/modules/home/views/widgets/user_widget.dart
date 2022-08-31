import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    Key? key,
    required this.user,
    this.bottomMargin,
    this.onTap,
    this.bgColor,
    this.avatarSize,
  }) : super(key: key);

  final User user;
  final double? bottomMargin;
  final Color? bgColor;
  final VoidCallback? onTap;
  final double? avatarSize;

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find;

    return InkWell(
      onTap: onTap ?? () => RouteManagement.goToUserProfileView(user.id),
      child: Container(
        width: Dimens.screenWidth,
        margin: EdgeInsets.only(bottom: bottomMargin ?? Dimens.eight),
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: user.id,
                  child: AvatarWidget(
                    avatar: user.avatar,
                    size: avatarSize ?? Dimens.twentyFour,
                  ),
                ),
                Dimens.boxWidth12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildUserUsername(),
                    _buildUserFullName(),
                  ],
                ),
              ],
            ),
            if (user.id != profile.profileData.user!.id)
              _buildFollowAction(profile),
          ],
        ),
      ),
    );
  }

  Widget _buildUserUsername() => SizedBox(
        width: Dimens.screenWidth * 0.45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                  text: user.uname.toLowerCase(),
                  style: AppStyles.style14Bold.copyWith(
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                ),
                maxLines: 1,
              ),
            ),
            if (user.isVerified) Dimens.boxWidth4,
            if (user.isVerified)
              Icon(
                CupertinoIcons.checkmark_seal_fill,
                color: Theme.of(Get.context!).brightness == Brightness.dark
                    ? Theme.of(Get.context!).textTheme.bodyText1?.color
                    : ColorValues.primaryColor,
                size: Dimens.sixTeen,
              )
          ],
        ),
      );

  Widget _buildUserFullName() => SizedBox(
        width: Dimens.screenWidth * 0.45,
        child: RichText(
          text: TextSpan(
            text: '${user.fname} ${user.lname}',
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );

  Widget _buildFollowAction(ProfileController profile) =>
      GetBuilder<ProfileController>(
        builder: (logic) => NxOutlinedButton(
          label: profile.profileData.user!.following.contains(user.id)
              ? StringValues.following
              : StringValues.follow,
          bgColor: profile.profileData.user!.following.contains(user.id)
              ? Colors.transparent
              : ColorValues.primaryColor,
          borderColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
          borderStyle: profile.profileData.user!.following.contains(user.id)
              ? BorderStyle.solid
              : BorderStyle.none,
          onTap: () => logic.followUnfollowUser(user.id),
          padding: Dimens.edgeInsets0_8,
          borderWidth: Dimens.one,
          width: Dimens.hundred,
          height: Dimens.thirtyTwo,
          borderRadius: Dimens.eight,
          labelStyle: AppStyles.style14Normal.copyWith(
            color: profile.profileData.user!.following.contains(user.id)
                ? Theme.of(Get.context!).textTheme.bodyText1!.color
                : ColorValues.whiteColor,
          ),
        ),
      );
}
