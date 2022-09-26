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
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/custom_shape_painter.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/post_thumb_widget.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/chat/bindings/single_chat_binding.dart';
import 'package:social_media_app/modules/chat/views/single_chat_view.dart';
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
              child: _buildWidget(logic),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildWidget(UserDetailsController logic) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
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
              _buildProfileBody(logic),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(UserDetailsController logic) {
    final user = logic.userDetails!.user;
    return NxAppBar(
      padding: Dimens.edgeInsets8_16,
      leading: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user != null ? user.uname : StringValues.profile,
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

  Widget _buildProfileBody(UserDetailsController logic) {
    if (logic.isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.boxHeight8,
          const NxCircularProgressIndicator(),
          Dimens.boxHeight8,
        ],
      );
    } else if (logic.userDetails == null || logic.userDetails!.user == null) {
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
          ],
        ),
      );
    }
    return (logic.userDetails!.user!.accountStatus == "deactivated")
        ? Center(
            child: Padding(
              padding: Dimens.edgeInsets16.copyWith(
                top: Dimens.sixtyFour,
              ),
              child: Text(
                StringValues.deactivatedAccountWarning,
                style: AppStyles.style32Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Column(
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

  Widget _buildUserDetails(UserDetailsController logic) {
    final user = logic.userDetails!.user!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            AvatarWidget(avatar: user.avatar),
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
            Dimens.boxHeight2,
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
        if (user.about != null) NxExpandableText(text: user.about!),
        Dimens.boxHeight8,
        if (logic.userDetails!.user!.website != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.link,
                size: Dimens.sixTeen,
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
              Dimens.boxWidth8,
              InkWell(
                onTap: () => AppUtility.openUrl(Uri.parse(user.website!)),
                child: Text(
                  user.website!.contains('https://') ||
                          user.website!.contains('http://')
                      ? Uri.parse(user.website!).host
                      : user.website!,
                  style: AppStyles.style13Normal.copyWith(
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
              size: Dimens.twelve,
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            Dimens.boxWidth8,
            Expanded(
              child: Text(
                'Joined - ${DateFormat.yMMMd().format(user.createdAt)}',
                style: AppStyles.style12Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
              ),
            ),
          ],
        ),
        Dimens.boxHeight24,
        _buildActionBtn(logic),
      ],
    );
  }

  String getFollowStatus(String status) {
    if (status == "following") {
      return StringValues.following;
    }

    if (status == "requested") {
      return StringValues.requested;
    }

    return StringValues.follow;
  }

  Color getButtonColor(String status) {
    if (status == "following" || status == "requested") {
      return Colors.transparent;
    }

    return ColorValues.primaryColor;
  }

  BorderStyle getBorderStyle(String status) {
    if (status == "following" || status == "requested") {
      return BorderStyle.solid;
    }

    return BorderStyle.none;
  }

  Color getLabelColor(String status) {
    if (status == "following" || status == "requested") {
      return ColorValues.primaryColor;
    }

    return ColorValues.whiteColor;
  }

  Widget _buildActionBtn(UserDetailsController logic) {
    final user = logic.userDetails!.user!;
    if (user.followingStatus == "self") {
      return NxOutlinedButton(
        label: StringValues.editProfile.toTitleCase(),
        width: Dimens.screenWidth,
        height: Dimens.thirtySix,
        padding: Dimens.edgeInsets0_8,
        borderRadius: Dimens.eight,
        borderColor: ColorValues.primaryColor,
        labelStyle: AppStyles.style14Normal.copyWith(
          color: Theme.of(Get.context!).textTheme.bodyText1!.color,
        ),
        onTap: RouteManagement.goToEditProfileView,
      );
    }

    return Row(
      children: [
        Expanded(
          child: NxOutlinedButton(
            label: getFollowStatus(user.followingStatus),
            bgColor: getButtonColor(user.followingStatus),
            borderColor: ColorValues.primaryColor,
            borderStyle: getBorderStyle(user.followingStatus),
            onTap: () {
              if (user.followingStatus == "requested") {
                logic.cancelFollowRequest(user);
                return;
              }
              logic.followUnfollowUser(user);
            },
            padding: Dimens.edgeInsets0_8,
            width: Dimens.screenWidth,
            height: Dimens.thirtySix,
            labelStyle: AppStyles.style14Normal.copyWith(
              color: getLabelColor(user.followingStatus),
            ),
          ),
        ),
        if (user.publicKeys != null) Dimens.boxWidth16,
        if (user.publicKeys != null)
          Expanded(
            child: NxOutlinedButton(
              label: StringValues.message.toTitleCase(),
              width: Dimens.screenWidth,
              height: Dimens.thirtySix,
              padding: Dimens.edgeInsets0_8,
              borderRadius: Dimens.eight,
              borderColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
              labelStyle: AppStyles.style14Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
              onTap: () => Get.to(
                binding: SingleChatBinding(),
                () => SingleChatView(
                  receiverId: user.id,
                  receiverUname: user.uname,
                  serverKey: user.publicKeys,
                ),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 500),
              ),
            ),
          )
      ],
    );
  }

  Container _buildCountDetails(UserDetailsController logic) {
    final user = logic.userDetails!.user!;
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

  Widget _buildPosts(UserDetailsController logic) {
    final user = logic.userDetails!.user!;

    if (user.isPrivate &&
        (user.followingStatus != "following" &&
            user.followingStatus != "self")) {
      return Center(
        child: Padding(
          padding: Dimens.edgeInsets16,
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

    return Padding(
      padding: Dimens.edgeInsets0_16,
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
                    color: Theme.of(Get.context!).textTheme.subtitle1!.color,
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
                      onTap: logic.loadMoreUserPosts,
                      labelStyle: AppStyles.style14Bold.copyWith(
                        color: ColorValues.primaryLightColor,
                      ),
                      padding: Dimens.edgeInsets8_0,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
