import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/count_widget.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/common/shimmer_loading.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: GetBuilder<ProfileController>(builder: (logic) {
          return RefreshIndicator(
            onRefresh: logic.fetchProfileDetails,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NxAppBar(
                  padding: Dimens.edgeInsetsOnlyTop8.copyWith(
                    left: Dimens.eight,
                    bottom: Dimens.eight,
                  ),
                  leading: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          logic.profileData.user != null
                              ? logic.profileData.user!.uname
                              : StringValues.profile,
                          style: AppStyles.style20Bold,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: RouteManagement.goToSettingsView,
                          child: Icon(
                            CupertinoIcons.gear_alt_fill,
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  showBackBtn: false,
                ),
                _buildProfileBody(logic),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProfileBody(ProfileController logic) {
    if (logic.isLoading) {
      return Expanded(
        child: Padding(
          padding: Dimens.edgeInsets8,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: _buildLoadingWidget(),
          ),
        ),
      );
    }
    if (logic.profileData.user == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(CupertinoIcons.info),
            Dimens.boxHeight16,
            Text(
              StringValues.userNotFoundError,
              style: AppStyles.style14Bold,
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: Dimens.edgeInsets8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _buildProfileImage(logic),
                      Dimens.boxWidth16,
                      const NxOutlinedButton(
                        label: StringValues.editProfile,
                        onTap: RouteManagement.goToEditProfileView,
                      ),
                    ],
                  ),
                  Dimens.boxHeight16,
                  _buildUserDetails(logic),
                ],
              ),
            ),
            Dimens.dividerWithHeight,
            Padding(
              padding: Dimens.edgeInsets0_8,
              child: Text(
                "${StringValues.posts} (${logic.profileData.user!.posts.length})",
                style: AppStyles.style16Bold,
              ),
            ),
            Dimens.boxHeight8,
            _buildPosts(logic),
            Dimens.boxHeight16,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(ProfileController logic) {
    if (logic.profileData.user != null &&
        logic.profileData.user!.avatar != null) {
      return NxCircleNetworkImage(
        imageUrl: logic.profileData.user!.avatar!.url!,
        radius: Dimens.sixtyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.sixtyFour,
    );
  }

  Widget _buildUserDetails(ProfileController logic) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '${logic.profileData.user!.fname} ${logic.profileData.user!.lname}',
                style: AppStyles.style18Bold,
              ),
              if (logic.profileData.user!.isVerified) Dimens.boxWidth4,
              if (logic.profileData.user!.isVerified)
                Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  color: Theme.of(Get.context!).brightness == Brightness.dark
                      ? Theme.of(Get.context!).textTheme.bodyText1?.color
                      : ColorValues.primaryColor,
                  size: Dimens.sixTeen,
                )
            ],
          ),
          Text(
            "@${logic.profileData.user!.uname}",
            style: TextStyle(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          if (logic.profileData.user!.about != null) Dimens.boxHeight16,
          if (logic.profileData.user!.about != null)
            Text(
              logic.profileData.user!.about!,
              style: AppStyles.style14Normal,
            ),
          Dimens.boxHeight16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: Dimens.fourteen,
                color: ColorValues.grayColor,
              ),
              Dimens.boxWidth4,
              Expanded(
                child: Text(
                  'Joined - ${DateFormat.yMMMd().format(logic.profileData.user!.createdAt)}',
                  style: const TextStyle(color: ColorValues.grayColor),
                ),
              ),
            ],
          ),
          Dimens.boxHeight16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: NxCountWidget(
                  title: StringValues.followers,
                  value: logic.profileData.user!.followers.length.toString(),
                  onTap: () => RouteManagement.goToFollowersListView(
                      logic.profileData.user!.id),
                ),
              ),
              Expanded(
                child: NxCountWidget(
                  title: StringValues.following,
                  value: logic.profileData.user!.following.length.toString(),
                  onTap: () => RouteManagement.goToFollowingListView(
                      logic.profileData.user!.id),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildPosts(ProfileController logic) {
    if (logic.profileData.user!.posts.isEmpty) {
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
      children: logic.profileData.user!.posts
          .map((item) => PostWidget(post: item))
          .toList(),
    );
  }

  _buildLoadingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: Dimens.sixtyFour,
              backgroundColor: ColorValues.grayColor.withOpacity(0.25),
            ),
            Dimens.boxWidth16,
            ShimmerLoading(
              width: Dimens.hundred,
              height: Dimens.fourty,
            ),
          ],
        ),
        Dimens.boxHeight16,
        ShimmerLoading(
          width: Dimens.hundred * 1.2,
          height: Dimens.twentyFour,
        ),
        Dimens.boxHeight4,
        ShimmerLoading(
          width: Dimens.hundred * 1.2,
          height: Dimens.sixTeen,
        ),
        Dimens.boxHeight16,
        ShimmerLoading(
          width: Dimens.screenWidth * 0.75,
          height: Dimens.sixTeen,
        ),
        Dimens.boxHeight16,
        ShimmerLoading(
          width: Dimens.screenWidth * 0.75,
          height: Dimens.sixTeen,
        ),
        Dimens.boxHeight32,
        NxElevatedCard(
          bgColor: ColorValues.grayColor.withOpacity(0.1),
          padding: Dimens.edgeInsets8,
          margin: Dimens.edgeInsets8_0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: Dimens.twenty,
                    backgroundColor: ColorValues.grayColor.withOpacity(0.25),
                  ),
                  Dimens.boxWidth8,
                  Column(
                    children: [
                      ShimmerLoading(
                        width: Dimens.hundred,
                        height: Dimens.fourteen,
                      ),
                      Dimens.boxHeight4,
                      ShimmerLoading(
                        width: Dimens.hundred,
                        height: Dimens.ten,
                      ),
                    ],
                  ),
                ],
              ),
              Dimens.boxHeight8,
              ShimmerLoading(
                height: Dimens.screenWidth * 0.8,
              ),
              Dimens.boxHeight8,
              Row(
                children: [
                  ShimmerLoading(
                    width: Dimens.eighty,
                    height: Dimens.twenty,
                  ),
                  Dimens.boxWidth8,
                  ShimmerLoading(
                    width: Dimens.eighty,
                    height: Dimens.twenty,
                  ),
                ],
              ),
              Dimens.boxHeight8,
              ShimmerLoading(
                width: Dimens.screenWidth * 0.75,
                height: Dimens.sixTeen,
              ),
              Dimens.boxHeight8,
              ShimmerLoading(
                width: Dimens.screenWidth * 0.75,
                height: Dimens.sixTeen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
