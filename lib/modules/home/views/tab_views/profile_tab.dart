import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/count_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_shape_painter.dart';
import 'package:social_media_app/global_widgets/post_thumb_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/shimmer_loading.dart';
import 'package:social_media_app/helpers/utils.dart';
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
                  : logic.profileDetails.user == null
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
      padding: Dimens.edgeInsets8_16,
      leading: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              logic.profileDetails.user != null
                  ? logic.profileDetails.user!.uname
                  : StringValues.profile,
              style: AppStyles.style20Bold,
            ),
            const Spacer(),
            GestureDetector(
              onTap: RouteManagement.goToSettingsView,
              child: Icon(
                Icons.menu,
                size: Dimens.twentyFour,
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
        Dimens.boxHeight16,
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

  Widget _buildUserDetails(ProfileController logic) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => _showProfilePictureDialog(logic),
                child: Hero(
                  tag: logic.profileDetails.user!.id,
                  child: AvatarWidget(
                    avatar: logic.profileDetails.user!.avatar,
                  ),
                ),
              ),
              Dimens.boxHeight16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${logic.profileDetails.user!.fname} ${logic.profileDetails.user!.lname}',
                    style: AppStyles.style18Bold,
                  ),
                  if (logic.profileDetails.user!.isVerified) Dimens.boxWidth4,
                  if (logic.profileDetails.user!.isVerified)
                    Icon(
                      CupertinoIcons.checkmark_seal_fill,
                      color: Theme.of(Get.context!).brightness ==
                              Brightness.dark
                          ? Theme.of(Get.context!).textTheme.bodyText1?.color
                          : ColorValues.primaryColor,
                      size: Dimens.sixTeen,
                    )
                ],
              ),
              Dimens.boxHeight4,
              Text(
                "@${logic.profileDetails.user!.uname}",
                style: AppStyles.style14Normal.copyWith(
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
              ),
            ],
          ),
          Dimens.boxHeight16,
          if (logic.profileDetails.user!.about != null)
            Text(
              logic.profileDetails.user!.about!,
              style: AppStyles.style14Normal,
            ),
          Dimens.boxHeight8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: Dimens.twelve,
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
              Dimens.boxWidth8,
              Expanded(
                child: Text(
                  'Joined - ${DateFormat.yMMMd().format(logic.profileDetails.user!.createdAt)}',
                  style: AppStyles.style12Bold.copyWith(
                    color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                  ),
                ),
              ),
            ],
          ),
          Dimens.boxHeight24,
          _buildActionBtn(),
        ],
      );

  Widget _buildActionBtn() {
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

  Container _buildCountDetails(ProfileController logic) {
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
              value: logic.profileDetails.user!.postsCount
                  .toString()
                  .toCountingFormat(),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.followers,
              valueStyle: AppStyles.style24Bold,
              value: logic.profileDetails.user!.followersCount
                  .toString()
                  .toCountingFormat(),
              onTap: () => RouteManagement.goToFollowersListView(
                  logic.profileDetails.user!.id),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.following,
              valueStyle: AppStyles.style24Bold,
              value: logic.profileDetails.user!.followingCount
                  .toString()
                  .toCountingFormat(),
              onTap: () => RouteManagement.goToFollowingListView(
                  logic.profileDetails.user!.id),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPosts(ProfileController logic) {
    if (logic.postList.isEmpty) {
      return Center(
        child: Padding(
          padding: Dimens.edgeInsets16,
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

    return Padding(
      padding: Dimens.edgeInsets0_16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (logic.isPostLoading)
            const Center(child: NxCircularProgressIndicator())
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: logic.postList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: Dimens.eight,
                mainAxisSpacing: Dimens.eight,
              ),
              itemBuilder: (ctx, i) {
                var post = logic.postList[i];
                return PostThumbnailWidget(
                  mediaFile: post.mediaFiles!.first,
                  post: post,
                );
              },
            ),
          if (logic.isMorePostLoading || logic.postData!.hasNextPage!)
            Dimens.boxHeight16,
          if (logic.isMorePostLoading)
            const Center(child: NxCircularProgressIndicator()),
          if (!logic.isMorePostLoading && logic.postData!.hasNextPage!)
            Center(
              child: NxTextButton(
                label: 'Load more posts',
                onTap: logic.loadMore,
                labelStyle: AppStyles.style14Bold.copyWith(
                  color: ColorValues.primaryLightColor,
                ),
                padding: Dimens.edgeInsets8_0,
              ),
            ),
        ],
      ),
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
              AvatarWidget(
                avatar: logic.profileDetails.user?.avatar,
                size: Dimens.screenWidth * 0.4,
              ),
              Dimens.boxHeight40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: NxOutlinedButton(
                      width: Dimens.hundred,
                      height: Dimens.thirtySix,
                      label: 'Change',
                      borderColor:
                          Theme.of(Get.context!).textTheme.bodyText1!.color,
                      labelStyle: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                      onTap: con.chooseImage,
                    ),
                  ),
                  Dimens.boxWidth16,
                  Expanded(
                    child: NxOutlinedButton(
                      width: Dimens.hundred,
                      height: Dimens.thirtySix,
                      label: 'Remove',
                      borderColor:
                          Theme.of(Get.context!).textTheme.bodyText1!.color,
                      labelStyle: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
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

  _buildErrorBody(ProfileController logic) {
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
            onTap: logic.fetchProfileDetails,
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
