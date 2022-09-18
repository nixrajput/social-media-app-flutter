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
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    Key? key,
    required this.user,
    this.bottomMargin,
    this.onTap,
    this.bgColor,
    this.avatarSize,
    this.borderRadius,
    this.padding,
    required this.totalLength,
    required this.index,
    this.extraActions,
  }) : super(key: key);

  final User user;
  final int totalLength;
  final int index;
  final double? bottomMargin;
  final VoidCallback? onTap;
  final double? avatarSize;
  final EdgeInsets? padding;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final Widget? extraActions;

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find;
    return InkWell(
      onTap: onTap ?? () => RouteManagement.goToUserProfileView(user.id),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottomMargin ?? Dimens.zero),
            padding: padding ?? Dimens.edgeInsets8,
            constraints: BoxConstraints(
              maxWidth: Dimens.screenWidth,
            ),
            decoration: BoxDecoration(
              color: bgColor ?? Theme.of(Get.context!).dialogBackgroundColor,
              borderRadius: (index == 0 || index == totalLength - 1)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      topRight: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      bottomLeft: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                      bottomRight: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                    )
                  : const BorderRadius.all(Radius.zero),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AvatarWidget(
                        avatar: user.avatar,
                        size: avatarSize ?? Dimens.twentyFour,
                      ),
                      Dimens.boxWidth8,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildUserUsername(),
                            _buildUserFullName(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (user.id != profile.profileDetails!.user!.id)
                  _buildFollowAction(),
              ],
            ),
          ),
          if (index != totalLength - 1) Dimens.divider,
        ],
      ),
    );
  }

  Widget _buildUserUsername() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: user.uname,
                style: AppStyles.style13Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
              ),
              overflow: TextOverflow.ellipsis,
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
              size: Dimens.fourteen,
            )
        ],
      );

  Widget _buildUserFullName() => RichText(
        text: TextSpan(
          text: '${user.fname} ${user.lname}',
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(Get.context!).textTheme.subtitle1!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildFollowAction() => Expanded(
        flex: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.boxWidth16,
            GetBuilder<ProfileController>(
              builder: (logic) => NxOutlinedButton(
                label: getFollowStatus(user.followingStatus),
                bgColor: getButtonColor(user.followingStatus),
                borderColor: ColorValues.primaryColor,
                borderStyle: getBorderStyle(user.followingStatus),
                onTap: () {
                  if (user.followingStatus == "requested") {
                    logic.cancelFollowRequest(user);
                    return;
                  }
                  logic.followUnfollowUser(user);
                },
                padding: Dimens.edgeInsets6_12,
                borderWidth: Dimens.one,
                borderRadius: Dimens.eight,
                labelStyle: AppStyles.style13Normal.copyWith(
                  color: getLabelColor(user.followingStatus),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (extraActions != null) extraActions!
          ],
        ),
      );

  String getFollowStatus(String status) {
    if (status == "following") {
      return StringValues.following;
    }

    if (status == "requested") {
      return StringValues.requested;
    }

    return StringValues.follow;
  }

  Color getButtonColor(String status) {
    if (status == "following" || status == "requested") {
      return Colors.transparent;
    }

    return ColorValues.primaryColor;
  }

  BorderStyle getBorderStyle(String status) {
    if (status == "following" || status == "requested") {
      return BorderStyle.solid;
    }

    return BorderStyle.none;
  }

  Color getLabelColor(String status) {
    if (status == "following" || status == "requested") {
      return ColorValues.primaryColor;
    }

    return ColorValues.whiteColor;
  }
}
