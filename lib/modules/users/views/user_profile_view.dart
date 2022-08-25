import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/count_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_shape_painter.dart';
import 'package:social_media_app/global_widgets/post_thumb_widget.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/shimmer_loading.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/modules/users/controllers/user_profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: GetBuilder<UserProfileController>(builder: (logic) {
            return RefreshIndicator(
              onRefresh: logic.getUserProfileDetails,
              child: _buildWidget(logic),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildWidget(UserProfileController logic) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(Dimens.screenWidth, Dimens.screenHeight),
            painter: CustomShapePainter(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileHeader(logic),
              logic.isLoading
                  ? _buildLoadingWidget()
                  : logic.userProfile.user == null
                      ? _buildErrorBody(logic)
                      : _buildProfileBody(logic),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(UserProfileController logic) {
    final user = logic.userProfile.user;
    return NxAppBar(
      padding: Dimens.edgeInsets8_16,
      leading: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              logic.userProfile.user != null
                  ? user!.uname
                  : StringValues.profile,
              style: AppStyles.style20Bold,
            ),
            const Spacer(),
            GestureDetector(
              child: Icon(
                Icons.more_horiz,
                size: Dimens.twentyFour,
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBody(UserProfileController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Dimens.boxHeight24,
        Padding(
          padding: Dimens.edgeInsets0_16,
          child: _buildUserDetails(logic),
        ),
        Dimens.boxHeight24,
        Padding(
          padding: Dimens.edgeInsets0_16,
          child: _buildCountDetails(logic),
        ),
        Dimens.boxHeight8,
        Dimens.dividerWithHeight,
        Dimens.boxHeight8,
        _buildPosts(logic),
        Dimens.boxHeight16,
      ],
    );
  }

  Widget _buildUserDetails(UserProfileController logic) {
    final user = logic.userProfile.user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Hero(
              tag: user!.id,
              child: AvatarWidget(avatar: user.avatar),
            ),
            Dimens.boxHeight16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.fname} ${user.lname}',
                  style: AppStyles.style18Bold,
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
            Dimens.boxHeight4,
            Text(
              "@${user.uname}",
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ],
        ),
        Dimens.boxHeight8,
        if (user.about != null) Dimens.boxHeight8,
        if (user.about != null)
          Text(
            user.about!,
            style: AppStyles.style14Normal,
          ),
        Dimens.boxHeight8,
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
                'Joined - ${DateFormat.yMMMd().format(user.createdAt)}',
                style: const TextStyle(color: ColorValues.grayColor),
              ),
            ),
          ],
        ),
        Dimens.boxHeight24,
        _buildActionBtn(logic),
      ],
    );
  }

  Widget _buildActionBtn(UserProfileController logic) {
    return GetBuilder<ProfileController>(
      builder: (profile) {
        if (logic.userProfile.user!.id == profile.profileData.user!.id) {
          return NxOutlinedButton(
            label: StringValues.editProfile.toTitleCase(),
            width: Dimens.screenWidth,
            height: Dimens.thirtySix,
            padding: Dimens.edgeInsets0_8,
            borderRadius: Dimens.eight,
            borderColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
            labelStyle: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onTap: RouteManagement.goToEditProfileView,
          );
        }
        return NxOutlinedButton(
          label: profile.profileData.user!.following
                  .contains(logic.userProfile.user!.id)
              ? StringValues.following
              : StringValues.follow,
          bgColor: profile.profileData.user!.following
                  .contains(logic.userProfile.user!.id)
              ? Colors.transparent
              : ColorValues.primaryColor,
          borderColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
          borderStyle: profile.profileData.user!.following
                  .contains(logic.userProfile.user!.id)
              ? BorderStyle.solid
              : BorderStyle.none,
          onTap: () => profile.followUnfollowUser(logic.userProfile.user!.id),
          padding: Dimens.edgeInsets0_8,
          width: Dimens.screenWidth,
          height: Dimens.thirtySix,
          labelStyle: AppStyles.style14Normal.copyWith(
            color: profile.profileData.user!.following
                    .contains(logic.userProfile.user!.id)
                ? Theme.of(Get.context!).textTheme.bodyText1!.color
                : ColorValues.whiteColor,
          ),
        );
      },
    );
  }

  Container _buildCountDetails(UserProfileController logic) {
    final user = logic.userProfile.user;
    final profile = ProfileController.find;
    return Container(
      width: Dimens.screenWidth,
      padding: Dimens.edgeInsets8_0,
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).dialogTheme.backgroundColor!,
        borderRadius: BorderRadius.circular(Dimens.eight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: NxCountWidget(
              title: StringValues.posts,
              valueStyle: AppStyles.style24Bold,
              value: user!.posts.length.toString().toCountingFormat(),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.followers,
              valueStyle: AppStyles.style24Bold,
              value: user.followers.length.toString().toCountingFormat(),
              onTap: () {
                if (logic.userProfile.user!.accountType ==
                        StringValues.private &&
                    !profile.profileData.user!.following
                        .contains(logic.userProfile.user!.id) &&
                    logic.userProfile.user!.id !=
                        profile.profileData.user!.id) {
                  return;
                }
                RouteManagement.goToFollowersListView(
                    logic.userProfile.user!.id);
              },
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.following,
              valueStyle: AppStyles.style24Bold,
              value: user.following.length.toString().toCountingFormat(),
              onTap: () {
                if (logic.userProfile.user!.accountType ==
                        StringValues.private &&
                    !profile.profileData.user!.following
                        .contains(logic.userProfile.user!.id) &&
                    logic.userProfile.user!.id !=
                        profile.profileData.user!.id) {
                  return;
                }
                RouteManagement.goToFollowingListView(
                    logic.userProfile.user!.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPosts(UserProfileController logic) {
    final user = logic.userProfile.user;
    final profile = ProfileController.find;

    if (logic.userProfile.user!.accountType == StringValues.private &&
        !profile.profileData.user!.following
            .contains(logic.userProfile.user!.id) &&
        logic.userProfile.user!.id != profile.profileData.user!.id) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 16.0.w,
            right: 16.0.w,
          ),
          child: Text(
            StringValues.privateAccountWarning,
            style: AppStyles.style32Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (user!.posts.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 16.0.w,
            right: 16.0.w,
          ),
          child: Text(
            StringValues.noPosts,
            style: AppStyles.style32Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: Dimens.edgeInsets0_16,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: user.posts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Dimens.eight,
          mainAxisSpacing: Dimens.eight,
        ),
        itemBuilder: (ctx, i) {
          var post = user.posts[i];

          return PostThumbnailWidget(mediaFile: post.mediaFiles!.first);
        },
      ),
    );
  }

  _buildErrorBody(UserProfileController logic) {
    return SizedBox(
      width: Dimens.screenWidth,
      height: Dimens.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringValues.userNotFoundError,
            style: AppStyles.style32Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            textAlign: TextAlign.center,
          ),
          Dimens.boxHeight16,
          NxOutlinedButton(
            width: Dimens.hundred,
            height: Dimens.thirtySix,
            label: StringValues.refresh,
            onTap: logic.getUserProfileDetails,
          )
        ],
      ),
    );
  }

  _buildLoadingWidget() {
    return Padding(
      padding: Dimens.edgeInsets0_16,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: Dimens.eighty,
              backgroundColor: ColorValues.grayColor.withOpacity(0.25),
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
              width: Dimens.hundred,
              height: Dimens.fourty,
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
          ],
        ),
      ),
    );
  }
}
