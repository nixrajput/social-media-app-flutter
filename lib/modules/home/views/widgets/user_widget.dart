import 'package:flutter/material.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/app_filled_btn.dart';
import 'package:social_media_app/app_widgets/avatar_widget.dart';
import 'package:social_media_app/app_widgets/verified_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    Key? key,
    required this.user,
    required this.totalLength,
    required this.index,
    this.bottomMargin,
    this.onTap,
    this.bgColor,
    this.avatarSize,
    this.borderRadius,
    this.padding,
    this.extraActions,
    this.onActionTap,
  }) : super(key: key);

  final double? avatarSize;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final double? bottomMargin;
  final Widget? extraActions;
  final int index;
  final VoidCallback? onActionTap;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final int totalLength;
  final User user;

  String getFollowStatus(String status, BuildContext context) {
    if (status == "following") {
      return StringValues.following;
    }

    if (status == "requested") {
      return StringValues.requested;
    }

    return StringValues.follow;
  }

  Color getButtonColor(String status, BuildContext context) {
    if (status == "following" || status == "requested") {
      return Theme.of(context).dividerColor;
    }

    return ColorValues.primaryColor;
  }

  Color getLabelColor(String status, BuildContext context) {
    if (status == "following" || status == "requested") {
      return Theme.of(context).textTheme.bodyLarge!.color!;
    }

    return ColorValues.whiteColor;
  }

  Widget _buildUserUsername(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: user.uname.toLowerCase(),
                style: AppStyles.style14Bold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (user.isVerified) Dimens.boxWidth4,
          if (user.isVerified)
            VerifiedWidget(
              verifiedCategory: user.verifiedCategory!,
              size: Dimens.fourteen,
            ),
        ],
      );

  Widget _buildUserFullName(BuildContext context) => RichText(
        text: TextSpan(
          text: '${user.fname} ${user.lname}',
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildFollowAction(BuildContext context) => Expanded(
        flex: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.boxWidth12,
            NxFilledButton(
              label: getFollowStatus(user.followingStatus, context),
              bgColor: getButtonColor(user.followingStatus, context),
              onTap: onActionTap,
              padding: Dimens.edgeInsets6_8,
              borderRadius: Dimens.four,
              labelStyle: AppStyles.style12Normal.copyWith(
                color: getLabelColor(user.followingStatus, context),
              ),
            ),
            if (extraActions != null) extraActions!
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: Dimens.edgeInsets8_0,
        padding: padding ?? Dimens.edgeInsets8,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimens.four),
          boxShadow: AppStyles.defaultShadow,
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
                  Hero(
                    tag: user.id,
                    child: AvatarWidget(
                      avatar: user.avatar,
                      size: avatarSize ?? Dimens.twentyFour,
                    ),
                  ),
                  Dimens.boxWidth8,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildUserUsername(context),
                        _buildUserFullName(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (user.id != profile.profileDetails!.user!.id)
              _buildFollowAction(context),
          ],
        ),
      ),
    );
  }
}
