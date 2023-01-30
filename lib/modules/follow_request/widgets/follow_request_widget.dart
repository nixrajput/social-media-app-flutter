import 'package:flutter/material.dart';
import 'package:social_media_app/apis/models/entities/follow_request.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class FollowRequestWidget extends StatelessWidget {
  const FollowRequestWidget({
    Key? key,
    required this.followRequest,
    this.bottomMargin,
    this.onTap,
    this.bgColor,
    this.avatarSize,
    this.borderRadius,
    this.padding,
    required this.totalLength,
    required this.index,
  }) : super(key: key);

  final FollowRequest followRequest;
  final int totalLength;
  final int index;
  final double? bottomMargin;
  final VoidCallback? onTap;
  final double? avatarSize;
  final EdgeInsets? padding;
  final Color? bgColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find;
    return GestureDetector(
      onTap: onTap ??
          () => RouteManagement.goToUserProfileView(followRequest.from.id),
      child: Container(
        margin: Dimens.edgeInsets6_0,
        padding: padding ?? Dimens.edgeInsets8,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimens.four),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: Dimens.pointEight,
          ),
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
                    tag: followRequest.from.id,
                    child: AvatarWidget(
                      avatar: followRequest.from.avatar,
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
            if (followRequest.from.id != profile.profileDetails!.user!.id)
              _buildFollowAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserUsername(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: followRequest.from.uname.toLowerCase(),
                style: AppStyles.style14Bold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (followRequest.from.isVerified) Dimens.boxWidth4,
          if (followRequest.from.isVerified)
            Icon(
              Icons.verified,
              color: ColorValues.primaryColor,
              size: Dimens.twenty,
            )
        ],
      );

  Widget _buildUserFullName(BuildContext context) => RichText(
        text: TextSpan(
          text: '${followRequest.from.fname} ${followRequest.from.lname}',
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
            Dimens.boxWidth16,
            NxIconButton(
              bgColor: Theme.of(context).cardColor,
              borderRadius: Dimens.four,
              padding: Dimens.edgeInsets4,
              width: Dimens.fourtyEight,
              icon: Icons.check,
              iconColor: ColorValues.successColor,
              onTap: () => FollowRequestController.find
                  .acceptFollowRequest(followRequest.id),
            ),
            Dimens.boxWidth8,
            NxIconButton(
              bgColor: Theme.of(context).cardColor,
              borderRadius: Dimens.four,
              padding: Dimens.edgeInsets4,
              width: Dimens.fourtyEight,
              icon: Icons.close,
              iconColor: ColorValues.errorColor,
              onTap: () => FollowRequestController.find
                  .removeFollowRequest(followRequest.id),
            ),
          ],
        ),
      );
}
