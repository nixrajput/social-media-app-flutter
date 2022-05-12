import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';

class FollowerWidget extends StatelessWidget {
  const FollowerWidget({
    Key? key,
    required this.user,
    this.bottomMargin,
  }) : super(key: key);

  final User user;
  final double? bottomMargin;

  @override
  Widget build(BuildContext context) {
    final _profile = ProfileController.find;
    return Container(
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
                      child: Text(
                        '${user.fname} ${user.lname}',
                        style: AppStyles.style16Normal,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
          GetBuilder<ProfileController>(
            builder: (logic) => NxOutlinedButton(
              label: _profile.profileData.user!.following.contains(user.id)
                  ? StringValues.following
                  : StringValues.follow,
              bgColor: _profile.profileData.user!.following.contains(user.id)
                  ? Colors.transparent
                  : Theme.of(context).textTheme.bodyText1!.color,
              labelColor: _profile.profileData.user!.following.contains(user.id)
                  ? Theme.of(context).textTheme.bodyText1!.color
                  : Theme.of(context).scaffoldBackgroundColor,
              borderStyle:
                  _profile.profileData.user!.following.contains(user.id)
                      ? BorderStyle.solid
                      : BorderStyle.none,
              borderWidth:
                  _profile.profileData.user!.following.contains(user.id)
                      ? Dimens.one
                      : Dimens.zero,
              onTap: () => logic.followUnfollowUser(user.id),
              padding: Dimens.edgeInsets0_8,
              borderRadius: Dimens.twenty,
            ),
          ),
        ],
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
