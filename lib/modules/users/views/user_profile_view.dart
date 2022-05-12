import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/count_widget.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/modules/users/controllers/user_profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _profile = ProfileController.find;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const NxAppBar(
                title: StringValues.profile,
              ),
              _buildBody(_profile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ProfileController profile) {
    return Expanded(
      child: GetBuilder<UserProfileController>(
        builder: (logic) {
          if (logic.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (logic.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NxAssetImage(
                    imgAsset: AssetValues.error,
                    width: Dimens.hundred * 2,
                    height: Dimens.hundred * 2,
                  ),
                  Dimens.boxHeight8,
                  Text(
                    logic.error!,
                    style: AppStyles.style14Bold,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxElevatedCard(
                  child: Padding(
                    padding: Dimens.edgeInsets8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            _buildProfileImage(logic),
                            Dimens.boxWidth20,
                            _buildHeaderButton(logic, profile),
                          ],
                        ),
                        Dimens.boxHeight16,
                        _buildUserDetails(logic),
                      ],
                    ),
                  ),
                ),
                Dimens.boxHeight8,
                Padding(
                  padding: Dimens.edgeInsets0_8,
                  child: Text(
                    StringValues.posts,
                    style: AppStyles.style20Bold,
                  ),
                ),
                Dimens.boxHeight8,
                _buildUserPosts(logic, profile),
                Dimens.boxHeight16,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileImage(UserProfileController logic) {
    if (logic.userProfile.user != null &&
        logic.userProfile.user?.avatar != null &&
        logic.userProfile.user?.avatar?.url != null) {
      return NxCircleNetworkImage(
        imageUrl: logic.userProfile.user!.avatar!.url!,
        radius: Dimens.sixtyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.sixtyFour,
    );
  }

  _buildHeaderButton(UserProfileController logic, ProfileController _profile) {
    if (logic.userProfile.user!.id == _profile.profileData.user!.id) {
      return NxOutlinedButton(
        label: StringValues.editProfile,
        onTap: RouteManagement.goToEditProfileView,
        padding: Dimens.edgeInsets0_8,
      );
    }
    return GetBuilder<ProfileController>(
      builder: (profile) => NxOutlinedButton(
        label: profile.profileData.user!.following
                .contains(logic.userProfile.user!.id)
            ? StringValues.following
            : StringValues.follow,
        bgColor: profile.profileData.user!.following
                .contains(logic.userProfile.user!.id)
            ? Colors.transparent
            : Theme.of(Get.context!).textTheme.bodyText1!.color,
        labelColor: profile.profileData.user!.following
                .contains(logic.userProfile.user!.id)
            ? Theme.of(Get.context!).textTheme.bodyText1!.color
            : Theme.of(Get.context!).scaffoldBackgroundColor,
        borderStyle: profile.profileData.user!.following
                .contains(logic.userProfile.user!.id)
            ? BorderStyle.solid
            : BorderStyle.none,
        borderWidth: profile.profileData.user!.following
                .contains(logic.userProfile.user!.id)
            ? Dimens.one
            : Dimens.zero,
        onTap: () => profile.followUnfollowUser(logic.userProfile.user!.id),
        padding: Dimens.edgeInsets0_8,
      ),
    );
  }

  Widget _buildUserDetails(UserProfileController logic) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '${logic.userProfile.user!.fname} ${logic.userProfile.user!.lname}',
                style: AppStyles.style18Bold,
              ),
              if (logic.userProfile.user!.isVerified) Dimens.boxWidth4,
              if (logic.userProfile.user!.isVerified)
                Icon(
                  CupertinoIcons.checkmark_seal,
                  color: ColorValues.primaryColor,
                  size: Dimens.sixTeen,
                )
            ],
          ),
          Text(
            "@${logic.userProfile.user!.uname}",
            style: TextStyle(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          if (logic.userProfile.user!.about != null) Dimens.boxHeight8,
          if (logic.userProfile.user!.about != null)
            Text(
              logic.userProfile.user!.about!,
              style: AppStyles.style14Normal,
            ),
          Dimens.boxHeight8,
          Text(
            'Joined ${DateFormat.yMMMd().format(logic.userProfile.user!.createdAt)}',
            style: const TextStyle(color: ColorValues.grayColor),
          ),
          Dimens.boxHeight16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NxCountWidget(
                title: StringValues.followers,
                value: logic.userProfile.user!.followers.length.toString(),
                //onTap: RouteManagement.goToFollowersListView,
              ),
              NxCountWidget(
                title: StringValues.following,
                value: logic.userProfile.user!.following.length.toString(),
                //onTap: RouteManagement.goToFollowingListView,
              ),
            ],
          ),
        ],
      );

  _buildUserPosts(UserProfileController logic, ProfileController _profile) {
    if (logic.userProfile.user?.id == _profile.profileData.user!.id) {
      if (logic.userProfile.user!.posts.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: 16.h,
              left: 16.0.w,
              right: 16.0.w,
            ),
            child: Text(
              StringValues.noPosts,
              style: AppStyles.style20Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      return Column(
        children: logic.userProfile.user!.posts
            .map((item) => PostWidget(post: item))
            .toList(),
      );
    }

    if (logic.userProfile.user!.accountType == StringValues.private) {
      if (_profile.profileData.user!.following
          .contains(logic.userProfile.user!.id)) {
        if (logic.userProfile.user!.posts.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                left: 16.0.w,
                right: 16.0.w,
              ),
              child: Text(
                StringValues.noPosts,
                style: AppStyles.style20Normal.copyWith(
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return Column(
          children: logic.userProfile.user!.posts
              .map((item) => PostWidget(post: item))
              .toList(),
        );
      }

      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Text(
            StringValues.privateAccountWarning,
            style: AppStyles.style20Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (logic.userProfile.user!.posts.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 16.0.w,
            right: 16.0.w,
          ),
          child: Text(
            StringValues.noPosts,
            style: AppStyles.style20Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      children: logic.userProfile.user!.posts
          .map((item) => PostWidget(post: item))
          .toList(),
    );
  }
}
