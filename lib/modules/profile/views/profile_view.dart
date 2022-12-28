import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/count_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/image_viewer_widget.dart';
import 'package:social_media_app/global_widgets/load_more_widget.dart';
import 'package:social_media_app/global_widgets/post_thumb_widget.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: GetBuilder<ProfileController>(
            builder: (logic) {
              return NxRefreshIndicator(
                onRefresh: logic.fetchProfileDetails,
                showProgress: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(logic, context),
                    _buildProfileBody(logic, context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProfileController logic, BuildContext context) {
    return NxAppBar(
      padding: Dimens.edgeInsetsDefault,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              logic.profileDetails!.user != null
                  ? logic.profileDetails!.user!.uname
                  : StringValues.profile,
              style: AppStyles.style20Bold,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _showSettingsBottomSheet(context),
              child: Container(
                padding: Dimens.edgeInsets6,
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.menu,
                  size: Dimens.twenty,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
          ],
        ),
      ),
      showBackBtn: true,
    );
  }

  _showSettingsBottomSheet(BuildContext context) => AppUtility.showBottomSheet(
        children: [
          /// Account
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.account_circle_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.account,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToAccountSettingsView();
            },
          ),

          /// Security
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.verified_user_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.security,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToSecuritySettingsView();
            },
          ),

          /// Privacy
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.lock_outline,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.privacy,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToPrivacySettingsView();
            },
          ),

          /// Help
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.help_outline_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.help,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToHelpSettingsView();
            },
          ),

          /// Theme
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.palette_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.theme,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToThemeSettingsView();
            },
          ),

          /// About
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.info_outline,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.about,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToAboutSettingsView();
            },
          ),

          /// Check for update
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.loop_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.checkForUpdates.toTitleCase(),
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              AppUpdateController.find.checkAppUpdate();
            },
          ),

          /// Logout
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.logout_outlined,
              size: Dimens.twentyFour,
              color: ColorValues.errorColor,
            ),
            title: Text(
              StringValues.logout,
              style: AppStyles.style16Bold.copyWith(
                color: ColorValues.errorColor,
              ),
            ),
            onTap: () async {
              AppUtility.closeBottomSheet();
              RouteManagement.goToWelcomeView();
              await AuthService.find.logout();
            },
          ),
        ],
      );

  Widget _buildProfileBody(ProfileController logic, BuildContext context) {
    if (logic.isLoading) {
      return const Expanded(
        child: Center(child: NxCircularProgressIndicator()),
      );
    } else if (logic.profileDetails == null ||
        logic.profileDetails!.user == null) {
      return Expanded(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                StringValues.userNotFoundError,
                style: AppStyles.style32Bold.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
                textAlign: TextAlign.center,
              ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      );
    }
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Dimens.boxHeight16,
            Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: _buildUserDetails(logic, context),
            ),
            Dimens.boxHeight16,
            Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: _buildCountDetails(logic, context),
            ),
            Dimens.boxHeight16,
            _buildPosts(logic, context),
            Dimens.boxHeight16,
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetails(ProfileController logic, BuildContext context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => _showProfilePictureBottomSheet(context),
                child: Hero(
                  tag: logic.profileDetails!.user!.id,
                  child: AvatarWidget(
                    avatar: logic.profileDetails!.user!.avatar,
                  ),
                ),
              ),
              Dimens.boxHeight16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${logic.profileDetails!.user!.fname} ${logic.profileDetails!.user!.lname}',
                    style: AppStyles.style18Bold,
                  ),
                  if (logic.profileDetails!.user!.isVerified) Dimens.boxWidth4,
                  if (logic.profileDetails!.user!.isVerified)
                    Icon(
                      Icons.verified,
                      color: ColorValues.primaryColor,
                      size: Dimens.twenty,
                    )
                ],
              ),
              Dimens.boxHeight2,
              Text(
                "@${logic.profileDetails!.user!.uname}",
                style: AppStyles.style14Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
            ],
          ),
          Dimens.boxHeight16,
          if (logic.profileDetails!.user!.about != null)
            NxExpandableText(text: logic.profileDetails!.user!.about!),
          if (logic.profileDetails!.user!.website != null) Dimens.boxHeight8,
          if (logic.profileDetails!.user!.website != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.link_outlined,
                  size: Dimens.sixTeen,
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
                Dimens.boxWidth8,
                InkWell(
                  onTap: () => AppUtility.openUrl(
                      Uri.parse(logic.profileDetails!.user!.website!)),
                  child: Text(
                    logic.profileDetails!.user!.website!.contains('https://') ||
                            logic.profileDetails!.user!.website!
                                .contains('http://')
                        ? Uri.parse(logic.profileDetails!.user!.website!).host
                        : logic.profileDetails!.user!.website!,
                    style: AppStyles.style13Bold.copyWith(
                      color: ColorValues.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          Dimens.boxHeight8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: Dimens.sixTeen,
                color: Theme.of(context).textTheme.subtitle1!.color,
              ),
              Dimens.boxWidth8,
              Expanded(
                child: Text(
                  'Joined - ${DateFormat.yMMMd().format(logic.profileDetails!.user!.createdAt)}',
                  style: AppStyles.style12Bold.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),
            ],
          ),
          Dimens.boxHeight16,
          _buildActionBtn(context),
        ],
      );

  Widget _buildActionBtn(BuildContext context) {
    return NxOutlinedButton(
      label: StringValues.editProfile.toTitleCase(),
      width: Dimens.screenWidth,
      height: Dimens.thirtySix,
      padding: Dimens.edgeInsets0_8,
      borderRadius: Dimens.four,
      labelStyle: AppStyles.style14Normal.copyWith(
        color: Theme.of(context).textTheme.bodyText1!.color,
      ),
      onTap: RouteManagement.goToEditProfileView,
    );
  }

  Container _buildCountDetails(ProfileController logic, BuildContext context) {
    return Container(
      width: Dimens.screenWidth,
      padding: Dimens.edgeInsets8_0,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(Dimens.four),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: NxCountWidget(
              title: StringValues.posts,
              valueStyle: AppStyles.style24Bold,
              value: logic.profileDetails!.user!.postsCount
                  .toString()
                  .toCountingFormat(),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.followers,
              valueStyle: AppStyles.style24Bold,
              value: logic.profileDetails!.user!.followersCount
                  .toString()
                  .toCountingFormat(),
              onTap: () => RouteManagement.goToFollowersListView(
                  logic.profileDetails!.user!.id),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.following,
              valueStyle: AppStyles.style24Bold,
              value: logic.profileDetails!.user!.followingCount
                  .toString()
                  .toCountingFormat(),
              onTap: () => RouteManagement.goToFollowingListView(
                  logic.profileDetails!.user!.id),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPosts(ProfileController logic, BuildContext context) {
    if (logic.postList.isEmpty) {
      return Center(
        child: Padding(
          padding: Dimens.edgeInsetsDefault,
          child: Text(
            StringValues.noPosts,
            style: AppStyles.style20Normal.copyWith(
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: Dimens.edgeInsetsHorizDefault,
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
                return PostThumbnailWidget(post: post);
              },
            ),
          LoadMoreWidget(
            loadingCondition: logic.isMorePostLoading,
            hasMoreCondition:
                logic.postData!.results != null && logic.postData!.hasNextPage!,
            loadMore: logic.loadMore,
          ),
        ],
      ),
    );
  }

  _showProfilePictureBottomSheet(BuildContext context) =>
      AppUtility.showBottomSheet(
        children: [
          /// View Profile Picture
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.image_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.view,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              Get.to(
                () => ImageViewerWidget(
                    url: ProfileController
                        .find.profileDetails!.user!.avatar!.url!),
              );
            },
          ),

          /// Change Profile Picture
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.camera_alt_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.change,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              EditProfilePictureController.find.chooseImage();
            },
          ),

          /// Remove Profile Picture
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.delete_outline,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.remove,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              EditProfilePictureController.find.removeProfilePicture();
            },
          ),
        ],
      );
}
