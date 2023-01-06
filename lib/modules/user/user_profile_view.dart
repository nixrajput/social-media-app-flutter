import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/count_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/image_viewer_widget.dart';
import 'package:social_media_app/global_widgets/load_more_widget.dart';
import 'package:social_media_app/global_widgets/post_thumb_widget.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
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
          child: GetBuilder<UserDetailsController>(builder: (logic) {
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
          }),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
      UserDetailsController logic, BuildContext context) {
    final user = logic.userDetails!.user;
    return NxAppBar(
      padding: Dimens.edgeInsetsDefault,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user != null ? user.uname : StringValues.profile,
              style: AppStyles.style20Bold,
            ),
            const Spacer(),
            GestureDetector(
              child: Container(
                padding: Dimens.edgeInsets6,
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.more_vert,
                  size: Dimens.twenty,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBody(UserDetailsController logic, BuildContext context) {
    if (logic.isLoading) {
      return const Expanded(
        child: Center(child: NxCircularProgressIndicator()),
      );
    } else if (logic.userDetails == null || logic.userDetails!.user == null) {
      return Expanded(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Padding(
            padding: Dimens.edgeInsetsHorizDefault,
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
        ),
      );
    }
    if (logic.userDetails!.user!.accountStatus == "deactivated") {
      return Expanded(
        child: Center(
          child: Padding(
            padding: Dimens.edgeInsetsDefault,
            child: Text(
              StringValues.deactivatedAccountWarning,
              style: AppStyles.style32Bold.copyWith(
                color: Theme.of(context).textTheme.subtitle1!.color,
              ),
              textAlign: TextAlign.center,
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
                child: AvatarWidget(avatar: user.avatar),
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
                  Icon(
                    Icons.verified,
                    color: ColorValues.primaryColor,
                    size: Dimens.twenty,
                  )
              ],
            ),
            Dimens.boxHeight2,
            Text(
              "@${user.uname}",
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(context).textTheme.subtitle1!.color,
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
                color: Theme.of(context).textTheme.subtitle1!.color,
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
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
            Dimens.boxWidth8,
            Expanded(
              child: Text(
                'Joined - ${DateFormat.yMMMd().format(user.createdAt)}',
                style: AppStyles.style12Bold.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
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
      return Theme.of(context).bottomAppBarColor;
    }

    return ColorValues.primaryColor;
  }

  Color getBorderColor(String status, BuildContext context) {
    if (status == "following" || status == "requested") {
      return Theme.of(context).bottomAppBarColor;
    }

    return ColorValues.primaryColor;
  }

  Color getLabelColor(String status, BuildContext context) {
    if (status == "following" || status == "requested") {
      return Theme.of(context).textTheme.bodyText1!.color!;
    }

    return ColorValues.whiteColor;
  }

  Widget _buildActionBtn(UserDetailsController logic, BuildContext context) {
    final user = logic.userDetails!.user!;
    if (user.followingStatus == "self") {
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

    return Row(
      children: [
        Expanded(
          child: NxOutlinedButton(
            label: getFollowStatus(user.followingStatus, context),
            bgColor: getButtonColor(user.followingStatus, context),
            borderColor: getBorderColor(user.followingStatus, context),
            onTap: () {
              if (user.followingStatus == "requested") {
                logic.cancelFollowRequest(user);
                return;
              }
              logic.followUnfollowUser(user);
            },
            padding: Dimens.edgeInsets0_8,
            width: Dimens.screenWidth,
            borderRadius: Dimens.four,
            height: Dimens.thirtySix,
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
              bgColor: Theme.of(context).bottomAppBarColor,
              width: Dimens.screenWidth,
              height: Dimens.thirtySix,
              padding: Dimens.edgeInsets0_8,
              borderRadius: Dimens.four,
              labelStyle: AppStyles.style14Normal.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
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
            StringValues.privateAccountWarning,
            style: AppStyles.style32Bold.copyWith(
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
          else if (logic.postList.isEmpty)
            Center(
              child: Padding(
                padding: Dimens.edgeInsets16,
                child: Text(
                  StringValues.noPosts,
                  style: AppStyles.style32Bold.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
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
