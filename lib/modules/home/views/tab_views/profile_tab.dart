import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/asset_image.dart';
import 'package:social_media_app/global_widgets/circular_asset_image.dart';
import 'package:social_media_app/global_widgets/circular_network_image.dart';
import 'package:social_media_app/global_widgets/count_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_shape_painter.dart';
import 'package:social_media_app/global_widgets/elevated_card.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/shimmer_loading.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/views/widgets/post_thumb_widget.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';
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
            child: _buildWidget(logic),
          );
        }),
      ),
    );
  }

  Widget _buildWidget(ProfileController logic) {
    if (logic.isLoading) {
      return Expanded(
        child: Column(
          children: [
            _buildProfileHeader(logic),
            _buildLoadingWidget(),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(Dimens.screenWidth, Dimens.screenHeight),
            painter: CustomShapePainter(),
          ),
          Column(
            children: [
              _buildProfileHeader(logic),
              logic.profileData.user == null
                  ? _buildErrorBody(logic)
                  : _buildProfileBody(logic),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ProfileController logic) {
    return NxAppBar(
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
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ],
        ),
      ),
      showBackBtn: false,
    );
  }

  Widget _buildProfileBody(ProfileController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: Dimens.edgeInsets8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _showProfilePictureDialog(logic),
                    child: _buildProfileImage(logic),
                  ),
                  Dimens.boxHeight16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${logic.profileData.user!.fname} ${logic.profileData.user!.lname}',
                        style: AppStyles.style18Bold,
                      ),
                      if (logic.profileData.user!.isVerified) Dimens.boxWidth4,
                      if (logic.profileData.user!.isVerified)
                        Icon(
                          CupertinoIcons.checkmark_seal_fill,
                          color: Theme.of(Get.context!).brightness ==
                                  Brightness.dark
                              ? Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1
                                  ?.color
                              : ColorValues.primaryColor,
                          size: Dimens.sixTeen,
                        )
                    ],
                  ),
                  Dimens.boxHeight4,
                  Text(
                    "@${logic.profileData.user!.uname}",
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                  ),
                  Dimens.boxHeight12,
                  NxOutlinedButton(
                    label: StringValues.editProfile.toTitleCase(),
                    padding: Dimens.edgeInsets0_8,
                    height: Dimens.thirtySix,
                    borderColor:
                        Theme.of(Get.context!).textTheme.bodyText1!.color,
                    labelStyle: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    onTap: RouteManagement.goToEditProfileView,
                  ),
                ],
              ),
              _buildUserDetails(logic),
            ],
          ),
        ),
        Dimens.dividerWithHeight,
        Dimens.boxHeight8,
        _buildPosts(logic),
        Dimens.boxHeight16,
      ],
    );
  }

  Widget _buildUserDetails(ProfileController logic) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (logic.profileData.user!.about != null) Dimens.boxHeight8,
          if (logic.profileData.user!.about != null)
            Text(
              logic.profileData.user!.about!,
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
                  'Joined - ${DateFormat.yMMMd().format(logic.profileData.user!.createdAt)}',
                  style: const TextStyle(color: ColorValues.grayColor),
                ),
              ),
            ],
          ),
          Dimens.boxHeight16,
          _buildCountDetails(logic),
        ],
      );

  Container _buildCountDetails(ProfileController logic) {
    return Container(
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
              value: logic.profileData.user!.posts.length
                  .toString()
                  .toCountingFormat(),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.followers,
              valueStyle: AppStyles.style24Bold,
              value: logic.profileData.user!.followers.length
                  .toString()
                  .toCountingFormat(),
              onTap: () => RouteManagement.goToFollowersListView(
                  logic.profileData.user!.id),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.following,
              valueStyle: AppStyles.style24Bold,
              value: logic.profileData.user!.following.length
                  .toString()
                  .toCountingFormat(),
              onTap: () => RouteManagement.goToFollowingListView(
                  logic.profileData.user!.id),
            ),
          ),
        ],
      ),
    );
  }

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

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: logic.profileData.user!.posts.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (ctx, i) {
        var post = logic.profileData.user!.posts[i];

        return PostThumbnailWidget(post: post);
      },
    );
  }

  void _showProfilePictureDialog(ProfileController logic) {
    AppUtils.showSimpleDialog(
      GetBuilder<EditProfilePictureController>(
        builder: (con) => Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Profile picture',
                    style: AppStyles.style20Bold,
                  ),
                  const Spacer(),
                  NxIconButton(
                    icon: Icons.close,
                    iconSize: Dimens.thirtyTwo,
                    onTap: AppUtils.closeDialog,
                  ),
                ],
              ),
              Dimens.boxHeight24,
              _buildProfileImage(
                logic,
                size: Dimens.screenWidth * 0.4,
              ),
              Dimens.boxHeight40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: NxOutlinedButton(
                      width: Dimens.screenWidth,
                      label: 'Change',
                      onTap: con.chooseImage,
                    ),
                  ),
                  Dimens.boxWidth16,
                  Expanded(
                    child: NxOutlinedButton(
                      width: Dimens.screenWidth,
                      label: 'Remove',
                      onTap: con.removeProfilePicture,
                    ),
                  ),
                ],
              ),
              Dimens.boxHeight24,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(ProfileController logic, {double? size}) {
    if (logic.profileData.user != null &&
        logic.profileData.user!.avatar != null) {
      return NxCircleNetworkImage(
        imageUrl: logic.profileData.user!.avatar!.url!,
        radius: size ?? Dimens.eighty,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: size ?? Dimens.eighty,
    );
  }

  _buildErrorBody(ProfileController logic) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NxAssetImage(
              imgAsset: AssetValues.error,
              width: Dimens.hundred * 1.8,
              height: Dimens.hundred * 1.8,
            ),
            Dimens.boxHeight8,
            Text(
              StringValues.userNotFoundError,
              style: AppStyles.style18Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
              textAlign: TextAlign.center,
            ),
            Dimens.boxHeight20,
            NxOutlinedButton(
              width: Dimens.hundred * 1.4,
              padding: Dimens.edgeInsets8,
              label: StringValues.refresh,
              onTap: logic.fetchProfileDetails,
            )
          ],
        ),
      ),
    );
  }

  _buildLoadingWidget() {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets8,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
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
                          backgroundColor:
                              ColorValues.grayColor.withOpacity(0.25),
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
          ),
        ),
      ),
    );
  }
}
