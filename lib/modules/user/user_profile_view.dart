import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/enums.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/app_widgets/app_filled_btn.dart';
import 'package:social_media_app/app_widgets/app_outlined_btn.dart';
import 'package:social_media_app/app_widgets/avatar_widget.dart';
import 'package:social_media_app/app_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/app_widgets/count_widget.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/custom_list_tile.dart';
import 'package:social_media_app/app_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/app_widgets/expandable_text_widget.dart';
import 'package:social_media_app/app_widgets/image_viewer_widget.dart';
import 'package:social_media_app/app_widgets/load_more_widget.dart';
import 'package:social_media_app/app_widgets/post_thumb_widget.dart';
import 'package:social_media_app/app_widgets/verified_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/user/user_details_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: GetBuilder<UserDetailsController>(
            builder: (logic) {
              if (logic.isLoading) {
                return const Center(child: NxCircularProgressIndicator());
              }

              return NxRefreshIndicator(
                onRefresh: logic.fetchUserDetailsById,
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

  void _showHeaderOptionBottomSheet(
      BuildContext context, UserDetailsController logic) {
    final currentUser = ProfileController.find.profileDetails!.user!;
    AppUtility.showBottomSheet(
      children: [
        /// Block User

        if (logic.userDetails!.user!.id != currentUser.id &&
            !logic.userDetails!.user!.isBlockedByYou &&
            !logic.userDetails!.user!.isBlockedByUser)
          NxListTile(
            bgColor: ColorValues.transparent,
            padding: Dimens.edgeInsets12,
            showBorder: false,
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToBlockUserView(
                logic.userDetails!.user!.id,
                logic.userDetails!.user!.uname,
                logic.userDetails!.user!.avatar!,
              );
            },
            leading: Icon(
              Icons.block,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              size: Dimens.twentyFour,
            ),
            title: Text(
              StringValues.block,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),

        /// Report User

        if (logic.userDetails!.user!.id != currentUser.id &&
            !logic.userDetails!.user!.isBlockedByYou &&
            !logic.userDetails!.user!.isBlockedByUser)
          NxListTile(
            bgColor: ColorValues.transparent,
            padding: Dimens.edgeInsets12,
            showBorder: false,
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToReportIssueView(
                logic.userDetails!.user!.id,
                ReportType.user,
              );
            },
            leading: Icon(
              Icons.report,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              size: Dimens.twentyFour,
            ),
            title: Text(
              StringValues.report,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),

        /// Share User Profile

        NxListTile(
          bgColor: ColorValues.transparent,
          padding: Dimens.edgeInsets12,
          showBorder: false,
          onTap: () {
            AppUtility.closeBottomSheet();
            AppUtility.showShareDialog(
              context,
              '${StringValues.websiteUrl}/user/${logic.userDetails!.user!.id}',
            );
          },
          leading: Icon(
            Icons.share,
            color: Theme.of(context).textTheme.bodyLarge!.color,
            size: Dimens.twentyFour,
          ),
          title: Text(
            StringValues.share,
            style: AppStyles.style16Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(
      UserDetailsController logic, BuildContext context) {
    final user = logic.userDetails!.user!;
    final currentUser = ProfileController.find.profileDetails!.user!;
    return NxAppBar(
      padding: Dimens.edgeInsetsDefault,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.uname,
              style: AppStyles.style20Bold,
            ),
            const Spacer(),
            if (user.id != currentUser.id &&
                !user.isBlockedByYou &&
                !user.isBlockedByUser)
              GestureDetector(
                onTap: () => _showHeaderOptionBottomSheet(context, logic),
                child: _buildMoreIconBtn(context),
              ),
          ],
        ),
      ),
    );
  }

  Container _buildMoreIconBtn(BuildContext context) {
    return Container(
      padding: Dimens.edgeInsets6,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Icon(
        Icons.more_vert,
        size: Dimens.twenty,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }

  Widget _buildProfileBody(UserDetailsController logic, BuildContext context) {
    /// If user not found
    if (logic.userDetails == null || logic.userDetails!.user == null) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: Dimens.edgeInsetsDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringValues.userNotFoundError,
                  textAlign: TextAlign.center,
                  style: AppStyles.style24Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                Dimens.boxHeight16,
                NxFilledButton(
                  label: StringValues.back,
                  padding: Dimens.edgeInsetsDefault,
                  labelStyle: AppStyles.style14Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  onTap: RouteManagement.goToBack,
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// If user is deactivated
    else if (logic.userDetails!.user!.accountStatus == "deactivated") {
      return Expanded(
        child: Center(
          child: Padding(
            padding: Dimens.edgeInsetsDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '@${logic.userDetails!.user!.uname}',
                        style: AppStyles.style24Bold.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      TextSpan(
                        text: ' ${StringValues.hasDeactivatedTheirAccount}',
                        style: AppStyles.style24Normal.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.boxHeight4,
                Text(
                  StringValues.deactivatedAccountWarningDesc,
                  textAlign: TextAlign.center,
                  style: AppStyles.style16Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
                Dimens.boxHeight16,
                NxFilledButton(
                  label: StringValues.learnMore,
                  padding: Dimens.edgeInsetsDefault,
                  labelStyle: AppStyles.style14Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// If current user is blocked by the user
    else if (logic.userDetails!.user!.isBlockedByUser) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: Dimens.edgeInsetsDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '@${logic.userDetails!.user!.uname}',
                        style: AppStyles.style24Bold.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      TextSpan(
                        text: ' ${StringValues.blockedYou}',
                        style: AppStyles.style24Normal.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.boxHeight4,
                Text(
                  StringValues.blockedAccountWarningDesc,
                  textAlign: TextAlign.center,
                  style: AppStyles.style16Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
                Dimens.boxHeight16,
                NxFilledButton(
                  label: StringValues.learnMore,
                  padding: Dimens.edgeInsetsDefault,
                  labelStyle: AppStyles.style14Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// if user is blocked by current user
    else if (logic.userDetails!.user!.isBlockedByYou) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: Dimens.edgeInsetsDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${StringValues.youBlocked} ',
                        style: AppStyles.style24Normal.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      TextSpan(
                        text: '@${logic.userDetails!.user!.uname}',
                        style: AppStyles.style24Bold.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.boxHeight4,
                Text(
                  StringValues.blockedAccountWarningDesc,
                  textAlign: TextAlign.center,
                  style: AppStyles.style16Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
                Dimens.boxHeight16,
                NxFilledButton(
                  label: StringValues.unblock,
                  padding: Dimens.edgeInsetsDefault,
                  labelStyle: AppStyles.style14Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
    } else {
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
  }

  Widget _buildUserDetails(UserDetailsController logic, BuildContext context) {
    final user = logic.userDetails!.user!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if (user.avatar == null ||
                    user.avatar!.url == null ||
                    user.avatar!.url!.isEmpty) {
                  return;
                }
                Get.to(() => ImageViewerWidget(url: user.avatar!.url!));
              },
              child: Hero(
                tag: user.id,
                child: AvatarWidget(
                  avatar: user.avatar,
                  size: Dimens.screenWidth * 0.25,
                ),
              ),
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
                  VerifiedWidget(
                    verifiedCategory: user.verifiedCategory!,
                  ),
              ],
            ),
            Dimens.boxHeight2,
            Text(
              "@${user.uname}",
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(context).textTheme.titleMedium!.color,
              ),
            ),
          ],
        ),
        Dimens.boxHeight8,
        if (user.about != null) Dimens.boxHeight8,
        if (user.about != null) NxExpandableText(text: user.about!),
        Dimens.boxHeight8,
        if (logic.userDetails!.user!.website != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.link,
                size: Dimens.sixTeen,
                color: Theme.of(context).textTheme.titleMedium!.color,
              ),
              Dimens.boxWidth8,
              InkWell(
                onTap: () => AppUtility.openUrl(Uri.parse(user.website!)),
                child: Text(
                  user.website!.contains('https://') ||
                          user.website!.contains('http://')
                      ? Uri.parse(user.website!).host
                      : user.website!,
                  style: AppStyles.style13Bold.copyWith(
                    color: ColorValues.linkColor,
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
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            Dimens.boxWidth8,
            Expanded(
              child: Text(
                'Joined - ${DateFormat.yMMMd().format(user.createdAt)}',
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
              ),
            ),
          ],
        ),
        Dimens.boxHeight16,
        _buildActionBtn(logic, context),
      ],
    );
  }

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

  Color getBorderColor(String status, BuildContext context) {
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

  Widget _buildActionBtn(UserDetailsController logic, BuildContext context) {
    final user = logic.userDetails!.user!;
    if (user.followingStatus == "self") {
      return NxOutlinedButton(
        label: StringValues.editProfile.toTitleCase(),
        width: Dimens.screenWidth,
        padding: Dimens.edgeInsets8,
        borderRadius: Dimens.four,
        borderWidth: Dimens.pointEight,
        labelStyle: AppStyles.style14Normal.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        onTap: RouteManagement.goToEditProfileView,
      );
    }

    return Row(
      children: [
        Expanded(
          child: NxFilledButton(
            label: getFollowStatus(user.followingStatus, context),
            bgColor: getButtonColor(user.followingStatus, context),
            onTap: () {
              if (user.followingStatus == "requested") {
                logic.cancelFollowRequest(user);
                return;
              }
              logic.followUnfollowUser(user);
            },
            padding: Dimens.edgeInsets8,
            width: Dimens.screenWidth,
            borderRadius: Dimens.four,
            labelStyle: AppStyles.style14Normal.copyWith(
              color: getLabelColor(user.followingStatus, context),
            ),
          ),
        ),
        if (!user.isPrivate ||
            (user.isPrivate && user.followingStatus == "following"))
          Dimens.boxWidth12,
        if (!user.isPrivate ||
            (user.isPrivate && user.followingStatus == "following"))
          Expanded(
            child: NxFilledButton(
              label: StringValues.message.toTitleCase(),
              bgColor: Theme.of(context).dividerColor,
              width: Dimens.screenWidth,
              padding: Dimens.edgeInsets8,
              borderRadius: Dimens.four,
              labelStyle: AppStyles.style14Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              onTap: () => RouteManagement.goToChatDetailsView(
                User(
                  id: user.id,
                  fname: user.fname,
                  lname: user.lname,
                  email: user.email,
                  uname: user.uname,
                  avatar: user.avatar,
                  isPrivate: user.isPrivate,
                  followingStatus: user.followingStatus,
                  accountStatus: user.accountStatus,
                  isVerified: user.isVerified,
                  verifiedCategory: user.verifiedCategory,
                  isBlockedByYou: user.isBlockedByYou,
                  isBlockedByUser: user.isBlockedByUser,
                  createdAt: user.createdAt,
                  updatedAt: user.updatedAt,
                ),
              ),
            ),
          )
      ],
    );
  }

  Container _buildCountDetails(
      UserDetailsController logic, BuildContext context) {
    final user = logic.userDetails!.user!;
    return Container(
      width: Dimens.screenWidth,
      padding: Dimens.edgeInsets8_0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.four),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: Dimens.one,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: NxCountWidget(
              title: StringValues.posts,
              valueStyle: AppStyles.style24Bold,
              value: user.postsCount.toString().toCountingFormat(),
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.followers,
              valueStyle: AppStyles.style24Bold,
              value: user.followersCount.toString().toCountingFormat(),
              onTap: () {
                if (user.isPrivate &&
                    (user.followingStatus != "following" &&
                        user.followingStatus != "self")) {
                  return;
                }
                RouteManagement.goToFollowersListView(user.id);
              },
            ),
          ),
          Expanded(
            child: NxCountWidget(
              title: StringValues.following,
              valueStyle: AppStyles.style24Bold,
              value: user.followingCount.toString().toCountingFormat(),
              onTap: () {
                if (user.isPrivate &&
                    (user.followingStatus != "following" &&
                        user.followingStatus != "self")) {
                  return;
                }
                RouteManagement.goToFollowingListView(user.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPosts(UserDetailsController logic, BuildContext context) {
    final user = logic.userDetails!.user!;

    if (user.isPrivate &&
        (user.followingStatus != "following" &&
            user.followingStatus != "self")) {
      return Center(
        child: Padding(
          padding: Dimens.edgeInsetsDefault,
          child: Text(
            StringValues.privateAccountWarningDesc,
            style: AppStyles.style24Bold.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
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
          else if (logic.postList.isEmpty)
            Center(
              child: Padding(
                padding: Dimens.edgeInsets16,
                child: Text(
                  StringValues.noPosts,
                  style: AppStyles.style24Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logic.postList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
                  hasMoreCondition: logic.postData!.results != null &&
                      logic.postData!.hasNextPage!,
                  loadMore: logic.loadMoreUserPosts,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
